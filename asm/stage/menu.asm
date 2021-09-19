stage_menu:
    LDA drawStates
    ORA #%00000001
    STA drawStates

    LDA buttons1
    AND #%00110000  ; start or select
    CMP #$00
    BNE stage_menu_play
    LDA buttons1
    AND #%10000000  ; A
    CMP #$00
    BNE stage_menu_A
    LDA buttons1
    AND #%01000000  ; B
    CMP #$00
    BNE stage_menu_B
    JMP stage_menu_end

    stage_menu_A:
        LDX #(2*12)+3
        JSR playNote
        JMP stage_menu_end
    stage_menu_B:
        LDX #(2*12)+0
        JSR playNote
        JMP stage_menu_end

    stage_menu_play:
        LDA drawStates  ; Disable PPU at the next Vblank
        AND #%11111100
        ORA #%01000000
        STA drawStates
        LDA #30        ; Disable for 30 frame
        STA PPUOffcounter

        LDA #STG_PLAY_LOAD  ; load the main game
        STA gameStage

    stage_menu_end:
    RTS
