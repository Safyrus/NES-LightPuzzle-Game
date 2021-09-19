main:
    ; wait for a transition to finish
    waitPPUOffCounter:
        LDA PPUOffcounter
        CMP #$00
        BNE waitPPUOffCounter

    ; wait for the screen to refresh
    main_waitDrawEnd:
        LDA drawStates
        AND #%10000000
        CMP #$00
        BEQ main_waitDrawEnd

    LDA drawStates  ; clear the draw_end flag
    AND #%01111111
    STA drawStates

    LDA #$00        ; "reset" bgDrawData array
    STA bgDataIndex
    STA bgDrawData

    JSR readjoy     ; read controllers inputs

    LDA gameStage   ; get the variable gameStage
    CMP #STG_PLAY   ; are we in the Play stage ?
    BEQ main_play
    CMP #STG_MENU   ; are we in the Menu stage ?
    BEQ main_menu
    CMP #STG_MENU_LOAD  ; are we in the MenuLoad stage ?
    BEQ main_menu_load
    CMP #STG_PLAY_LOAD  ; are we in the PlayLoad stage ?
    BEQ main_play_load
    CMP #STG_PLAY_LEVEL  ; are we in the PlayLevel stage ?
    BEQ main_play_level

    main_end:
    LDA #$00        ; put a zero at the end of bgDrawData array
    LDX bgDataIndex
    STA bgDrawData, X
    JMP main        ; return to the start of the main loop

    ; stages
    main_play:
        JSR stage_play
        JMP main_end
    main_play_load:
        JSR stage_play_load
        JMP main_end
    main_play_level:
        JSR stage_play_level
        JMP main_end
    main_menu:
        JSR stage_menu
        JMP main_end
    main_menu_load:
        JSR stage_menu_load
        JMP main_end

.include "stage/play.asm"
.include "stage/play_load.asm"
.include "stage/play_level.asm"
.include "stage/menu.asm"
.include "stage/menu_load.asm"
