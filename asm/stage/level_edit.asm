stage_level_edit:

    LDA drawStates
    AND #%11110111  ; disable palette update
    ORA #%00010111  ; render background and sprites +
    STA drawStates  ; attributes and scroll update

    LDA #%00011110  ; Activate sprites and background and the left 8 pixels
    STA PPUMASK

    JSR move_cursor
    JSR place_at_cursor
    JSR update_cursor_sprite

    LDA buttons1
    AND #%10000000
    BEQ @end

        JSR level_place_lasers

        LDA drawStates
        AND #%11111101
        STA drawStates

        LDA #%00001010  ; Activate background and the left 8 pixels
        STA PPUMASK

        LDA #STG::LEVEL_PLAY   ; Change gameStage to LevelPlay
        STA gameStage

    @end:
    RTS
