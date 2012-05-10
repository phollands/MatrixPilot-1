	.file "../motorCntrl.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.global	_desired_heading	; export
	.section	.ndata,data,near
	.align	2
	.type	_desired_heading,@object
_desired_heading:
	.skip	2
	.global	_theta_previous	; export
	.align	2
	.type	_theta_previous,@object
_theta_previous:
	.skip	4
	.global	_yaw_error_previous	; export
	.align	2
	.type	_yaw_error_previous,@object
_yaw_error_previous:
	.skip	2
	.global	_roll_error_integral	; export
	.align	2
	.type	_roll_error_integral,@object
_roll_error_integral:
	.skip	4
	.global	_pitch_error_integral	; export
	.align	2
	.type	_pitch_error_integral,@object
_pitch_error_integral:
	.skip	4
	.global	_yaw_error_integral	; export
	.align	2
	.type	_yaw_error_integral,@object
_yaw_error_integral:
	.skip	4
	.global	_target_orientation	; export
	.align	2
	.type	_target_orientation,@object
_target_orientation:
	.word	16384
	.word	0
	.word	0
	.word	0
	.word	16384
	.word	0
	.word	0
	.word	0
	.word	16384
	.global	_yaw_command_gain	; export
	.section	.const,psv,page
	.align	2
	.type	_yaw_command_gain,@object
_yaw_command_gain:
	.word	1
	.section	.text,code
	.align	2
	.global	_motorCntrl	; export
	.type	_motorCntrl,@function
_motorCntrl:
.LFB2:
.LM1:
	.set ___PA___,1
	lnk	#30
.LM2:
	clr	w0
	mov	w0,[w14+18]
	bra	.L2
.L3:
.LM3:
	mov	_udb_flags,w0
	mov	#128,w1
	and	w0,w1,w0
	cp0	w0
	.set ___BP___,0
	bra	z,.L4
.LM4:
	mov	[w14+18],w2
	mov	[w14+18],w0
	add	w0,w0,w1
	mov	#_udb_pwIn,w0
	add	w1,w0,w0
	mov	[w0],w3
	add	w2,w2,w1
	mov	#_pwManual,w0
	add	w1,w0,w0
	mov	w3,[w0]
	bra	.L6
.L4:
.LM5:
	mov	[w14+18],w2
	mov	[w14+18],w0
	add	w0,w0,w1
	mov	#_udb_pwTrim,w0
	add	w1,w0,w0
	mov	[w0],w3
	add	w2,w2,w1
	mov	#_pwManual,w0
	add	w1,w0,w0
	mov	w3,[w0]
.L6:
.LM6:
	mov	[w14+18],w0
	inc	w0,w0
	mov	w0,[w14+18]
.L2:
	mov	[w14+18],w0
	sub	w0,#4,[w15]
	.set ___BP___,0
	bra	le,.L3
.LM7:
	mov.b	_didCalibrate,WREG
	cp0.b	w0
	.set ___BP___,0
	bra	z,.L36
.LM8:
	mov	_pwManual+2,w1
	mov	_udb_pwTrim+2,w0
	sub	w1,w0,w1
	mov	#-99,w0
	sub	w1,w0,[w15]
	.set ___BP___,0
	bra	lt,.L10
	mov	_pwManual+2,w1
	mov	_udb_pwTrim+2,w0
	sub	w1,w0,w1
	mov	#99,w0
	sub	w1,w0,[w15]
	.set ___BP___,0
	bra	gt,.L10
.LM9:
	mov	_pwManual+2,w0
	mov	w0,[w14+8]
	mov	[w14+8],w2
	mov	w2,[w14+10]
	mov	[w14+10],w4
	mov	w4,[w14+12]
	mov	[w14+12],w0
	mov	w0,[w14+14]
.LM10:
	mov	#_rmat,w2
	mov	#_target_orientation,w1
	mov	#9,w0
	call	_VectorCopy
.LM11:
	mov	_pwManual+4,w1
	mov	_udb_pwTrim+4,w0
	sub	w1,w0,w0
	mov	w0,_commanded_roll
.LM12:
	mov	_pwManual+6,w1
	mov	_udb_pwTrim+6,w0
	sub	w1,w0,w0
	mov	w0,_commanded_pitch
.LM13:
	mov	_pwManual+8,w1
	mov	_udb_pwTrim+8,w0
	sub	w1,w0,w0
	mov	w0,_commanded_yaw
.LM14:
	mov	_rmat+8,w0
	mov	w0,_matrix_accum
.LM15:
	mov	_rmat+2,w0
	mov	w0,_matrix_accum+2
.LM16:
	mov	#_matrix_accum,w0
	call	_rect_to_polar16
	mov	w0,_earth_yaw
.LM17:
	mov	_earth_yaw,w0
	mov	w0,_desired_heading
.LM18:
	mov	_commanded_pitch,w2
	mov	w2,[w14+4]
.LM19:
	mov	_commanded_roll,w4
	mov	w4,[w14+6]
.LM20:
	mov	_commanded_yaw,w1
	mov	[w14+4],w0
	sub	w1,w0,w1
	mov	[w14+14],w0
	add	w0,w1,w0
	mov	w0,[w14+14]
.LM21:
	mov	_commanded_yaw,w0
	neg	w0,w1
	mov	[w14+6],w0
	sub	w1,w0,w1
	mov	[w14+12],w0
	add	w0,w1,w0
	mov	w0,[w14+12]
.LM22:
	mov	_commanded_yaw,w1
	mov	[w14+4],w0
	add	w1,w0,w1
	mov	[w14+10],w0
	add	w0,w1,w0
	mov	w0,[w14+10]
.LM23:
	mov	_commanded_yaw,w1
	mov	[w14+6],w0
	sub	w0,w1,w1
	mov	[w14+8],w0
	add	w0,w1,w0
	mov	w0,[w14+8]
.LM24:
	mov	[w14+14],w0
	asr	w0,#15,w1
	call	_udb_servo_pulsesat
	mov	w0,_udb_pwOut+6
.LM25:
	mov	[w14+12],w0
	asr	w0,#15,w1
	call	_udb_servo_pulsesat
	mov	w0,_udb_pwOut+8
.LM26:
	mov	[w14+10],w0
	asr	w0,#15,w1
	call	_udb_servo_pulsesat
	mov	w0,_udb_pwOut+2
.LM27:
	mov	[w14+8],w0
	asr	w0,#15,w1
	call	_udb_servo_pulsesat
	mov	w0,_udb_pwOut+4
.LM28:
	bra	.L36
.L10:
.LBB2:
.LM29:
	mov	_pwManual+4,w1
	mov	_udb_pwTrim+4,w0
	sub	w1,w0,w1
	mov	_commanded_tilt_gain,w0
	mul.ss	w1,w0,w0
	mov	w0,_commanded_roll
.LM30:
	mov	_pwManual+6,w1
	mov	_udb_pwTrim+6,w0
	sub	w1,w0,w1
	mov	_commanded_tilt_gain,w0
	mul.ss	w1,w0,w0
	mov	w0,_commanded_pitch
.LM31:
	mov	_pwManual+8,w1
	mov	_udb_pwTrim+8,w0
	sub	w1,w0,w0
	mov	w0,_commanded_yaw
.LM32:
	mov	_commanded_yaw,w0
	sub	w0,#14,[w15]
	.set ___BP___,0
	bra	le,.L13
.LM33:
	mov	_commanded_yaw,w0
	sub	w0,#15,w0
	mov	w0,_commanded_yaw
	bra	.L15
.L13:
.LM34:
	mov	_commanded_yaw,w0
	add	w0,#15,[w15]
	.set ___BP___,0
	bra	gt,.L16
.LM35:
	mov	_commanded_yaw,w0
	add	w0,#15,w0
	mov	w0,_commanded_yaw
	bra	.L15
.L16:
.LM36:
	clr	w0
	mov	w0,_commanded_yaw
.L15:
.LM37:
	mov	_commanded_roll,w1
	add	w14,#20,w0
	mov	w1,[w0]
.LM38:
	mov	_commanded_pitch,w1
	add	w14,#20,w0
	mov	w1,[w0+2]
.LM39:
	add	w14,#20,w1
	mov	#16384,w0
	mov	w0,[w1+4]
.LM40:
	add	w14,#20,w1
	add	w14,#20,w0
	call	_vector3_normalize
.LM41:
	add	w14,#20,w0
	mov	[w0],w0
	mov	w0,_commanded_roll
.LM42:
	add	w14,#20,w0
	mov	[w0+2],w0
	mov	w0,_commanded_pitch
.LM43:
	mov	_commanded_pitch,w0
	mov	w0,[w14+4]
.LM44:
	mov	_commanded_roll,w2
	mov	w2,[w14+6]
.LM45:
	mov	_rmat+12,w1
	mov	[w14+6],w0
	add	w1,w0,w0
	mov	w0,_roll_error
.LM46:
	mov	_rmat+14,w1
	mov	[w14+4],w0
	sub	w0,w1,w0
	mov	w0,_pitch_error
.LM47:
	mov	_rmat+8,w0
	mov	w0,_matrix_accum
.LM48:
	mov	_rmat+2,w0
	mov	w0,_matrix_accum+2
.LM49:
	mov	#_matrix_accum,w0
	call	_rect_to_polar16
	mov	w0,_earth_yaw
.LM50:
	mov	_commanded_yaw,w0
	cp0	w0
	.set ___BP___,0
	bra	z,.L18
.LM51:
	mov	_earth_yaw,w0
	mov	w0,_desired_heading
.L18:
.LM52:
	mov	_earth_yaw,w1
	mov	_desired_heading,w0
	sub	w1,w0,w0
	mov	w0,_yaw_error
.LM53:
	mov	_commanded_yaw,w0
	mul.su	w0,#10,w0
	mov	w0,w1
	mov	_yaw_error,w0
	add	w1,w0,w0
	mov	w0,_yaw_error
.LM54:
	mov	_udb_pwTrim+2,w4
	mov	w4,[w14+16]
.LM55:
	mov	_accelEarth+4,w1
	mov	#16384,w0
	mul.us	w0,w1,w0
	mov	w0,[w14+26]
	mov	w1,[w14+28]
.LM56:
	mov	[w14+28],w0
	mov	w0,_accel_feedback
.LM57:
	mov	_pwManual+2,w1
	mov	_accel_feedback,w0
	sub	w1,w0,w0
	mov	w0,[w14+8]
	mov	[w14+8],w0
	mov	w0,[w14+10]
	mov	[w14+10],w2
	mov	w2,[w14+12]
	mov	[w14+12],w4
	mov	w4,[w14+14]
.LM58:
	mov	_roll_error_integral,w2
	mov	_roll_error_integral+2,w3
	mov	_roll_error,w1
	mov	#524,w0
	mul.us	w0,w1,w0
	sl	w1,#8,w4
	lsr	w0,#8,w0
	ior	w4,w0,w0
	asr	w1,#8,w1
	add	w0,w2,w0
	addc	w1,w3,w1
	mov	w0,_roll_error_integral
	mov	w1,_roll_error_integral+2
.LM59:
	mov	_roll_error_integral,w2
	mov	_roll_error_integral+2,w3
	mov	#0,w0
	mov	#500,w1
	sub	w2,w0,[w15]
	subb	w3,w1,[w15]
	.set ___BP___,0
	bra	le,.L20
.LM60:
	mov	#0,w0
	mov	#500,w1
	mov	w0,_roll_error_integral
	mov	w1,_roll_error_integral+2
.L20:
.LM61:
	mov	_roll_error_integral,w2
	mov	_roll_error_integral+2,w3
	mov	#0,w0
	mov	#-500,w1
	sub	w2,w0,[w15]
	subb	w3,w1,[w15]
	.set ___BP___,0
	bra	ge,.L22
.LM62:
	mov	#0,w0
	mov	#-500,w1
	mov	w0,_roll_error_integral
	mov	w1,_roll_error_integral+2
.L22:
.LM63:
	mov	_pitch_error_integral,w2
	mov	_pitch_error_integral+2,w3
	mov	_pitch_error,w1
	mov	#524,w0
	mul.us	w0,w1,w0
	sl	w1,#8,w4
	lsr	w0,#8,w0
	ior	w4,w0,w0
	asr	w1,#8,w1
	add	w0,w2,w0
	addc	w1,w3,w1
	mov	w0,_pitch_error_integral
	mov	w1,_pitch_error_integral+2
.LM64:
	mov	_pitch_error_integral,w2
	mov	_pitch_error_integral+2,w3
	mov	#0,w0
	mov	#500,w1
	sub	w2,w0,[w15]
	subb	w3,w1,[w15]
	.set ___BP___,0
	bra	le,.L24
.LM65:
	mov	#0,w0
	mov	#500,w1
	mov	w0,_pitch_error_integral
	mov	w1,_pitch_error_integral+2
.L24:
.LM66:
	mov	_pitch_error_integral,w2
	mov	_pitch_error_integral+2,w3
	mov	#0,w0
	mov	#-500,w1
	sub	w2,w0,[w15]
	subb	w3,w1,[w15]
	.set ___BP___,0
	bra	ge,.L26
.LM67:
	mov	#0,w0
	mov	#-500,w1
	mov	w0,_pitch_error_integral
	mov	w1,_pitch_error_integral+2
.L26:
.LM68:
	mov	_yaw_error_integral,w2
	mov	_yaw_error_integral+2,w3
	mov	_yaw_error,w1
	mov	#2621,w0
	mul.us	w0,w1,w0
	sl	w1,#8,w4
	lsr	w0,#8,w0
	ior	w4,w0,w0
	asr	w1,#8,w1
	add	w0,w2,w0
	addc	w1,w3,w1
	mov	w0,_yaw_error_integral
	mov	w1,_yaw_error_integral+2
.LM69:
	mov	_yaw_error_integral,w2
	mov	_yaw_error_integral+2,w3
	mov	#0,w0
	mov	#500,w1
	sub	w2,w0,[w15]
	subb	w3,w1,[w15]
	.set ___BP___,0
	bra	le,.L28
.LM70:
	mov	#0,w0
	mov	#500,w1
	mov	w0,_yaw_error_integral
	mov	w1,_yaw_error_integral+2
.L28:
.LM71:
	mov	_yaw_error_integral,w2
	mov	_yaw_error_integral+2,w3
	mov	#0,w0
	mov	#-500,w1
	sub	w2,w0,[w15]
	subb	w3,w1,[w15]
	.set ___BP___,0
	bra	ge,.L30
.LM72:
	mov	#0,w0
	mov	#-500,w1
	mov	w0,_yaw_error_integral
	mov	w1,_yaw_error_integral+2
.L30:
.LM73:
	mov	_theta,w1
	mov	_theta_previous,w0
	sub	w1,w0,w0
	mov	w0,_theta_delta
.LM74:
	mov	_theta+2,w1
	mov	_theta_previous+2,w0
	sub	w1,w0,w0
	mov	w0,_theta_delta+2
.LM75:
	mov	_roll_error,w1
	mov	#_pid_gains,w0
	mov	[w0],w0
	mul.us	w0,w1,w0
	mov	w0,[w14+26]
	mov	w1,[w14+28]
.LM76:
	mov	[w14+28],w1
	mov	_theta+2,w0
	sl	w0,#2,w0
	sub	w1,w0,w0
	mov	w0,[w14+2]
.LM77:
	mov	_roll_error_integral+2,w1
	mov	[w14+2],w0
	add	w0,w1,w0
	mov	w0,[w14+2]
.LM78:
	mov	#_pid_gains,w0
	mov	[w0+2],w1
	mov	[w14+2],w0
	mul.us	w1,w0,w0
	mov	w0,[w14+26]
	mov	w1,[w14+28]
.LM79:
	mov	[w14+28],w0
	mov	w0,_roll_control
.LM80:
	mov	_theta_delta+2,w0
	neg	w0,w1
	mov	#_pid_gains,w0
	mov	[w0+4],w0
	mul.us	w0,w1,w0
	sl	w1,#2,w2
	lsr	w0,#14,w1
	ior	w2,w1,w1
	sl	w0,#2,w0
	mov	w0,[w14+26]
	mov	w1,[w14+28]
.LM81:
	mov	[w14+28],w1
	mov	_roll_control,w0
	add	w1,w0,w0
	mov	w0,_roll_control
.LM82:
	mov	_pitch_error,w1
	mov	#_pid_gains,w0
	mov	[w0],w0
	mul.us	w0,w1,w0
	mov	w0,[w14+26]
	mov	w1,[w14+28]
.LM83:
	mov	[w14+28],w1
	mov	_theta,w0
	sl	w0,#2,w0
	sub	w1,w0,[w14]
.LM84:
	mov	_pitch_error_integral+2,w0
	add	w0,[w14],[w14]
.LM85:
	mov	#_pid_gains,w0
	mov	[w0+2],w0
	mul.us	w0,[w14],w0
	mov	w0,[w14+26]
	mov	w1,[w14+28]
.LM86:
	mov	[w14+28],w0
	mov	w0,_pitch_control
.LM87:
	mov	_theta_delta,w0
	neg	w0,w1
	mov	#_pid_gains,w0
	mov	[w0+4],w0
	mul.us	w0,w1,w0
	sl	w1,#2,w4
	lsr	w0,#14,w1
	ior	w4,w1,w1
	sl	w0,#2,w0
	mov	w0,[w14+26]
	mov	w1,[w14+28]
.LM88:
	mov	[w14+28],w1
	mov	_pitch_control,w0
	add	w1,w0,w0
	mov	w0,_pitch_control
.LM89:
	mov	_yaw_error,w1
	mov	#8192,w0
	mul.us	w0,w1,w0
	mov	w0,[w14+26]
	mov	w1,[w14+28]
.LM90:
	mov	[w14+28],w1
	mov	_theta+4,w0
	sl	w0,#2,w0
	sub	w1,w0,w0
	mov	w0,_yaw_rate_error
.LM91:
	mov	_yaw_error_integral+2,w1
	mov	_yaw_rate_error,w0
	add	w1,w0,w0
	mov	w0,_yaw_rate_error
.LM92:
	mov	_yaw_rate_error,w1
	mov	#-32768,w0
	mul.us	w0,w1,w0
	mov	w0,[w14+26]
	mov	w1,[w14+28]
.LM93:
	mov	[w14+28],w0
	mov	w0,_yaw_control
.LM94:
	mov	_yaw_control,w1
	mov	#200,w0
	sub	w1,w0,[w15]
	.set ___BP___,0
	bra	le,.L32
.LM95:
	mov	#200,w0
	mov	w0,_yaw_control
	bra	.L34
.L32:
.LM96:
	mov	_yaw_control,w1
	mov	#-200,w0
	sub	w1,w0,[w15]
	.set ___BP___,0
	bra	ge,.L34
.LM97:
	mov	#-200,w0
	mov	w0,_yaw_control
.L34:
.LM98:
	mov	_yaw_control,w1
	mov	_pitch_control,w0
	sub	w1,w0,w1
	mov	[w14+14],w0
	add	w0,w1,w0
	mov	w0,[w14+14]
.LM99:
	mov	_yaw_control,w0
	neg	w0,w1
	mov	_roll_control,w0
	sub	w1,w0,w1
	mov	[w14+12],w0
	add	w0,w1,w0
	mov	w0,[w14+12]
.LM100:
	mov	_yaw_control,w1
	mov	_pitch_control,w0
	add	w1,w0,w1
	mov	[w14+10],w0
	add	w0,w1,w0
	mov	w0,[w14+10]
.LM101:
	mov	_roll_control,w1
	mov	_yaw_control,w0
	sub	w1,w0,w1
	mov	[w14+8],w0
	add	w0,w1,w0
	mov	w0,[w14+8]
.LM102:
	mov	[w14+14],w0
	asr	w0,#15,w1
	call	_udb_servo_pulsesat
	mov	w0,_udb_pwOut+6
.LM103:
	mov	[w14+12],w0
	asr	w0,#15,w1
	call	_udb_servo_pulsesat
	mov	w0,_udb_pwOut+8
.LM104:
	mov	[w14+10],w0
	asr	w0,#15,w1
	call	_udb_servo_pulsesat
	mov	w0,_udb_pwOut+2
.LM105:
	mov	[w14+8],w0
	asr	w0,#15,w1
	call	_udb_servo_pulsesat
	mov	w0,_udb_pwOut+4
.L36:
.LBE2:
.LM106:
	ulnk	
	return	
	.set ___PA___,0
.LFE2:
	.section	.nbss,bss,near
	.type	_pid_gains,@object
	.global	_pid_gains
	.align	2
_pid_gains:	.space	8
	.type	_roll_control,@object
	.global	_roll_control
	.align	2
_roll_control:	.space	2
	.type	_pitch_control,@object
	.global	_pitch_control
	.align	2
_pitch_control:	.space	2
	.type	_yaw_control,@object
	.global	_yaw_control
	.align	2
_yaw_control:	.space	2
	.type	_pitch_step,@object
	.global	_pitch_step
	.align	2
_pitch_step:	.space	2
	.type	_matrix_accum,@object
	.global	_matrix_accum
	.align	2
_matrix_accum:	.space	4
	.type	_earth_yaw,@object
	.global	_earth_yaw
	.align	2
_earth_yaw:	.space	2
	.type	_accel_feedback,@object
	.global	_accel_feedback
	.align	2
_accel_feedback:	.space	2
	.type	_theta_delta,@object
	.global	_theta_delta
	.align	2
_theta_delta:	.space	4
	.type	_pwManual,@object
	.global	_pwManual
	.align	2
_pwManual:	.space	10
	.type	_commanded_roll,@object
	.global	_commanded_roll
	.align	2
_commanded_roll:	.space	2
	.type	_commanded_pitch,@object
	.global	_commanded_pitch
	.align	2
_commanded_pitch:	.space	2
	.type	_commanded_yaw,@object
	.global	_commanded_yaw
	.align	2
_commanded_yaw:	.space	2
	.type	_roll_error,@object
	.global	_roll_error
	.align	2
_roll_error:	.space	2
	.type	_pitch_error,@object
	.global	_pitch_error
	.align	2
_pitch_error:	.space	2
	.type	_yaw_error,@object
	.global	_yaw_error
	.align	2
_yaw_error:	.space	2
	.type	_yaw_rate_error,@object
	.global	_yaw_rate_error
	.align	2
_yaw_rate_error:	.space	2
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
	.ascii	".."
	.byte 0
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
	.uleb128 0x2
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"p33FJ256GP710A.h"
	.uleb128 0x4
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"stddef.h"
	.uleb128 0x3
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"stdlib.h"
	.uleb128 0x3
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"dsp.h"
	.uleb128 0x5
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"../libUDB/libUDB.h"
	.uleb128 0x2
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"libDCM_defines.h"
	.uleb128 0x2
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"libDCM.h"
	.uleb128 0x2
	.uleb128 0x0
	.uleb128 0x0
	.asciz	"motorCntrl.c"
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
	.byte	0x5b
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM2
	.byte	0x27
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM3
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM4
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM5
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM6
	.byte	0x10
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM7
	.byte	0x1b
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM8
	.byte	0x1d
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM9
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM10
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM11
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM12
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM13
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM14
	.byte	0x17
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
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM18
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM19
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM20
	.byte	0x1c
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM21
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM22
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM23
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM24
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM25
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM26
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM27
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM28
	.byte	0x3
	.sleb128 -37
	.byte	0x1
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM29
	.byte	0x3e
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM30
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM31
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM32
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM33
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM34
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM35
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM36
	.byte	0x18
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM37
	.byte	0x18
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM38
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM39
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM40
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM41
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM42
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM43
	.byte	0x18
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM44
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM45
	.byte	0x20
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM46
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM47
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM48
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM49
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM50
	.byte	0x18
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM51
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM52
	.byte	0x1e
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM53
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM54
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM55
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM56
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM57
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM58
	.byte	0x18
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM59
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM60
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM61
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM62
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM63
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM64
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM65
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM66
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM67
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM68
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM69
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM70
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM71
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM72
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM73
	.byte	0x18
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM74
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM75
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM76
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM77
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM78
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM79
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM80
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM81
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM82
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM83
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM84
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM85
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM86
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM87
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM88
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM89
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM90
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM91
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM92
	.byte	0x16
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM93
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM94
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM95
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM96
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM97
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM98
	.byte	0x18
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM99
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM100
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM101
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM102
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM103
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM104
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM105
	.byte	0x15
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.LM106
	.byte	0x17
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	.Letext0
	.byte	0x0
	.uleb128 0x1
	.byte	0x1
.LELT0:
	.section	.debug_info,info
	.4byte	0x798
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.Ldebug_line0
	.4byte	.Letext0
	.4byte	.Ltext0
	.asciz	"GNU C 4.0.3 (dsPIC30, Microchip v3_30) (A) Build date: Jun  2 2011"
	.byte	0x1
	.asciz	"../motorCntrl.c"
	.ascii	"/home/markw/Dropbox/autopilots/UAVdevboard/UDB4/mplabx_projects/MPQp"
	.asciz	"id400/MatrixPilotQuad/MPQpid400.X"
	.uleb128 0x2
	.asciz	"unsigned char"
	.byte	0x1
	.byte	0x8
	.uleb128 0x3
	.4byte	0x109
	.asciz	"ww"
	.byte	0x4
	.byte	0x1
	.byte	0x1d
	.uleb128 0x4
	.asciz	"W0"
	.byte	0x1
	.byte	0x1d
	.4byte	0x109
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x4
	.asciz	"W1"
	.byte	0x1
	.byte	0x1d
	.4byte	0x109
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0x0
	.uleb128 0x2
	.asciz	"int"
	.byte	0x2
	.byte	0x5
	.uleb128 0x2
	.asciz	"long int"
	.byte	0x4
	.byte	0x5
	.uleb128 0x5
	.4byte	0x13f
	.asciz	"longww"
	.byte	0x4
	.byte	0x1
	.byte	0x21
	.uleb128 0x6
	.asciz	"WW"
	.byte	0x1
	.byte	0x21
	.4byte	0x110
	.uleb128 0x6
	.asciz	"_"
	.byte	0x1
	.byte	0x21
	.4byte	0xe3
	.byte	0x0
	.uleb128 0x7
	.4byte	.LASF0
	.byte	0x2
	.byte	0x7
	.uleb128 0x8
	.asciz	"boolean"
	.byte	0x1
	.byte	0x9c
	.4byte	0x155
	.uleb128 0x2
	.asciz	"char"
	.byte	0x1
	.byte	0x6
	.uleb128 0x3
	.4byte	0x1b4
	.asciz	"udb_flag_bits"
	.byte	0x2
	.byte	0x1
	.byte	0xa8
	.uleb128 0x9
	.asciz	"unused"
	.byte	0x1
	.byte	0xa9
	.4byte	0x13f
	.byte	0x2
	.byte	0x6
	.byte	0xa
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x9
	.asciz	"a2d_read"
	.byte	0x1
	.byte	0xaa
	.4byte	0x13f
	.byte	0x2
	.byte	0x1
	.byte	0x9
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x9
	.asciz	"radio_on"
	.byte	0x1
	.byte	0xab
	.4byte	0x13f
	.byte	0x2
	.byte	0x1
	.byte	0x8
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x2
	.asciz	"short unsigned int"
	.byte	0x2
	.byte	0x7
	.uleb128 0x2
	.asciz	"long unsigned int"
	.byte	0x4
	.byte	0x7
	.uleb128 0x8
	.asciz	"fractional"
	.byte	0x5
	.byte	0x5c
	.4byte	0x109
	.uleb128 0x5
	.4byte	0x21a
	.asciz	"udb_fbts_byte"
	.byte	0x2
	.byte	0x6
	.byte	0x77
	.uleb128 0x6
	.asciz	"_"
	.byte	0x6
	.byte	0x77
	.4byte	0x15d
	.uleb128 0x6
	.asciz	"B"
	.byte	0x6
	.byte	0x77
	.4byte	0x155
	.byte	0x0
	.uleb128 0x3
	.4byte	0x246
	.asciz	"relative2D"
	.byte	0x4
	.byte	0x7
	.byte	0x1b
	.uleb128 0x4
	.asciz	"x"
	.byte	0x7
	.byte	0x1b
	.4byte	0x109
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x4
	.asciz	"y"
	.byte	0x7
	.byte	0x1b
	.4byte	0x109
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0x0
	.uleb128 0x2
	.asciz	"float"
	.byte	0x4
	.byte	0x4
	.uleb128 0xa
	.4byte	0x394
	.byte	0x1
	.asciz	"motorCntrl"
	.byte	0x9
	.byte	0x48
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5e
	.uleb128 0xb
	.asciz	"temp"
	.byte	0x9
	.byte	0x49
	.4byte	0x109
	.byte	0x2
	.byte	0x7e
	.sleb128 18
	.uleb128 0xb
	.asciz	"min_throttle"
	.byte	0x9
	.byte	0x4b
	.4byte	0x109
	.byte	0x2
	.byte	0x7e
	.sleb128 16
	.uleb128 0xb
	.asciz	"motor_A"
	.byte	0x9
	.byte	0x4d
	.4byte	0x109
	.byte	0x2
	.byte	0x7e
	.sleb128 14
	.uleb128 0xb
	.asciz	"motor_B"
	.byte	0x9
	.byte	0x4e
	.4byte	0x109
	.byte	0x2
	.byte	0x7e
	.sleb128 12
	.uleb128 0xb
	.asciz	"motor_C"
	.byte	0x9
	.byte	0x4f
	.4byte	0x109
	.byte	0x2
	.byte	0x7e
	.sleb128 10
	.uleb128 0xb
	.asciz	"motor_D"
	.byte	0x9
	.byte	0x50
	.4byte	0x109
	.byte	0x2
	.byte	0x7e
	.sleb128 8
	.uleb128 0xb
	.asciz	"commanded_roll_body_frame"
	.byte	0x9
	.byte	0x52
	.4byte	0x109
	.byte	0x2
	.byte	0x7e
	.sleb128 6
	.uleb128 0xb
	.asciz	"commanded_pitch_body_frame"
	.byte	0x9
	.byte	0x53
	.4byte	0x109
	.byte	0x2
	.byte	0x7e
	.sleb128 4
	.uleb128 0xb
	.asciz	"commanded_tilt"
	.byte	0x9
	.byte	0x55
	.4byte	0x394
	.byte	0x2
	.byte	0x7e
	.sleb128 20
	.uleb128 0xb
	.asciz	"long_accum"
	.byte	0x9
	.byte	0x57
	.4byte	0x11c
	.byte	0x2
	.byte	0x7e
	.sleb128 26
	.uleb128 0xc
	.4byte	.LBB2
	.4byte	.LBE2
	.uleb128 0xd
	.asciz	"roll_rate_error"
	.byte	0x9
	.2byte	0x104
	.4byte	0x109
	.byte	0x2
	.byte	0x7e
	.sleb128 2
	.uleb128 0xd
	.asciz	"pitch_rate_error"
	.byte	0x9
	.2byte	0x10f
	.4byte	0x109
	.byte	0x2
	.byte	0x7e
	.sleb128 0
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.4byte	0x3a4
	.4byte	0x109
	.uleb128 0xf
	.4byte	0x3a4
	.byte	0x2
	.byte	0x0
	.uleb128 0x7
	.4byte	.LASF0
	.byte	0x2
	.byte	0x7
	.uleb128 0xe
	.4byte	0x3b6
	.4byte	0x109
	.uleb128 0x10
	.byte	0x0
	.uleb128 0x11
	.asciz	"udb_pwIn"
	.byte	0x6
	.byte	0x66
	.4byte	0x3ab
	.byte	0x1
	.byte	0x1
	.uleb128 0xe
	.4byte	0x3d3
	.4byte	0x109
	.uleb128 0x10
	.byte	0x0
	.uleb128 0x11
	.asciz	"udb_pwTrim"
	.byte	0x6
	.byte	0x6d
	.4byte	0x3c8
	.byte	0x1
	.byte	0x1
	.uleb128 0xe
	.4byte	0x3f2
	.4byte	0x109
	.uleb128 0x10
	.byte	0x0
	.uleb128 0x11
	.asciz	"udb_pwOut"
	.byte	0x6
	.byte	0x73
	.4byte	0x3e7
	.byte	0x1
	.byte	0x1
	.uleb128 0x11
	.asciz	"udb_flags"
	.byte	0x6
	.byte	0x77
	.4byte	0x1f1
	.byte	0x1
	.byte	0x1
	.uleb128 0xe
	.4byte	0x423
	.4byte	0x1df
	.uleb128 0x10
	.byte	0x0
	.uleb128 0x11
	.asciz	"rmat"
	.byte	0x8
	.byte	0x5e
	.4byte	0x418
	.byte	0x1
	.byte	0x1
	.uleb128 0xe
	.4byte	0x43c
	.4byte	0x1df
	.uleb128 0x10
	.byte	0x0
	.uleb128 0x11
	.asciz	"accelEarth"
	.byte	0x8
	.byte	0x61
	.4byte	0x431
	.byte	0x1
	.byte	0x1
	.uleb128 0x11
	.asciz	"theta"
	.byte	0x9
	.byte	0x1b
	.4byte	0x394
	.byte	0x1
	.byte	0x1
	.uleb128 0x11
	.asciz	"didCalibrate"
	.byte	0x9
	.byte	0x1c
	.4byte	0x146
	.byte	0x1
	.byte	0x1
	.uleb128 0x11
	.asciz	"commanded_tilt_gain"
	.byte	0x9
	.byte	0x1f
	.4byte	0x109
	.byte	0x1
	.byte	0x1
	.uleb128 0xe
	.4byte	0x4a2
	.4byte	0x13f
	.uleb128 0xf
	.4byte	0x3a4
	.byte	0x3
	.byte	0x0
	.uleb128 0x12
	.asciz	"pid_gains"
	.byte	0x9
	.byte	0x23
	.4byte	0x492
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pid_gains
	.uleb128 0x12
	.asciz	"roll_control"
	.byte	0x9
	.byte	0x25
	.4byte	0x109
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_roll_control
	.uleb128 0x12
	.asciz	"pitch_control"
	.byte	0x9
	.byte	0x26
	.4byte	0x109
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pitch_control
	.uleb128 0x12
	.asciz	"yaw_control"
	.byte	0x9
	.byte	0x27
	.4byte	0x109
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_yaw_control
	.uleb128 0x12
	.asciz	"pitch_step"
	.byte	0x9
	.byte	0x28
	.4byte	0x109
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pitch_step
	.uleb128 0x12
	.asciz	"matrix_accum"
	.byte	0x9
	.byte	0x29
	.4byte	0x21a
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_matrix_accum
	.uleb128 0x12
	.asciz	"earth_yaw"
	.byte	0x9
	.byte	0x2b
	.4byte	0x13f
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_earth_yaw
	.uleb128 0x12
	.asciz	"desired_heading"
	.byte	0x9
	.byte	0x2c
	.4byte	0x13f
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_desired_heading
	.uleb128 0x12
	.asciz	"accel_feedback"
	.byte	0x9
	.byte	0x2d
	.4byte	0x109
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_accel_feedback
	.uleb128 0xe
	.4byte	0x5a2
	.4byte	0x109
	.uleb128 0xf
	.4byte	0x3a4
	.byte	0x1
	.byte	0x0
	.uleb128 0x12
	.asciz	"theta_previous"
	.byte	0x9
	.byte	0x2e
	.4byte	0x592
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_theta_previous
	.uleb128 0x12
	.asciz	"theta_delta"
	.byte	0x9
	.byte	0x2f
	.4byte	0x592
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_theta_delta
	.uleb128 0xe
	.4byte	0x5e9
	.4byte	0x109
	.uleb128 0xf
	.4byte	0x3a4
	.byte	0x4
	.byte	0x0
	.uleb128 0x12
	.asciz	"pwManual"
	.byte	0x9
	.byte	0x31
	.4byte	0x5d9
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pwManual
	.uleb128 0x12
	.asciz	"commanded_roll"
	.byte	0x9
	.byte	0x32
	.4byte	0x109
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_commanded_roll
	.uleb128 0x12
	.asciz	"commanded_pitch"
	.byte	0x9
	.byte	0x33
	.4byte	0x109
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_commanded_pitch
	.uleb128 0x12
	.asciz	"commanded_yaw"
	.byte	0x9
	.byte	0x34
	.4byte	0x109
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_commanded_yaw
	.uleb128 0x12
	.asciz	"roll_error"
	.byte	0x9
	.byte	0x36
	.4byte	0x109
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_roll_error
	.uleb128 0x12
	.asciz	"pitch_error"
	.byte	0x9
	.byte	0x37
	.4byte	0x109
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pitch_error
	.uleb128 0x12
	.asciz	"yaw_error"
	.byte	0x9
	.byte	0x38
	.4byte	0x109
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_yaw_error
	.uleb128 0x12
	.asciz	"yaw_rate_error"
	.byte	0x9
	.byte	0x39
	.4byte	0x109
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_yaw_rate_error
	.uleb128 0x12
	.asciz	"yaw_error_previous"
	.byte	0x9
	.byte	0x3d
	.4byte	0x109
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_yaw_error_previous
	.uleb128 0x12
	.asciz	"roll_error_integral"
	.byte	0x9
	.byte	0x3f
	.4byte	0x11c
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_roll_error_integral
	.uleb128 0x12
	.asciz	"pitch_error_integral"
	.byte	0x9
	.byte	0x40
	.4byte	0x11c
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pitch_error_integral
	.uleb128 0x12
	.asciz	"yaw_error_integral"
	.byte	0x9
	.byte	0x41
	.4byte	0x11c
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_yaw_error_integral
	.uleb128 0xe
	.4byte	0x756
	.4byte	0x109
	.uleb128 0xf
	.4byte	0x3a4
	.byte	0x8
	.byte	0x0
	.uleb128 0x12
	.asciz	"target_orientation"
	.byte	0x9
	.byte	0x43
	.4byte	0x746
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_target_orientation
	.uleb128 0x12
	.asciz	"yaw_command_gain"
	.byte	0x9
	.byte	0x45
	.4byte	0x796
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_yaw_command_gain
	.uleb128 0x13
	.4byte	0x109
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
	.uleb128 0x4
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
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
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
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
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
	.uleb128 0x8
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
	.uleb128 0x9
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
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.uleb128 0x21
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
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
	.uleb128 0x12
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
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x13
	.uleb128 0x26
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x1e7
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x79c
	.4byte	0x24f
	.asciz	"motorCntrl"
	.4byte	0x4a2
	.asciz	"pid_gains"
	.4byte	0x4ba
	.asciz	"roll_control"
	.4byte	0x4d5
	.asciz	"pitch_control"
	.4byte	0x4f1
	.asciz	"yaw_control"
	.4byte	0x50b
	.asciz	"pitch_step"
	.4byte	0x524
	.asciz	"matrix_accum"
	.4byte	0x53f
	.asciz	"earth_yaw"
	.4byte	0x557
	.asciz	"desired_heading"
	.4byte	0x575
	.asciz	"accel_feedback"
	.4byte	0x5a2
	.asciz	"theta_previous"
	.4byte	0x5bf
	.asciz	"theta_delta"
	.4byte	0x5e9
	.asciz	"pwManual"
	.4byte	0x600
	.asciz	"commanded_roll"
	.4byte	0x61d
	.asciz	"commanded_pitch"
	.4byte	0x63b
	.asciz	"commanded_yaw"
	.4byte	0x657
	.asciz	"roll_error"
	.4byte	0x670
	.asciz	"pitch_error"
	.4byte	0x68a
	.asciz	"yaw_error"
	.4byte	0x6a2
	.asciz	"yaw_rate_error"
	.4byte	0x6bf
	.asciz	"yaw_error_previous"
	.4byte	0x6e0
	.asciz	"roll_error_integral"
	.4byte	0x702
	.asciz	"pitch_error_integral"
	.4byte	0x725
	.asciz	"yaw_error_integral"
	.4byte	0x756
	.asciz	"target_orientation"
	.4byte	0x777
	.asciz	"yaw_command_gain"
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
