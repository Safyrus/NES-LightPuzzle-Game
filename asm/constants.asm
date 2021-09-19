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

; OAM
OAMDMA := $4014

; Game
LASER_MAX := 16
POS_OUTOFMAP = $F0

; Game Stage
STG_PLAY = 0
STG_WIN = 1
STG_MENU_LOAD = 2
STG_MENU = 3
STG_PLAY_LOAD = 4
STG_PLAY_LEVEL = 5

; Meta Tiles
.enum MTILE
    VOID
    WALL
    GROUND
    UITOP
    EMIT_UP
    EMIT_DOWN
    EMIT_LEFT
    EMIT_RIGHT
    RECEIVE_UP
    RECEIVE_DOWN
    RECEIVE_LEFT
    RECEIVE_RIGHT
    LASER_HOR
    LASER_VER
    LASER_CROSS
    LOCK

    MIRROR_UL
    MIRROR_UR
    MIRROR_DL
    MIRROR_DR
    MIRROR_CROSS1
    MIRROR_CROSS2
    MIRRORC_UL
    MIRRORC_UR
    MIRRORC_DL
    MIRRORC_DR
    TL_1A
    TL_1B
    TL_1C
    TL_1D
    TL_1E
    TL_1F

    DOOR_H
    DOOR_V
    DOORL_H
    DOORL_V
    SPLITTER_H
    SPLITTER_V
    MERGER_H
    MERGER_V
    TIMEWALL_OFF
    TIMEWALL_ON

    SPE_ARRAY = $FF
.endenum
