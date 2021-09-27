move_cursor:
    PHA
    
    LDA buttons1Timer   ;check if buttons are unlock
    BNE @end

    LDA buttons1    ; check what direction was pressed
    LSR
    BCS @right
    LSR
    BCS @left
    LSR
    BCS @down
    LSR
    BCS @up
    JMP @end

    @right:
        LDA cursX
        AND #%11110000
        CMP #$F0
        BEQ @end
        CLC
        ADC #$10
        STA cursX
        JMP @end

    @left:
        LDA cursX
        AND #%11110000
        BEQ @end
        SEC
        SBC #$10
        STA cursX
        JMP @end

    @down:
        LDA cursY
        AND #%11110000
        CMP #$E0
        BEQ @end
        CLC
        ADC #$10
        STA cursY
        JMP @end

    @up:
        LDA cursY
        AND #%11110000
        BEQ @end
        SEC
        SBC #$10
        STA cursY
        JMP @end

    @end:
    PLA
    RTS


place_at_cursor:
    pushreg

    LDA buttons1Timer   ;check if buttons are unlock
    BNE @end

    LDA buttons1    ; check if B was pressed
    AND #%01000000
    BEQ @end

    LDA cursX   ; compute the cursor pos in the level
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC cursY
    TAX

    LDA level, X
    CLC
    ADC #$01
    TAY
    STA level, X

    JSR get_metaTile_nametable_adr
    LDA dataAdr_l
    STA vramAdr_l
    LDA dataAdr_h
    STA vramAdr_h
    TYA
    TAX
    JSR update_bg_metaTile
    

    @end:
    pullreg
    RTS
