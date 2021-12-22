; Memory Map
; $0000-$00FF: Zero Page with global variables
; $0100-$01FF: Stack
; $0200-$02FF: OAM Buffer
; $0300-$03FF: level
; $0400-$04FF: level_edit
; $0500-$07FF: other global variables



.segment "ZEROPAGE"

; 7: draw_end flag
; 6: disable PPU
; 5: PPU disable
; 4: scroll update
; 3: palettes update
; 2: attributes update
; 1: sprite update
; 0: background update
draw_states: .res 1

; Game stage index
game_stage: .res 1

; Stage state
stage_state: .res 1

; Remaining numbre of frames to turn off the PPU
ppu_off_counter: .res 1

; Temporary 16 bits address variable
data_adr:
    ; high part of the temporary 16 bits data_adr variable
    data_adr_l: .res 1
    ; low part of the temporary 16 bits data_adr variable
    data_adr_h: .res 1

; Temporary 16 bits address variable
vram_adr:
    ; high part of the temporary 16 bits vram_adr variable
    vram_adr_l: .res 1
    ; low part of the temporary 16 bits vram_adr variable
    vram_adr_h: .res 1

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

buttons_1: .res 1
; Joypad 2 flags
;  0: Right
;  1: Left
;  2: Down
;  3: Up
;  4: Start
;  5: Select
;  6: B
;  7: A
buttons_2: .res 1

; Joypad 1 remaning frame before processing input again
buttons_1_timer: .res 1

; Cursor X position
curs_x: .res 1

; Cursor Y position
curs_y: .res 1

; Remaning frames before next cursor animation
curs_anim_timer: .res 1

; Current selected item
selected: .res 1

; maximum item selectable in the level
max_selected: .res 1

; padding
.res 64-18

; index of the bg_draw_data array
bg_data_index: .res 1

; tiles data to update during vblank
bg_draw_data: .res 63

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
spr_curs_ul_y: .res 1
spr_curs_ul: .res 1
spr_curs_ul_atr: .res 1
spr_curs_ul_x: .res 1
spr_curs_ur_y: .res 1
spr_curs_ur: .res 1
spr_curs_ur_atr: .res 1
spr_curs_ur_x: .res 1
spr_curs_dl_y: .res 1
spr_curs_dl: .res 1
spr_curs_dl_atr: .res 1
spr_curs_dl_x: .res 1
spr_curs_dr_y: .res 1
spr_curs_dr: .res 1
spr_curs_dr_atr: .res 1
spr_curs_dr_x: .res 1

; sprite selected
spr_selected_left_y: .res 1
spr_selected_left: .res 1
spr_selected_left_atr: .res 1
spr_selected_left_x: .res 1
spr_selected_middle_y: .res 1
spr_selected_middle: .res 1
spr_selected_middle_atr: .res 1
spr_selected_middle_x: .res 1
spr_selected_right_y: .res 1
spr_selected_right: .res 1
spr_selected_right_atr: .res 1
spr_selected_right_x: .res 1


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
laser_array_pos: .res LASER_MAX

; laser states array
; states flags: ....RSDD
;  D = Direction (0=up, 1=down, 2=left, 3=right)
;  S = Stop moving
;  R = Restart moving
laser_array_state: .res LASER_MAX

; Array of metatiles corresponding to the selectable items in the level
level_selectable_object_type: .res 16

;Array of number for each selectable items in the level
level_selectable_object_count: .res 16

; current level
level_index: .res 1

; Remaining number of frames befor next level step
level_frame_counter: .res 1

; Number of lasers updated for the current level step
level_laser_done_counter: .res 1

; Number of frames to wait between each step of the level
level_max_frame: .res 1

; Number of lasers in the level
level_laser_count: .res 1
