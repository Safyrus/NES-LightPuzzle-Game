; Memory Map
; $0000-$00FF: Zero Page with global variables
; $0100-$01FF: Stack
; $0200-$02FF: OAM Buffer

.segment "ZEROPAGE"
; 7: draw_end flag
; 6: disablePPU
; 5: PPUDisable
; 4: scroll update
; 3: palettes update
; 2: attributes update
; 1: sprite update
; 0: background update
drawStates: .res 1
; Game stage index
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

.res 64-15

bgDataIndex: .res 1
bgDrawData: .res 63

.res 32

palettes: .res 32

attributes: .res 64

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
level: .res 240
level_obj_cnt: .res 8
level_palette: .res 2
level_data: .res 6

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
