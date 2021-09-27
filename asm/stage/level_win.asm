stage_level_win:
    LDA buttons1
    AND #%00110000
    BEQ @end
        LDA drawStates  ; Disable PPU at the next Vblank
        AND #%11111100
        ORA #%01000000
        STA drawStates
        LDA #30        ; Disable for 30 frame
        STA PPUOffcounter

        LDA #STG::LEVEL_LOAD  ; load the main game
        STA gameStage
    @end:
    RTS
