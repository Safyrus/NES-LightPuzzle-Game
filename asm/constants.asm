;**********
; Constants
;**********

; PPU
PPUCTRL := $2000
PPUMASK := $2001
PPUSTATUS := $2002
PPUSCROLL := $2005
PPUADDR := $2006
PPUDATA := $2007

; APU
APU := $4000
APU_PULSE1_CTRL := $4000
APU_PULSE1_SWEEP := $4001
APU_PULSE1_TIME_LOW := $4002
APU_PULSE1_TIME_HIGH := $4003
APU_PULSE2_CTRL := $4004
APU_PULSE2_SWEEP := $4005
APU_PULSE2_TIME_LOW := $4006
APU_PULSE2_TIME_HIGH := $4007
APU_TRI_1 := $4008
APU_TRI_2 := $400A
APU_TRI_3 := $400B
APU_NOISE_1 := $400C
APU_NOISE_2 := $400E
APU_NOISE_3 := $400F
APU_DMC := $4010
APU_CTRL := $4015
APU_STATUS := $4015
APU_FRAME := $4017

; IO
JOYPAD1 = $4016
JOYPAD2 = $4017
BTN_TIMER = 16

; OAM
OAMDMA := $4014

; Game
LASER_MAX := 32
POS_OUTOFMAP = $F0
LEVEL_MAX := 7
MAXLASERPERFRAME := 3 ; need to be a power of 2-1

; Game Stage
.enum STG
    LEVEL_EDIT
    WIN
    MENU_LOAD
    MENU
    LEVEL_LOAD
    LEVEL_PLAY
    LEVEL_WIN
    LEVEL_LOOSE
.endenum

; Meta Tiles
.enum MTILE
    VOID
    WALL
    GROUND
    UIBOT
    LOCK
    LASER_HOR
    LASER_VER
    LASER_CROSS
    NULL_08
    NULL_09
    NULL_0A
    NULL_0B
    NULL_0C
    NULL_0D
    NULL_0E
    NULL_0F

    EMIT_UP
    EMIT_DOWN
    EMIT_LEFT
    EMIT_RIGHT
    EMIT_UP_ON
    EMIT_DOWN_ON
    EMIT_LEFT_ON
    EMIT_RIGHT_ON
    RECEIVE_UP
    RECEIVE_DOWN
    RECEIVE_LEFT
    RECEIVE_RIGHT
    RECEIVE_UP_ON
    RECEIVE_DOWN_ON
    RECEIVE_LEFT_ON
    RECEIVE_RIGHT_ON

    MIRROR_1
    MIRROR_2
    MIRROR_CROSS1
    MIRROR_CROSS2
    MIRROR_UL
    MIRROR_UR
    MIRROR_DL
    MIRROR_DR
    MIRRORC_UL
    MIRRORC_UR
    MIRRORC_DL
    MIRRORC_DR
    TIMEWALL_OFF
    TIMEWALL_ON
    NULL_2E
    NULL_2F

    DOOR_H
    DOOR_V
    DOORL_H
    DOORL_V
    SPLITTER_H
    SPLITTER_V
    SPLITTER_H_ON
    SPLITTER_V_ON
    MERGER_H
    MERGER_V
    MERGER_H_T
    MERGER_V_L
    MERGER_H_B
    MERGER_V_R
    MERGER_H_ON
    MERGER_V_ON

    SPE_ARRAY = $FF
.endenum


.enum SPR
    NULL
    CURS1
    CURS2
    ZERO
.endenum