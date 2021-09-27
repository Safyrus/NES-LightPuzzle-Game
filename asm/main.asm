.include "stage/level_edit.asm"
.include "stage/level_load.asm"
.include "stage/level_play.asm"
.include "stage/level_win.asm"
.include "stage/level_loose.asm"
.include "stage/menu.asm"
.include "stage/menu_load.asm"

main:
    ; wait for a transition to finish
    @waitPPUOffCounter:
        LDA PPUOffcounter
        BNE @waitPPUOffCounter

    ; wait for the screen to refresh
    @waitDrawEnd:
        LDA drawStates
        AND #%10000000
        BEQ @waitDrawEnd

    LDA drawStates  ; clear the draw_end flag
    AND #%01111111
    STA drawStates

    LDA #$00        ; "reset" bgDrawData array
    STA bgDataIndex
    STA bgDrawData

    JSR readjoy     ; read controllers inputs

    LDA gameStage   ; get the variable gameStage
    CMP #STG::MENU   ; are we in the Menu stage ?
    BEQ @menu
    CMP #STG::MENU_LOAD     ; are we in the MenuLoad stage ?
    BEQ @menu_load
    CMP #STG::LEVEL_EDIT    ; are we in the LevelEdit stage ?
    BEQ @level_edit
    CMP #STG::LEVEL_LOAD    ; are we in the LevelLoad stage ?
    BEQ @level_load
    CMP #STG::LEVEL_PLAY    ; are we in the LevelPlay stage ?
    BEQ @level_play
    CMP #STG::LEVEL_WIN    ; are we in the LevelWin stage ?
    BEQ @level_win
    CMP #STG::LEVEL_LOOSE  ; are we in the LevelLoose stage ?
    BEQ @level_loose

    @end:
    JSR update_btn_timer
    LDA #$00        ; put a zero at the end of bgDrawData array
    LDX bgDataIndex
    STA bgDrawData, X
    JMP main        ; return to the start of the main loop

    ; stages
    @level_edit:
        JSR stage_level_edit
        JMP @end
    @level_load:
        JSR stage_level_load
        JMP @end
    @level_play:
        JSR stage_level_play
        JMP @end
    @level_win:
        JSR stage_level_win
        JMP @end
    @level_loose:
        JSR stage_level_loose
        JMP @end
    @menu:
        JSR stage_menu
        JMP @end
    @menu_load:
        JSR stage_menu_load
        JMP @end
