// This file is part of MatrixPilot.
//
//    http://code.google.com/p/gentlenav/
//
// Copyright 2009-2011 MatrixPilot Team
// See the AUTHORS.TXT file for a list of authors of MatrixPilot.
//
// MatrixPilot is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// MatrixPilot is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with MatrixPilot.  If not, see <http://www.gnu.org/licenses/>.


// Enable or disable the whole OSD system by setting the value of USE_OSD in osd.h

// OSD_VIDEO_FORMAT can be set to either OSD_NTSC, or OSD_PAL
// #define OSD_VIDEO_FORMAT                OSD_PAL moved to options.h

// The callsign is written using characters from the OSD Font file.  (See Tools/FlashOSD/.)
// This has to end with 0xFF.
// Adjust the placement using OSD_LOC_CALLSIGN_HORIZ and OSD_LOC_CALLSIGN_VERT.
// #define OSD_CALL_SIGN					{0x95, 0x81, 0x82, 0x83, 0x84, 0x85, 0xFF} // K12345
// {0x8F, 0xA4, 0x90, 0x91, 0x83,0xFF} // EZFG03
#define OSD_CALL_SIGN					{0x8F, 0xA4, 0x8B, 0x9A, 0x9D, 0x82, 0x84, 0xFF} // EZAPS24
#define OSD_SHOW_CENTER_DOT             2

#define OSD_SHOW_HORIZON                1
#define OSD_HORIZON_WIDTH               8 //10
#define OSD_HORIZON_ROLL_REVERSED       0
#define OSD_HORIZON_PITCH_REVERSED      0

#define OSD_AUTO_HIDE_GPS               1   // Only show Lat, Long, and Num Sats while slow and low.


// OSD Element Locations
// Set each one to OSD_LOC_DISABLED or OSD_LOC(row, col) from (0, 0) to (12, 29) for NTSC or up to (15, 29) for PAL.

#define OSD_LOC_DIST_TO_GOAL			OSD_LOC(1, 14)			// 5 characters wide  def 1, 13
#define OSD_LOC_ARROW_TO_GOAL			OSD_LOC(2, 14)			// 2 characters wide  def 2, 14

#define OSD_LOC_AP_MODE					OSD_LOC(14, 14)			// 1 character wide

#define OSD_LOC_ALTITUDE				OSD_LOC(2, 0)			// 6 characters wide  OSD_LOC(0, 0)
#define OSD_LOC_VARIO_NUM				OSD_LOC(3, 0)    		// 4 characters wide  OSD_LOC(1, 0) 
#define OSD_LOC_VARIO_ARROW				OSD_LOC(3, 6)			// 1 character wide   OSD_LOC(4, 2)
#define OSD_LOC_VERTICAL_ANGLE_HOME		OSD_LOC_DISABLED		// 4 characters wide  def OSD_LOC_DISABLED

#define OSD_LOC_AIR_SPEED_M_S			OSD_LOC_DISABLED		// 4 characters wide
#define OSD_LOC_AIR_SPEED_MI_HR			OSD_LOC_DISABLED		// 4 characters wide  def OSD_LOC(1, 22)
#define OSD_LOC_AIR_SPEED_KM_HR			OSD_LOC(7, 25)	   	    // 4 characters wide  def OSD_LOC_DISABLED

#define OSD_LOC_GROUND_SPEED_M_S		OSD_LOC_DISABLED		// 4 characters wide
#define OSD_LOC_GROUND_SPEED_MI_HR		OSD_LOC_DISABLED		// 4 characters wide
#define OSD_LOC_GROUND_SPEED_KM_HR		OSD_LOC(8, 25)    		// 4 characters wide 

#define OSD_LOC_HEADING_NUM				OSD_LOC_DISABLED		// 5 characters wide
#define OSD_LOC_HEADING_CARDINAL		OSD_LOC(1, 10)         	// 3 characters wide  def OSD_LOC_DISABLED

#define OSD_LOC_VERTICAL_ACCEL			OSD_LOC(8, 1)   		// 3 characters wide  def OSD_LOC_DISABLED
#define OSD_LOC_VERTICAL_WIND_SPEED		OSD_LOC(7, 1)			// 4 characters wide
#define OSD_LOC_TOTAL_ENERGY			OSD_LOC_DISABLED		// 4 characters wide

#define OSD_LOC_ROLL_RATE				OSD_LOC(13, 26) 		// 3 characters wide (13, 27) def OSD_LOC_DISABLED
#define OSD_LOC_PITCH_RATE				OSD_LOC(14, 26) 		// 3 characters wide (14, 27) def OSD_LOC_DISABLED
#define OSD_LOC_YAW_RATE				OSD_LOC(15, 26) 		// 3 characters wide (15, 27) def OSD_LOC_DISABLED

#define OSD_LOC_NUM_SATS				OSD_LOC(1, 25)			// 4 characters wide  OSD_LOC(0, 22)
#define OSD_LOC_GPS_LAT					OSD_LOC(2, 20)			// 9 characters wide  OSD_LOC(1, 21)
#define OSD_LOC_GPS_LONG				OSD_LOC(3, 19)			// 10 characters wide  OSD_LOC(2, 20)

#define OSD_LOC_CALLSIGN_HORIZ			OSD_LOC(1, 0)			// variable width (8 char, see above)
#define OSD_LOC_CALLSIGN_VERT			OSD_LOC_DISABLED		// variable height def OSD_LOC(0,28)

#define OSD_LOC_CPU_LOAD				OSD_LOC(12, 24)			// 5 characters wide OSD_LOC(12, 24)

#define OSD_LOC_BATT_CURRENT			OSD_LOC(13, 0)			// 4 characters wide OSD_LOC(13,0)
#define OSD_LOC_BATT_USED				OSD_LOC(14, 0)			// 5 characters wide OSD_LOC(14,0)
#define OSD_LOC_BATT_VOLTAGE			OSD_LOC(15, 0)			// 4 characters wide OSD_LOC(15,0)
#define OSD_LOC_RSSI					OSD_LOC(12, 0)			// 4 characters wide def OSD_LOC(12,0)

// Set the display vertical offset:
//   0  == VOS set to +15 pixels (farthest up)
//   16 == VOS set to +-0 pixels (no shift, default)
//   31 == VOS set to -15 pixels (farthest down)
#define OSD_VERTICAL_OFFSET             16

// Set the display horizontal offset:
//   0  == HOS set to -32 pixels (farthest left)
//   32 == HOS set to +-0 pixels (no offset, default)
//   63 == HOS set to +31 pixels (farthest right)
#define OSD_HORIZONTAL_OFFSET           32

/* default
#define OSD_LOC_DIST_TO_GOAL            OSD_LOC(1, 13)      // 5 characters wide
#define OSD_LOC_ARROW_TO_GOAL           OSD_LOC(2, 14)      // 2 characters wide

#define OSD_LOC_AP_MODE                 OSD_LOC(1, 20)      // 1 character wide

#define OSD_LOC_ALTITUDE                OSD_LOC(1, 4)       // 6 characters wide
#define OSD_LOC_VARIO_NUM               OSD_LOC_DISABLED    // 4 characters wide
#define OSD_LOC_VARIO_ARROW             OSD_LOC(1, 11)      // 1 character wide
#define OSD_LOC_VERTICAL_ANGLE_HOME     OSD_LOC_DISABLED    // 4 characters wide

#define OSD_LOC_AIR_SPEED_M_S           OSD_LOC_DISABLED    // 4 characters wide
#define OSD_LOC_AIR_SPEED_MI_HR         OSD_LOC_DISABLED    // 4 characters wide
#define OSD_LOC_AIR_SPEED_KM_HR         OSD_LOC(11, 23)     // 4 characters wide

#define OSD_LOC_GROUND_SPEED_M_S        OSD_LOC_DISABLED    // 4 characters wide
#define OSD_LOC_GROUND_SPEED_MI_HR      OSD_LOC_DISABLED    // 4 characters wide
#define OSD_LOC_GROUND_SPEED_KM_HR      OSD_LOC(12, 23)     // 4 characters wide

#define OSD_LOC_HEADING_NUM             OSD_LOC_DISABLED    // 5 characters wide
#define OSD_LOC_HEADING_CARDINAL        OSD_LOC_DISABLED    // 3 characters wide

#define OSD_LOC_VERTICAL_ACCEL          OSD_LOC(10, 23)     // 3 characters wide
#define OSD_LOC_VERTICAL_WIND_SPEED     OSD_LOC_DISABLED    // 4 characters wide
#define OSD_LOC_TOTAL_ENERGY            OSD_LOC_DISABLED    // 4 characters wide

#define OSD_LOC_ROLL_RATE               OSD_LOC(4, 24)      // 3 characters wide
#define OSD_LOC_PITCH_RATE              OSD_LOC(5, 24)      // 3 characters wide
#define OSD_LOC_YAW_RATE                OSD_LOC(6, 24)      // 3 characters wide

#define OSD_LOC_NUM_SATS                OSD_LOC(13, 3)      // 4 characters wide
#define OSD_LOC_GPS_LAT                 OSD_LOC(13, 7)      // 9 characters wide
#define OSD_LOC_GPS_LONG                OSD_LOC(13, 17)     // 10 characters wide

#define OSD_LOC_CALLSIGN_HORIZ          OSD_LOC_DISABLED    // variable width
#define OSD_LOC_CALLSIGN_VERT           OSD_LOC(0, 28)      // variable height

//#define OSD_LOC_CPU_LOAD                OSD_LOC(13, 3)      // 5 characters wide
#define OSD_LOC_CPU_LOAD                OSD_LOC(1, 23)      // 4 characters wide

#define OSD_LOC_BATT_CURRENT            OSD_LOC(2, 17)      // 4 characters wide
#define OSD_LOC_BATT_USED               OSD_LOC(2, 22)      // 5 characters wide
#define OSD_LOC_BATT_VOLTAGE            OSD_LOC(3, 17)      // 4 characters wide
#define OSD_LOC_RSSI                    OSD_LOC(3, 23)      // 4 characters wide
*/

