#include "p30f4011.h"
#include "options.h"
#include "controlGains.h"


// Max inputs and outputs
#define MAX_INPUTS	5
#define MAX_OUTPUTS	6


void init_clock(void) ;
void set_gps2(void) ;
void set_bin(void) ;
void set_baud(void) ;
void init_T3(void) ;
void init_ADC(void) ;
void init_pwm(void) ;
void init_capture(void) ;
void init_GPS2(void) ;
void init_USART1(void) ;
void init_states(void) ;

int cosine ( signed char angle ) ;
int sine ( signed char angle ) ;

void navigate(void) ;

void state_machine(void) ;
void filterInputs(void) ;

void yawCntrl(void) ;
void rollCntrl(void) ;
void pitchCntrl(void) ;
void altitudeCntrl(void) ;
void cameraCntrl(void) ;
void mixServos(void) ;

int pulsesat(long) ;

extern int rise[MAX_INPUTS+1] ;	// rising edge clock capture for radio inputs
extern int pwIn[MAX_INPUTS+1] ;	// pulse widths of radio inputs
extern int pwTrim[MAX_INPUTS+1] ;	// initial pulse widths for trimming
extern int pwOut[MAX_OUTPUTS+1] ;	// pulse widths for servo outputs

extern int pitch_control, roll_control, yaw_control, altitude_control ;
extern long pitchboost ;
extern long yawboost ;

extern struct ADchannel xaccel, yaccel , zaccel ;	// x, y, and z accelerometer channels
extern struct ADchannel xrate , yrate, zrate ; 		// x, y, and z gyro channels
extern struct ADchannel vref ;						// reference voltage

extern int dutycycle ;	// used to compute PWM duty cycle
extern int firstsamp ;	// used on startup to detect first A/D sample
extern int calibcount ;	// number of PWM pulses before control is turned on

extern union longbbbb lat_gps_ , long_gps_ , alt_sl_gps_ ;
extern union intbb    nav_valid_ , nav_type_ , sog_gps_ , cog_gps_ , climb_gps_ ;
extern unsigned char  hdop_ ;
extern union longbbbb xpg_ , ypg_ , zpg_ ;
extern union intbb    xvg_ , yvg_ , zvg_ ;
extern unsigned char  mode1_ , mode2_ , svs_ ;

extern union longbbbb lat_gps , long_gps , alt_sl_gps ;
extern union intbb    nav_valid , nav_type , sog_gps , cog_gps , climb_gps ;
extern unsigned char  hdop ;
extern union longbbbb xpg , ypg , zpg ;
extern union intbb    xvg , yvg , zvg ;
extern unsigned char  mode1 , mode2 , svs ;

extern unsigned char  	lat_cir ;
extern int				cos_lat ;

extern union longbbbb lat_origin , long_origin , alt_origin ;
extern union longbbbb x_origin , y_origin , z_origin ;

extern signed char	desired_dir , actual_dir ;

extern int height ;

extern int waggle, calib_timer, standby_timer, pulsesselin ;
extern int gps_data_age;

extern union longww throttleFiltered ;
extern int pitchAltitudeAdjust ;

extern signed char GPS_pitch  ;

extern int velocity_magnitude ;
extern int forward_acceleration  ;
extern int velocity_previous  ;


// Channel numbers on the board, mapped to positions in the pulse width arrays.
#define CHANNEL_UNUSED	0	// pwIn[0], pwOut[0], etc. are not used, but allow lazy code everywhere else  :)
#define CHANNEL_1		1
#define CHANNEL_2		2
#define CHANNEL_3		3
#define CHANNEL_4		4
#define CHANNEL_5		5
#define CHANNEL_6		6


// Choose the type of air frame by setting AIRFRAME_TYPE in options.h
// See options.h for a description of each type
#define AIRFRAME_STANDARD			0
#define AIRFRAME_VTAIL				1
#define AIRFRAME_DELTA				2
#define AIRFRAME_STANDARD_NOAIL		3
#define AIRFRAME_VTAIL_NOAIL		4
#define AIRFRAME_HELI				5

#define USE_RUDDER_NAV_CONTROL		(AIRFRAME_TYPE == AIRFRAME_STANDARD_NOAIL || AIRFRAME_TYPE == AIRFRAME_VTAIL_NOAIL)

// Pin locations of the hardware toggle switches
#define HW_SWITCH_1			(PORTDbits.RD3)
#define HW_SWITCH_2			(PORTDbits.RD2)
#define HW_SWITCH_3			(PORTFbits.RF6)


// LED pins
#define LED_RED				LATFbits.LATF0
#define LED_GREEN			LATFbits.LATF1
#define LED_RED_DO_TOGGLE	__builtin_btg( (unsigned int*)&LATF , 0 )
#define LED_GREEN_DO_TOGGLE	__builtin_btg( (unsigned int*)&LATF , 1 )

// LED states
#define LED_ON		0
#define LED_OFF		1


// If GPS data has not been received for this many state machine cycles, consider the GPS lock to be lost.
#define GPS_DATA_MAX_AGE	3


#define REVERSE_IF_NEEDED(NEEDS_REVERSING, VALUE)		((NEEDS_REVERSING) ? (-(VALUE)) : (VALUE))
