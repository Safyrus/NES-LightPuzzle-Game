stage_play:
    ;LDA buttons1
    ;CMP #$00
    ;BEQ stage_play_end

    ; TODO create laser base on emitter
    LDA #STG_PLAY_LEVEL   ; Change gameStage to PlayLevel
    STA gameStage

    stage_play_end:
    RTS
