	.file "../../libDCM/estYawDrift.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.align	2
	.global	_udb_magnetometer_callback_data_available	; export
	.type	_udb_magnetometer_callback_data_available,@function
_udb_magnetometer_callback_data_available:
.LFB2:
.LM1:
	.set ___PA___,1
	lnk	#0
.LM2:
	bset.b	_dcm_flags+1,#1
.LM3:
	ulnk	
	return	
	.set ___PA___,0
.LFE2:
	.align	2
	.global	_dcm_enable_yaw_drift_correction	; export
	.type	_dcm_enable_yaw_drift_correction,@function
_dcm_enable_yaw_drift_correction:
.LFB3:
.LM4:
	.set ___PA___,1
	lnk	#2
	mov.b	w0,[w14]
.LM5:
	clr.b	w0
	mov.b	w0,[w14+1]
	cp0.b	[w14]
	.set ___BP___,0
	bra	nz,.L4
	mov.b	#1,w1
	mov.b	w1,[w14+1]
.L4:
	mov.b	[w14+1],w1
	ze	w1,w0
	and	w0,#1,w0
	sl	w0,#11,w2
	mov	_dcm_flags,w1
	mov	#-2049,w0
	and	w1,w0,w0
	ior	w0,w2,w0
	mov	w0,_dcm_flags
.LM6:
	ulnk	
	return	
	.set ___PA___,0
.LFE3:
	.align	2
	.global	_estYawDrift	; export
	.type	_estYawDrift,@function
_estYawDrift:
.LFB4:
.LM7:
	.set ___PA___,1
	lnk	#0
.LM8:
	call	_gps_nav_valid
	cp0.b	w0
	.set ___BP___,0
	bra	z,.L14
	mov	_dcm_flags,w0
	mov	#2048,w1
	and	w0,w1,w0
	cp0	w0
	.set ___BP___,0
	bra	nz,.L14
.LM9:
	mov	_estimatedWind,w0
	cp0	w0
	.set ___BP___,0
	bra	nz,.L10
	mov	_estimatedWind+2,w0
	cp0	w0
	.set ___BP___,0
	bra	z,.L12
.L10:
	mov	_air_speed_magnitudeXY,w1
	mov	#199,w0
	sub	w1,w0,[w15]
	.set ___BP___,0
	bra	gtu,.L13
.L12:
.LM10:
	mov.b	_actual_dir,WREG
	call	_cosine
	neg	w0,w0
	mov	w0,_dirovergndHGPS
.LM11:
	mov.b	_actual_dir,WREG
	call	_sine
	mov	w0,_dirovergndHGPS+2
.LM12:
	clr	w0
	mov	w0,_dirovergndHGPS+4
.LM13:
	bra	.L14
.L13:
.LM14:
	mov.b	_calculated_heading,WREG
	call	_cosine
	neg	w0,w0
	mov	w0,_dirovergndHGPS
.LM15:
	mov.b	_calculated_heading,WREG
	call	_sine
	mov	w0,_dirovergndHGPS+2
.LM16:
	clr	w0
	mov	w0,_dirovergndHGPS+4
.L14:
.LM17:
	ulnk	
	return	
	.set ___PA___,0
.LFE4:
	.section	.debug_frame,info
.Lframe0:
	.4byte	.LECIE0-.LSCIE0
.LSCIE0:
	.4byte	0xffffffff
	.byte	0x1
	.byte	0
	.uleb128 0x1
	.sleb128 2
	.byte	0x21
	.byte	0xc
	.uleb128 0xf
	.uleb128 0xfffffffc
	.byte	0x9
	.uleb128 0x21
	.uleb128 0xf
.LECIE0:
.LSFDE0:
	.4byte	.LEFDE0-.LASFDE0
.LASFDE0:
	.4byte	.Lframe0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
.LEFDE4:
	.section	.text,code
.Letext0:
	.section	.debug_line,info
	.4byte	.LELT0-.LSLT0
.LSLT0:
	.2byte	0x2
	.4byte	.LELTP0-.LASLTP0
.LASLTP0:
	.byte	0x1
	.byte	0x1
	.byte	0xf6
	.byte	0xf5
	.byte	0xa
	.byte	0x0
	.byte	0x1
	.byte	0x1
	.byte	0x1
	.byte	0x1
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.byte	0x1
	.ascii	"../../libDCM"
	.byte 0
	.ascii	"/opt/microchip/mplabc30/v3.30c/bin/bin/../../include"
	.byte 0
	.ascii	"/opt/microchip/mplabc30/v3.30c/bin/bin/../../support/dsPIC33F/h"
	.byte 0
	.ascii	"/opt/microchip/mplabc30/v3.30c/bin/bin/../../support/generic/h"
	.byte 0
	.byte	0x0
	.asciz	"../libUDB/libUDB_defines.h"
	.uleb128 0x1
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"p33FJ256GP710A.h"
	.uleb128 0x3
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"stddef.h"
	.uleb128 0x2
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"stdlib.h"
	.uleb128 0x2
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"dsp.h"
	.uleb128 0x4
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"../libUDB/libUDB.h"
	.uleb128 0x1
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"libDCM_defines.h"
	.uleb128 0x1
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"libDCM.h"
	.uleb128 0x1
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"estYawDrift.c"
	.uleb128 0x1
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"libDCM_internal.h"
	.uleb128 0x1
	.uleb128 0x0
	.uleb128 0x0
	.byte	0x0
.LELTP0:
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM1
	.byte	0x4
	.uleb128 0x9
	.byte	0x35
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM2
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM3
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM4
	.byte	0x19
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM5
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM6
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM7
	.byte	0x1a
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM8
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM9
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM10
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM11
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM12
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM13
	.byte	0x10
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM14
	.byte	0x1c
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM15
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM16
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM17
	.byte	0x19
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.Letext0
	.byte	0x0
	.uleb128 0x1
	.byte	0x1
.LELT0:
	.section	.debug_info,info
	.4byte	0x45c
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.Ldebug_line0
	.4byte	.Letext0
	.4byte	.Ltext0
	.asciz	"GNU C 4.0.3 (dsPIC30, Microchip v3_30) (A) Build date: Jun  2 2011"
	.byte	0x1
	.asciz	"../../libDCM/estYawDrift.c"
	.ascii	"/home/markw/Dropbox/autopilots/UAVdevboard/UDB4/mplabx_projects/MPQp"
	.asciz	"id400/MatrixPilotQuad/MPQpid400.X"
	.uleb128 0x2
	.asciz	"unsigned char"
	.byte	0x1
	.byte	0x8
	.uleb128 0x2
	.asciz	"int"
	.byte	0x2
	.byte	0x5
	.uleb128 0x2
	.asciz	"long int"
	.byte	0x4
	.byte	0x5
	.uleb128 0x3
	.4byte	.LASF0
	.byte	0x2
	.byte	0x7
	.uleb128 0x4
	.asciz	"boolean"
	.byte	0x1
	.byte	0x9c
	.4byte	0x117
	.uleb128 0x2
	.asciz	"char"
	.byte	0x1
	.byte	0x6
	.uleb128 0x2
	.asciz	"short unsigned int"
	.byte	0x2
	.byte	0x7
	.uleb128 0x2
	.asciz	"long unsigned int"
	.byte	0x4
	.byte	0x7
	.uleb128 0x4
	.asciz	"fractional"
	.byte	0x5
	.byte	0x5c
	.4byte	0xee
	.uleb128 0x2
	.asciz	"float"
	.byte	0x4
	.byte	0x4
	.uleb128 0x5
	.4byte	0x2db
	.asciz	"dcm_flag_bits"
	.byte	0x2
	.byte	0x7
	.byte	0x22
	.uleb128 0x6
	.asciz	"unused"
	.byte	0x7
	.byte	0x23
	.4byte	0x101
	.byte	0x2
	.byte	0x4
	.byte	0xc
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.asciz	"rollpitch_req"
	.byte	0x7
	.byte	0x24
	.4byte	0x101
	.byte	0x2
	.byte	0x1
	.byte	0xb
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.asciz	"gps_history_valid"
	.byte	0x7
	.byte	0x25
	.4byte	0x101
	.byte	0x2
	.byte	0x1
	.byte	0xa
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.asciz	"dead_reckon_enable"
	.byte	0x7
	.byte	0x26
	.4byte	0x101
	.byte	0x2
	.byte	0x1
	.byte	0x9
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.asciz	"reckon_req"
	.byte	0x7
	.byte	0x27
	.4byte	0x101
	.byte	0x2
	.byte	0x1
	.byte	0x8
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.asciz	"first_mag_reading"
	.byte	0x7
	.byte	0x28
	.4byte	0x101
	.byte	0x2
	.byte	0x1
	.byte	0x7
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.asciz	"mag_drift_req"
	.byte	0x7
	.byte	0x29
	.4byte	0x101
	.byte	0x2
	.byte	0x1
	.byte	0x6
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.asciz	"yaw_req"
	.byte	0x7
	.byte	0x2a
	.4byte	0x101
	.byte	0x2
	.byte	0x1
	.byte	0x5
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.asciz	"skip_yaw_drift"
	.byte	0x7
	.byte	0x2b
	.4byte	0x101
	.byte	0x2
	.byte	0x1
	.byte	0x4
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.asciz	"nav_capable"
	.byte	0x7
	.byte	0x2c
	.4byte	0x101
	.byte	0x2
	.byte	0x1
	.byte	0x3
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.asciz	"nmea_passthrough"
	.byte	0x7
	.byte	0x2d
	.4byte	0x101
	.byte	0x2
	.byte	0x1
	.byte	0x2
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.asciz	"init_finished"
	.byte	0x7
	.byte	0x2e
	.4byte	0x101
	.byte	0x2
	.byte	0x1
	.byte	0x1
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.asciz	"calib_finished"
	.byte	0x7
	.byte	0x2f
	.4byte	0x101
	.byte	0x2
	.byte	0x1
	.byte	0x10
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x7
	.4byte	0x304
	.asciz	"dcm_fbts_word"
	.byte	0x2
	.byte	0x8
	.byte	0x5b
	.uleb128 0x8
	.asciz	"_"
	.byte	0x8
	.byte	0x5b
	.4byte	0x165
	.uleb128 0x8
	.asciz	"W"
	.byte	0x8
	.byte	0x5b
	.4byte	0xee
	.byte	0x0
	.uleb128 0x9
	.byte	0x1
	.asciz	"udb_magnetometer_callback_data_available"
	.byte	0x9
	.byte	0x22
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5e
	.uleb128 0xa
	.4byte	0x382
	.byte	0x1
	.asciz	"dcm_enable_yaw_drift_correction"
	.byte	0x9
	.byte	0x2a
	.byte	0x1
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5e
	.uleb128 0xb
	.asciz	"enabled"
	.byte	0x9
	.byte	0x29
	.4byte	0x108
	.byte	0x2
	.byte	0x7e
	.sleb128 0
	.byte	0x0
	.uleb128 0x9
	.byte	0x1
	.asciz	"estYawDrift"
	.byte	0x9
	.byte	0x33
	.byte	0x1
	.4byte	.LFB4
	.4byte	.LFE4
	.byte	0x1
	.byte	0x5e
	.uleb128 0xc
	.asciz	"dcm_flags"
	.byte	0x8
	.byte	0x5b
	.4byte	0x2db
	.byte	0x1
	.byte	0x1
	.uleb128 0xd
	.4byte	0x3c0
	.4byte	0xee
	.uleb128 0xe
	.4byte	0x3c0
	.byte	0x2
	.byte	0x0
	.uleb128 0x3
	.4byte	.LASF0
	.byte	0x2
	.byte	0x7
	.uleb128 0xc
	.asciz	"estimatedWind"
	.byte	0x8
	.byte	0x66
	.4byte	0x3b0
	.byte	0x1
	.byte	0x1
	.uleb128 0xc
	.asciz	"calculated_heading"
	.byte	0x9
	.byte	0x30
	.4byte	0x3fa
	.byte	0x1
	.byte	0x1
	.uleb128 0x2
	.asciz	"signed char"
	.byte	0x1
	.byte	0x6
	.uleb128 0xc
	.asciz	"air_speed_magnitudeXY"
	.byte	0x8
	.byte	0x73
	.4byte	0x101
	.byte	0x1
	.byte	0x1
	.uleb128 0xd
	.4byte	0x433
	.4byte	0x14a
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xc
	.asciz	"dirovergndHGPS"
	.byte	0xa
	.byte	0x2b
	.4byte	0x428
	.byte	0x1
	.byte	0x1
	.uleb128 0xc
	.asciz	"actual_dir"
	.byte	0x9
	.byte	0x2f
	.4byte	0x3fa
	.byte	0x1
	.byte	0x1
	.byte	0x0
	.section	.debug_abbrev,info
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x10
	.uleb128 0x6
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1b
	.uleb128 0x8
	.byte	0x0
	.byte	0x0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x4
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xd
	.uleb128 0xb
	.uleb128 0xc
	.uleb128 0xb
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
	.uleb128 0x17
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.uleb128 0x2e
	.byte	0x0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x6f
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x460
	.4byte	0x304
	.asciz	"udb_magnetometer_callback_data_available"
	.4byte	0x33c
	.asciz	"dcm_enable_yaw_drift_correction"
	.4byte	0x382
	.asciz	"estYawDrift"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF0:
	.asciz	"unsigned int"

	.section __c30_signature, info, data
	.word 0x0001
	.word 0x0000
	.word 0x0000

	.set ___PA___,0
	.end
