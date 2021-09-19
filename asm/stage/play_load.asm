stage_play_load:
    JSR initGame    ; initialized the main game

    LDA #STG_PLAY   ; Change gameStage to Play
    STA gameStage

    LDA drawStates
    ORA #%00000011
    STA drawStates

    LDA #%00011110  ; Activate sprites and background and the left 8 pixels
    STA PPUMASK

    RTS
