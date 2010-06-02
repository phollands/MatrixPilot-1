#include "libDCM.h"
#include "defines.h"

//	Compute actual and desired courses.
//	Actual course is simply the scaled GPS course over ground information.
//	Desired course is a "return home" course, which is simply the negative of the
//	angle of the vector from the origin to the location of the plane.

//	The origin is recorded as the location of the plane during power up of the control.

const int yawkpail = YAWKP_AILERON*RMAX ;
const int yawkprud = YAWKP_RUDDER*RMAX ;

extern signed char desired_dir_waypoint ;


void setup_origin(void)
{
#if ( USE_FIXED_ORIGIN == 1 )
		struct absolute2D origin = FIXED_ORIGIN_LOCATION ;
		dcm_set_origin_location(origin.x, origin.y, alt_sl_gps.WW) ;
#else
		dcm_set_origin_location(long_gps.WW, lat_gps.WW, alt_sl_gps.WW) ;
#endif
}


void dcm_callback_gps_location_updated(void)
{
	if ( flags._.save_origin )
	{
		//	capture origin information during power up. much of this is not actually used for anything,
		//	but is saved in case you decide to extend this code.
		flags._.save_origin = 0 ;
		setup_origin() ;
	}
	
	processwaypoints() ;
	
//	Ideally, navigate should take less than one second. For MatrixPilot, navigation takes only
//	a few milliseconds.
	
//	If you rewrite navigation to perform some rather ambitious calculations, perhaps using floating
//	point, matrix inversions, Kalman filters, etc., you will not cause a stack overflow if you
//	take more than 1 second, the interrupt handler will simply skip some of the navigation passes.
	
	return ;
}


// Values for navType:
// 'y' = yaw/rudder, 'a' = aileron/roll, 'h' = aileron/hovering
int determine_navigation_deflection(char navType)
{
	union longww deflectionAccum ;
	union longww dotprod ;
	union longww crossprod ;
	int desiredX ;
	int desiredY ;
	int actualX ;
	int actualY ;
	
	int yawkp = (navType == 'y') ? yawkprud : yawkpail ;
	
#ifdef TestGains
	desiredX = -cosine ( (navType == 'y') ? 0 : 64 ) ;
	desiredY = sine ( (navType == 'y') ? 0 : 64 ) ;
#else
	desiredX = -cosine( desired_dir ) ;
	desiredY = sine( desired_dir ) ;
#endif
	actualX = (navType == 'h') ? rmat[2] : rmat[1] ;
	actualY = (navType == 'h') ? rmat[5] : rmat[4] ;
	dotprod.WW = __builtin_mulss( actualX , desiredX ) + __builtin_mulss( actualY , desiredY ) ;
	crossprod.WW = __builtin_mulss( actualX , desiredY ) - __builtin_mulss( actualY , desiredX ) ;
	crossprod.WW = crossprod.WW<<2 ;
	if ( dotprod._.W1 > 0 )
	{
		deflectionAccum.WW = __builtin_mulss( crossprod._.W1 , yawkp ) ;
	}
	else
	{
		if ( crossprod._.W1 > 0 )
		{
			deflectionAccum._.W1 = yawkpail/4 ;
		}
		else
		{
			deflectionAccum._.W1 = -yawkpail/4 ;
		}
	}
	
	if (navType == 'h') deflectionAccum.WW = -deflectionAccum.WW ;
	
	return deflectionAccum._.W1 ;
}
