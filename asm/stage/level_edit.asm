stage_level_edit:
    LDA drawStates
    AND #%11110111  ; disable palette update
    ORA #%00010111  ; render background and sprites +
    STA drawStates  ; attributes and scroll update

    LDA #%00011110  ; Activate sprites and background and the left 8 pixels
    STA PPUMASK

    JSR wait_ui

    JSR move_cursor
    JSR change_at_cursor
    JSR place_at_cursor
    JSR remove_at_cursor
    JSR update_cursor_sprite

    LDA buttons1
    AND #%00100000
    BEQ @btn_select_end

        LDA buttons1Timer   ; check if buttons are unlock
        BNE @btn_select_end

        LDX selected
        INX
        CPX maxSelected
        BCC @selected
        LDX #$00
        @selected:
        STX selected
    @btn_select_end:

    @btn_start:
    LDA buttons1
    AND #%00010000
    BEQ @end

        JSR level_place_edit
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
