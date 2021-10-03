stage_menu:
    LDA drawStates
    ORA #%00010001
    STA drawStates

    LDA buttons1
    AND #%00110000  ; start or select
    BNE @play
    LDA buttons1
    AND #%10000000  ; A
    BNE @A
    LDA buttons1
    AND #%01000000  ; B
    BNE @B
    JMP @end

    @A:
        LDX #(2*12)+3
        JSR play_note
        JMP @end
    @B:
        LDX #(2*12)+0
        JSR play_note
        JMP @end

    @play:
        JSR change_to_level_load

    @end:
    RTS
