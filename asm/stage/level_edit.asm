stage_level_edit:
    JSR move_cursor
    JSR place_at_cursor
    JSR update_cursor_sprite

    LDA buttons1
    AND #%10000000
    BEQ @end

    ; TODO create laser base on emitter
    LDA #STG::LEVEL_PLAY   ; Change gameStage to LevelPlay
    STA gameStage

    @end:
    RTS
