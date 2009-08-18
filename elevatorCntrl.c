#include "p30f4011.h"
#include "definesRmat.h"
#include "defines.h"

//	If the state machine selects pitch feedback, compute it from the pitch gyro and accelerometer.

int rtlkick = 0 ;

#define RTLKICK RMAX*(RTLPITCHDOWN/57.3)

int pitchgain = PITCHGAIN*RMAX ;

void elevatorCntrl(void)
{
	union longww elevAccum ;
	
#ifdef TestGains
	flags._.GPS_steering = 1 ;
	flags._.pitch_feedback = 1 ;
#endif 
	if ( flags._.GPS_steering )
	{
		rtlkick = RTLKICK ;
	}
	else
	{
		rtlkick = 0 ;
	}
	if ( flags._.pitch_feedback )
	{
		elevAccum.WW = __builtin_mulss( rmat[7] - rtlkick , pitchgain ) ;
	}
	else
	{
		elevAccum.WW = 0 ;
	}
	
	// Reverse the polarity of the control feedback if necessary
	if ( !ELEVATOR_CHANNEL_REVERSED )
		pitch_control = (long)elevAccum._.W1 ;
	else
		pitch_control = -(long)elevAccum._.W1 ;
		
	return ;
}
