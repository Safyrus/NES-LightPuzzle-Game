; Memory Map
; $0000-$00FF: Zero Page with global variables
; $0100-$01FF: Stack
; $0200-$02FF: OAM Buffer
; $0300-$03FF: level
; $0400-$04FF: level_edit
; $0500-$07FF: other global variables



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

; Remaining numbre of frames to turn off the PPU
PPUOffcounter: .res 1

; Temporary 16 bits address variable
dataAdr:
    ; high part of the temporary 16 bits dataAdr variable
    dataAdr_l: .res 1
    ; low part of the temporary 16 bits dataAdr variable
    dataAdr_h: .res 1
; Temporary 16 bits address variable

vramAdr:
    ; high part of the temporary 16 bits vramAdr variable
    vramAdr_l: .res 1
    ; low part of the temporary 16 bits vramAdr variable
    vramAdr_h: .res 1

; Temporary variable use to count
counter: .res 1

; Temporary variable
tmp: .res 1

; Joypad 1 flags
;  0: Right
;  1: Left
;  2: Down
;  3: Up
;  4: Start
;  5: Select
;  6: B
;  7: A

buttons1: .res 1
; Joypad 2 flags
;  0: Right
;  1: Left
;  2: Down
;  3: Up
;  4: Start
;  5: Select
;  6: B
;  7: A
buttons2: .res 1

; Joypad 1 remaning frame before processing input again
buttons1Timer: .res 1

; Cursor X position
cursX: .res 1

; Cursor Y position
cursY: .res 1

; Remaning frames before next cursor animation
cursAnimTimer: .res 1

; Current selected item
selected: .res 1

; maximum item selectable in the level
maxSelected: .res 1

; padding
.res 64-17

; index of the bgDrawData array
bgDataIndex: .res 1

; tiles data to update during vblank
bgDrawData: .res 63

; padding
.res 32

; new palettes data to update at vsync
palettes: .res 32

; attributes data to update at vsync
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

; Modification of the level made by the player
level_edit: .res 240
.res 16

; laser positions array
; position: YYYYXXXX
laserArray_pos: .res LASER_MAX

; laser states array
; states flags: ....RSDD
;  D = Direction (0=up, 1=down, 2=left, 3=right)
;  S = Stop moving
;  R = Restart moving
laserArray_state: .res LASER_MAX

; Array of metatiles corresponding to the selectable items in the level
level_selectable_object_type: .res 16

;Array of number for each selectable items in the level
level_selectable_object_count: .res 16

; current level
level_index: .res 1

; Remaining number of frames befor next level step
level_FrameCounter: .res 1

; Number of lasers updated for the current level step
level_LaserDoneCounter: .res 1

; Number of frames to wait between each step of the level
level_MaxFrame: .res 1

; Number of lasers in the level
level_LaserCount: .res 1
