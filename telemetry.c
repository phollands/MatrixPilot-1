#include "libUDB.h"
#include "defines.h"
#include "definesRmat.h"
#include <stdio.h>
#include <stdarg.h>


union intbb voltage_milis = {0} ;
union intbb voltage_temp ;

void sio_newMsg(unsigned char);
void sio_voltage_low( unsigned char inchar ) ;
void sio_voltage_high( unsigned char inchar ) ;
void (* sio_parse ) ( unsigned char inchar ) = &sio_newMsg ;


#define SERIAL_BUFFER_SIZE 256
char serial_buffer[SERIAL_BUFFER_SIZE] ;
int sb_index = 0 ;
int end_index = 0 ;



void init_serial()
{
#if ( SERIAL_OUTPUT_FORMAT == SERIAL_OSD_REMZIBI )
	// For the Remzibi OSD, the 'extra' serial port is set to 9600 baud
	udb_serial_set_rate(UDB_BAUD_9600) ;
#else
	// Otherwise, the baud rate is set to 19200
	udb_serial_set_rate(UDB_BAUD_19200) ;
#endif
	return ;
}


////////////////////////////////////////////////////////////////////////////////
// 
// Receive Serial Commands
//

void udb_serial_callback_received_char(char rxchar)
{
	(* sio_parse) ( rxchar ) ; // parse the input byte
	return ;
}


void sio_newMsg( unsigned char inchar )
{
	if ( inchar == 'V' )
	{
		sio_parse = &sio_voltage_high ;
	}
	else
	{
		// error ?
	}
	return ;
}


void sio_voltage_low( unsigned char inchar )
{
	voltage_temp._.B0 = inchar ;
	voltage_temp.BB = voltage_temp.BB * 2 ; // convert to voltage
	voltage_milis.BB = voltage_temp.BB ;
	sio_parse = &sio_newMsg ;
	return ;
}


void sio_voltage_high( unsigned char inchar )
{
	voltage_temp.BB = 0 ; // initialize our temp variable
	voltage_temp._.B1 = inchar ;
	sio_parse = &sio_voltage_low ;
	return ;
}


////////////////////////////////////////////////////////////////////////////////
// 
// Output Serial Data
//

// add this text to the output buffer
void serial_output( char* format, ... )
{
	va_list arglist ;
	unsigned char txchar ;
	
	va_start(arglist, format) ;
	
	int start_index = end_index ;
	int remaining = SERIAL_BUFFER_SIZE - start_index ;
	
	if (remaining > 1)
	{
		int wrote = vsnprintf( (char*)(&serial_buffer[start_index]), (size_t)remaining, format, arglist) ;
		end_index = start_index + wrote;
	}
	
	if (sb_index == 0)
	{
		udb_serial_start_sending();
	}
	
	va_end(arglist);
	
	return ;
}


char udb_serial_callback_sent_char(void)
{
	char txchar = serial_buffer[ sb_index++ ] ;
	
	if ( txchar )
	{
		return txchar ;
	}
	else
	{
		sb_index = 0 ;
		end_index = 0 ;
	}
	
	return 0;
}


#if ( SERIAL_OUTPUT_FORMAT == SERIAL_DEBUG )

void serial_output_4hz( void )
{
	serial_output("lat: %li, long: %li, alt: %li\r\nrmat: %i, %i, %i, %i, %i, %i, %i, %i, %i\r\n" ,
		lat_gps.WW , long_gps.WW , alt_sl_gps.WW ,
		rmat[0] , rmat[1] , rmat[2] ,
		rmat[3] , rmat[4] , rmat[5] ,
		rmat[6] , rmat[7] , rmat[8]  ) ;
	return ;
}


#elif ( SERIAL_OUTPUT_FORMAT == SERIAL_ARDUSTATION )

#define BYTECIR_TO_DEGREE 92160		// (360.0/256 * 2^16)
int skip = 0 ;

extern signed char bearing_to_origin ;
extern int desiredHeight, waypointIndex ;
extern signed char desired_dir_waypoint ;

void serial_output_4hz( void )
{
	unsigned int mode ;
	struct relative2D matrix_accum ;
	union longbbbb accum ;
	int desired_dir_waypoint_deg ;  // desired_dir_waypoint converted to a bearing (0-360)
	
	long earth_pitch ;		// pitch in binary angles ( 0-255 is 360 degreres)
	long earth_roll ;		// roll of the plane with respect to earth frame
	//long earth_yaw ;		// yaw with respect to earth frame
	
	accum.WW  = ( desired_dir_waypoint * BYTECIR_TO_DEGREE ) + 32768 ;
	desired_dir_waypoint_deg  = accum._.W1 - 90 ; // "Convert UAV DevBoad Earth" to Compass Bearing
	if ( desired_dir_waypoint_deg < 0 ) desired_dir_waypoint_deg += 360 ; 

	if (flags._.GPS_steering == 0 && flags._.pitch_feedback == 0)
		mode = 1 ;
	else if (flags._.GPS_steering == 0 && flags._.pitch_feedback == 1)
		mode = 2 ;
	else if (flags._.GPS_steering == 1 && flags._.pitch_feedback == 1 && udb_radio_on == 1)
		mode = 3 ;
	else if (flags._.GPS_steering == 1 && flags._.pitch_feedback == 1 && udb_radio_on == 0)
		mode = 0 ;
	else
		mode = 99 ; // Unknown
	
	//  Roll
	//  Earth Frame of Reference
	matrix_accum.x = rmat[8] ;
	matrix_accum.y = rmat[6] ;
	earth_roll = rect_to_polar(&matrix_accum) ;					// binary angle (0 - 256 = 360 degrees)
	earth_roll = (-earth_roll * BYTECIR_TO_DEGREE) >> 16 ;		// switch polarity, convert to -180 - 180 degrees
	
	//  Pitch
	//  Earth Frame of Reference
	//  Note that we are using the matrix_accum.x
	//  left over from previous rect_to_polar in this calculation.
	//  so this Pitch calculation must follow the Roll calculation
	matrix_accum.y = rmat[7] ;
	earth_pitch = rect_to_polar(&matrix_accum) ;				// binary angle (0 - 256 = 360 degrees)
	earth_pitch = (-earth_pitch * BYTECIR_TO_DEGREE) >> 16 ;	// switch polarity, convert to -180 - 180 degrees
	
	// Yaw
	// Earth Frame of Reference
	// Ardustation does not use yaw in degrees
	// matrix_accum.x = rmat[4] ;
	// matrix_accum.y = rmat[1] ;
	// earth_yaw = rect_to_polar(&matrix_accum) ;				// binary angle (0 - 256 = 360 degrees)
	// earth_yaw = (earth_yaw * BYTECIR_TO_DEGREE) >> 16 ;		// switch polarity, convert to -180 - 180 degrees
	
	
	// The Ardupilot GroundStation protocol is mostly documented here:
	//    http://diydrones.com/profiles/blogs/ardupilot-telemetry-protocol
	
	if (++skip < 4)
	{
		serial_output("+++THH:%i,RLL:%li,PCH:%li,STT:%i,***\r\n",
			(int)((udb_pwOut[THROTTLE_OUTPUT_CHANNEL] - udb_pwTrim[THROTTLE_OUTPUT_CHANNEL])/20),
			earth_roll, earth_pitch,
			mode
		) ;
	}
	else
	{
		serial_output("!!!LAT:%li,LON:%li,SPD:%.2f,CRT:%.2f,ALT:%li,ALH:%i,CRS:%.2f,BER:%i,WPN:%i,DST:%i,BTV:%.2f***\r\n"
					  "+++THH:%i,RLL:%li,PCH:%li,STT:%i,***\r\n",
			lat_gps.WW / 10 , long_gps.WW / 10 , (float)(sog_gps.BB / 100.0), (float)(climb_gps.BB / 100.0),
			(alt_sl_gps.WW - alt_origin.WW) / 100, desiredHeight, (float)(cog_gps.BB / 100.0), desired_dir_waypoint_deg,
			waypointIndex, tofinish_line, (float)(voltage_milis.BB / 100.0), 
			(int)((udb_pwOut[THROTTLE_OUTPUT_CHANNEL] - udb_pwTrim[THROTTLE_OUTPUT_CHANNEL])/20),
			earth_roll, earth_pitch,
			mode
		) ;
		skip = 0 ;
	}
	
	return ;
}


#elif ( SERIAL_OUTPUT_FORMAT == SERIAL_UDB || SERIAL_OUTPUT_FORMAT == SERIAL_UDB_EXTRA )

int telemetry_counter = 6 ;
int skip = 0 ;

extern int waypointIndex, air_speed_magnitude ;

void serial_output_4hz( void )
{
	union longbbbb accum ;
	
	// Only run through this function once per second, by skipping all but every N runs through it.
	// Saves CPU and XBee power.
	if (++skip < 4) return ;
	skip = 0 ;
	
	switch (telemetry_counter)
	{
		// The first lines of telemetry contain info about the compile-time settings from the options.h file
		case 6:
			serial_output("F11:WIND_EST=%i:GPS_TYPE=%i:\r\n",
				WIND_ESTIMATION,GPS_TYPE);
			break;
		case 5:
			serial_output("F4:R_STAB=%i:P_STAB=%i:Y_STAB_R=%i:Y_STAB_A=%i:AIL_NAV=%i:RUD_NAV=%i:AH_STAB=%i:AH_WP=%i:RACE=%i:\r\n",
				ROLL_STABILIZATION, PITCH_STABILIZATION, YAW_STABILIZATION_RUDDER, YAW_STABILIZATION_AILERON,
				AILERON_NAVIGATION, RUDDER_NAVIGATION, ALTITUDEHOLD_STABILIZED, ALTITUDEHOLD_WAYPOINT, RACING_MODE) ;
			break ;
		case 4:
			serial_output("F5:YAWKP_A=%5.3f:YAWKD_A=%5.3f:ROLLKP=%5.3f:ROLLKD=%5.3f:A_BOOST=%3.1f:\r\n",
				YAWKP_AILERON, YAWKD_AILERON, ROLLKP, ROLLKD, AILERON_BOOST ) ;
			break ;
		case 3:
			serial_output("F6:P_GAIN=%5.3f:P_KD=%5.3f:RUD_E_MIX=%5.3f:ROL_E_MIX=%5.3f:E_BOOST=%3.1f:\r\n",
				PITCHGAIN, PITCHKD, RUDDER_ELEV_MIX, ROLL_ELEV_MIX, ELEVATOR_BOOST) ;
			break ;
		case 2:
			serial_output("F7:Y_KP_R=%5.4f:Y_KD_R=%5.3f:RUD_BOOST=%5.3f:RTL_PITCH_DN=%5.3f:\r\n",
				YAWKP_RUDDER, YAWKD_RUDDER, RUDDER_BOOST, RTL_PITCH_DOWN) ;
			break ;
		case 1:
			serial_output("F8:H_MAX=%6.1f:H_MIN=%6.1f:MIN_THR=%3.2f:MAX_THR=%3.2f:PITCH_MIN_THR=%4.1f:PITCH_MAX_THR=%4.1f:PITCH_ZERO_THR=%4.1f:\r\n",
				HEIGHT_TARGET_MAX, HEIGHT_TARGET_MIN, ALT_HOLD_THROTTLE_MIN, ALT_HOLD_THROTTLE_MAX,
				ALT_HOLD_PITCH_MIN, ALT_HOLD_PITCH_MAX, ALT_HOLD_PITCH_HIGH) ;
			break ;
		default:
			// F2 below means "Format Revision 2: and is used by a Telemetry parser to invoke the right pattern matching
			// If you change this output format, then change F2 to F3 or F4, etc - to mark a new revision of format.
			// F2 is a compromise between easy reading of raw data in a file and not droppping chars in transmission.
			
#if ( SERIAL_OUTPUT_FORMAT == SERIAL_UDB )
			serial_output("F2:T%li:S%d%d%d:N%li:E%li:A%li:W%i:a%i:b%i:c%i:d%i:e%i:f%i:g%i:h%i:i%i:c%u:s%i:cpu%u:bmv%i:"
				"as%i:wvx%i:wvy%i:wvz%i:\r\n",
				tow, udb_radio_on, flags._.nav_capable, flags._.GPS_steering,
				lat_gps.WW , long_gps.WW , alt_sl_gps.WW, waypointIndex,
				rmat[0] , rmat[1] , rmat[2] ,
				rmat[3] , rmat[4] , rmat[5] ,
				rmat[6] , rmat[7] , rmat[8] ,
				(unsigned int)cog_gps.BB, sog_gps.BB, udb_cpu_load(), voltage_milis.BB,
				air_speed_magnitude, estimatedWind[0], estimatedWind[1],estimatedWind[2]) ;
				
#elif ( SERIAL_OUTPUT_FORMAT == SERIAL_UDB_EXTRA )
			serial_output("F2:T%li:S%d%d%d:N%li:E%li:A%li:W%i:a%i:b%i:c%i:d%i:e%i:f%i:g%i:h%i:i%i:c%u:s%i:cpu%u:bmv%i:"
				"as%i:wvx%i:wvy%i:wvz%i:ma%i:mb%i:mc%i:svs%i:hd%i:\r\n",
				tow, flags._.radio_on, flags._.nav_capable, flags._.GPS_steering,
				lat_gps.WW , long_gps.WW , alt_sl_gps.WW, waypointIndex,
				rmat[0] , rmat[1] , rmat[2] ,
				rmat[3] , rmat[4] , rmat[5] ,
				rmat[6] , rmat[7] , rmat[8] ,
				(unsigned int)cog_gps.BB, sog_gps.BB, accum._.W1, voltage_milis.BB,
				air_speed_magnitude, estimatedWind[0], estimatedWind[1],estimatedWind[2],
				magFieldEarth[0],magFieldEarth[1],magFieldEarth[2],
				svs, hdop ) ;
#endif
			return ;
	}
	telemetry_counter-- ;
	return ;
}


#elif ( SERIAL_OUTPUT_FORMAT == SERIAL_OSD_REMZIBI )

void serial_output_4hz( void )
{
	// TODO: Output interesting information for OSD.
	// But first we'll have to implement a buffer for passthrough characters to avoid
	// output corruption, or generate NMEA ourselves here.
	return ;
}

#elif ( SERIAL_OUTPUT_FORMAT == SERIAL_MAGNETOMETER )

extern void rxMagnetometer(void) ;
extern int udb_magFieldBody[3] ;
extern unsigned char magreg[6] ;
extern int magFieldEarth[3] ;
extern int udb_magOffset[3] ;
extern int magGain[3] ;
extern int offsetDelta[3] ;
extern int rawMagCalib[3] ;
extern int magMessage ;

extern union longww HHIntegral ;

#define OFFSETSHIFT 1

extern int I2ERROR ;
extern int I2messages ;
extern int I2interrupts ;
/*
void serial_output_4hz( void )
{
	serial_output("MagMessage: %i\r\nI2CCON: %X, I2CSTAT: %X, I2ERROR: %X\r\nMessages: %i\r\nInterrupts: %i\r\n\r\n" ,
		magMessage ,
		I2CCON , I2CSTAT , I2ERROR ,
		I2messages, I2interrupts ) ;
	return ;
}
*/

void serial_output_4hz( void )
{
	serial_output("MagOffset: %i, %i, %i\r\nMagBody: %i, %i, %i\r\nMagEarth: %i, %i, %i\r\nMagGain: %i, %i, %i\r\nCalib: %i, %i, %i\r\nMagMessage: %i\r\nTotalMsg: %i\r\nI2CCON: %X, I2CSTAT: %X, I2ERROR: %X\r\n\r\n" ,
		udb_magOffset[0]>>OFFSETSHIFT , udb_magOffset[1]>>OFFSETSHIFT , udb_magOffset[2]>>OFFSETSHIFT ,
		udb_magFieldBody[0] , udb_magFieldBody[1] , udb_magFieldBody[2] ,
		magFieldEarth[0] , magFieldEarth[1] , magFieldEarth[2] ,
		magGain[0] , magGain[1] , magGain[2] ,
		rawMagCalib[0] , rawMagCalib[1] , rawMagCalib[2] ,
		magMessage ,
		I2messages ,
		I2CCON , I2CSTAT , I2ERROR ) ;
	return ;
}


#else // If SERIAL_OUTPUT_FORMAT is set to SERIAL_NONE, or is not set

void serial_output_4hz( void )
{
	return ;
}

#endif
