stage_menu:
    LDA drawStates
    ORA #%00010001
    STA drawStates

    LDA level_index
    AND #%00001111
    CLC
    ADC #$10
    STA cursY
    LDA level_index
    AND #%11110000
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC #$10
    STA cursX

    LDA #$21
    STA vramAdr_h
    LDA #$D2
    STA vramAdr_l
    LDA #>cursX
    STA dataAdr_h
    LDA #<cursX
    STA dataAdr_l
    LDX #$02
    JSR update_bg_data

    CLC
    LDA buttons1
    ASL
    BCS @A
    ASL
    BCS @B
    ASL
    BCS @play
    ASL
    BCS @play
    ASL
    BCS @inc
    ASL
    BCS @dec
    ASL
    BCS @dec
    ASL
    BCS @inc
    JMP @end

    @A:
        LDX #(2*12)+3
        JSR play_note
        JMP @end
    @B:
        LDX #(2*12)+0
        JSR play_note
        JMP @end
    @inc:
        LDA buttons1Timer
        BNE @end
        LDX level_index
        INX
        STX level_index
        CPX #LEVEL_MAX
        BCC @end
        LDX #$00
        STX level_index
        JMP @end
    @dec:
        LDA buttons1Timer
        BNE @end
        LDX level_index
        DEX
        STX level_index
        CPX #LEVEL_MAX
        BCC @end
        LDX #LEVEL_MAX
        DEX
        STX level_index
        JMP @end
    @play:
        JSR change_to_level_load

    @end:
    RTS
