stage_play:
    LDA buttons1
    BEQ @end

    ; TODO create laser base on emitter
    LDA #STG_PLAY_LEVEL   ; Change gameStage to PlayLevel
    STA gameStage

    @end:
    RTS
