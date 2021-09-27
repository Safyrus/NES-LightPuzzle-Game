; X = level
draw_level:
    PHA
    TXA
    PHA
    TYA
    PHA

    ; get level address
    LDA levelArrayHi, X
    STA dataAdr_h
    LDA levelArrayLo, X
    STA dataAdr_l

    LDX #$00
    @loop:
        ; Check if Special Mtile
        LDY #$00
        LDA (dataAdr), Y
        CMP #$FF
        BEQ @array

        @normal:
            ; draw Mtile
            TAY
            JSR draw_metaTile
            INX
            JSR inc_dataAdr
            JMP @loopEnd

        @array:
            ; get length
            JSR inc_dataAdr
            LDA (dataAdr), Y
            STA counter
            ; get tile
            JSR inc_dataAdr
            @array_loop:
                LDY #$00
                LDA (dataAdr), Y
                TAY
                JSR draw_metaTile
                INX

                LDY counter
                DEY
                STY counter
                CPY #$00
                BNE @array_loop

        @loopEnd:
        CPX #$F0
        BNE @loop

    PLA
    TAY
    PLA
    TAX
    PLA
    RTS

; X = Coord, Y= ID
draw_metaTile:
    ; push registers
    PHA
    TXA
    PHA
    ; push dataAdr
    LDA dataAdr_l
    PHA
    LDA dataAdr_h
    PHA

    ; set VRAM adr
    JSR get_metaTile_nametable_adr
    BIT PPUSTATUS   ; reset adress latch
    LDA dataAdr_h
    STA PPUADDR
    LDA dataAdr_l
    STA PPUADDR

    ; push X
    TXA
    PHA
    
    ; get MTile adr
    LDA metaTileArrayHi, Y
    STA dataAdr_h
    LDA metaTileArrayLo, Y
    STA dataAdr_l
    LDX #$00
    LDA (dataAdr, X)

    ; set upper left tile
    STA PPUDATA

    ; inc MTile adr
    JSR inc_dataAdr
    LDA (dataAdr, X)

    ; set upper right tile
    STA PPUDATA

    ; Pull X
    PLA
    TAX
    ; Push MTile adr
    LDA dataAdr_l
    PHA
    LDA dataAdr_h
    PHA

    ; set VRAM adr
    JSR get_metaTile_nametable_adr
    LDX #$20        ; add $20 to dataAdr
    JSR add_dataAdr
    BIT PPUSTATUS   ; reset adress latch
    LDA dataAdr_h   ; set VRAM adr
    STA PPUADDR
    LDA dataAdr_l
    STA PPUADDR

    ; Pull MTile adr
    PLA
    STA dataAdr_h
    PLA
    STA dataAdr_l

    ; inc MTile adr
    JSR inc_dataAdr
    LDX #$00
    LDA (dataAdr, X)

    ; set lower left tile
    STA PPUDATA

    ; inc MTile adr
    JSR inc_dataAdr
    LDA (dataAdr, X)

    ; set lower right tile
    STA PPUDATA

    ; pull dataAdr
    PLA
    STA dataAdr_h
    PLA
    STA dataAdr_l
    ; pull registers
    PLA
    TAX
    PLA
    RTS

;
draw_menu:
    bit PPUSTATUS   ; reset adress latch
    LDA #$20        ; set the vram address to start from
    STA PPUADDR
    LDA #$00
    STA PPUADDR
    
    LDA #$00        ; tile number
    LDX #$04        ; number of high loop
    @back1:
        LDY #$F0        ; number of low loop
        @back2:
            STA PPUDATA
    
            DEY
            CPY #$00
            BNE @back2

        DEX
        CPX #$00
        BNE @back1

    bit PPUSTATUS   ; reset adress latch
    LDA #$21        ; set the vram address to start from
    STA PPUADDR
    LDA #$10
    STA PPUADDR

    LDX #$00
    @title:
        LDA txt_menu, X
        STA PPUDATA
        INX

        CPX #$04
        BNE @title
    RTS

