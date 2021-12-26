.include "stage/level_edit.asm"
.include "stage/level_load.asm"
.include "stage/level_play.asm"
.include "stage/level_win.asm"
.include "stage/level_loose.asm"
.include "stage/menu.asm"
.include "stage/menu_load.asm"

main:
    ; wait for a transition to finish
    @wait_ppu_off_counter:
        LDA ppu_off_counter
        BNE @wait_ppu_off_counter

    ; wait for the screen to refresh
    @wait_draw_end:
        LDA draw_states
        AND #%10000000
        BEQ @wait_draw_end

    LDA draw_states ; clear the draw_end flag
    AND #%01111111
    STA draw_states

    LDA #$00        ; "reset" bg_draw_data array
    STA bg_data_index
    STA bg_draw_data

    JSR readjoy     ; read controllers inputs

    LDA game_stage  ; get the variable game_stage
    AND #%00000111  ; modulo 8
    TAX             ; into X
    ; get the address of the stage function from the switch table
    LDA @switch_table_l, X
    STA data_adr_l
    LDA @switch_table_h, X
    STA data_adr_h
    ; call the stage function
    JSR @switch_call

    @end:
    JSR update_btn_timer
    LDA #$00        ; put a zero at the end of bg_draw_data array
    LDX bg_data_index
    STA bg_draw_data, X
    JMP main        ; return to the start of the main loop

    ; call a function in the switch table
    @switch_call:
        JMP (data_adr)

    ; stages
    @switch_table_l:
        .byte <stage_level_edit
        .byte <stage_menu_load
        .byte <stage_menu
        .byte <stage_level_load
        .byte <stage_level_play
        .byte <stage_level_win
        .byte <stage_level_loose
        .byte <@end
    @switch_table_h:
        .byte >stage_level_edit
        .byte >stage_menu_load
        .byte >stage_menu
        .byte >stage_level_load
        .byte >stage_level_play
        .byte >stage_level_win
        .byte >stage_level_loose
        .byte >@end
