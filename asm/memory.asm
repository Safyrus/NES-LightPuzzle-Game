; Memory Map
; $0000-$00FF: Zero Page with global variables
; $0100-$01FF: Stack
; $0200-$02FF: OAM Buffer

.segment "ZEROPAGE"
drawStates: .res 1 ; 7: draw_end flag, 6:disablePPU ,5:PPUDisable, 1: sprUpdate, 0: bgUpdate
gameStage: .res 1
PPUOffcounter: .res 1

dataAdr:
    dataAdr_l: .res 1
    dataAdr_h: .res 1
vramAdr:
    vramAdr_l: .res 1
    vramAdr_h: .res 1
counter: .res 1
tmp: .res 1

buttons1: .res 1
buttons2: .res 1
buttons1Timer: .res 1

cursX: .res 1
cursY: .res 1
cursAnimTimer: .res 1

bgDataIndex: .res 1
bgDrawData: .res 32

.segment "STACK"
stack: .res 256

.segment "OAM"
; sprite 0
spr0_y: .res 1
spr0: .res 1
spr0_atr: .res 1
spr0_x: .res 1

; sprite cursor
sprCursUL_y: .res 1
sprCursUL: .res 1
sprCursUL_atr: .res 1
sprCursUL_x: .res 1
sprCursUR_y: .res 1
sprCursUR: .res 1
sprCursUR_atr: .res 1
sprCursUR_x: .res 1
sprCursDL_y: .res 1
sprCursDL: .res 1
sprCursDL_atr: .res 1
sprCursDL_x: .res 1
sprCursDR_y: .res 1
sprCursDR: .res 1
sprCursDR_atr: .res 1
sprCursDR_x: .res 1


.segment "RAM"
level: .res 256

laserArray_pos: .res LASER_MAX
laserArray_state: .res LASER_MAX
laserAntiArray_pos: .res LASER_MAX
laserAntiArray_state: .res LASER_MAX
; Note about laserState element:
; bits .....SDD
; D = Direction (0=up, 1=down, 2=left, 3=right)
; S = Stop moving


level_index: .res 1
level_FrameCounter: .res 1
level_MaxFrame: .res 1
level_LaserCount: .res 1
level_AntiLaserCount: .res 1
