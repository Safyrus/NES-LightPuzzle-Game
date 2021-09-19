; 
drawLevel:
    RTS
    RTS
    RTS

; X = Coord, Y= ID
drawMetaTile:
    PHA
    TXA
    PHA

    ; set VRAM adr
    JSR getMTileNametableAdr
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
    JSR incDataAdr
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
    JSR getMTileNametableAdr
    LDX #$20        ; add $20 to dataAdr
    JSR addDataAdr
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
    JSR incDataAdr
    LDX #$00
    LDA (dataAdr, X)

    ; set lower left tile
    STA PPUDATA

    ; inc MTile adr
    JSR incDataAdr
    LDA (dataAdr, X)

    ; set lower right tile
    STA PPUDATA

    PLA
    TAX
    PLA
    RTS

;
drawMenu:
    bit PPUSTATUS   ; reset adress latch
    LDA #$20        ; set the vram address to start from
    STA PPUADDR
    LDA #$00
    STA PPUADDR
    
    LDA #$00        ; tile number
    LDX #$04        ; number of high loop
    drawMenu_back1:
        LDY #$F0        ; number of low loop
        drawMenu_back2:
            STA PPUDATA
    
            DEY
            CPY #$00
            BNE drawMenu_back2

        DEX
        CPX #$00
        BNE drawMenu_back1

    bit PPUSTATUS   ; reset adress latch
    LDA #$21        ; set the vram address to start from
    STA PPUADDR
    LDA #$10
    STA PPUADDR

    LDX #$00
    drawMenu_title:
        LDA txt_menu, X
        STA PPUDATA
        INX

        CPX #$04
        BNE drawMenu_title
    RTS


; add a string of data to update the background
; param: A= length, dataAdr, vramAdr
updateBgData:
    CMP #$00
    BEQ updateBgData_end

    LDY bgDataIndex
    STA bgDrawData, Y

    TAX

    INY
    LDA vramAdr_h
    STA bgDrawData, Y
    INY
    LDA vramAdr_l
    STA bgDrawData, Y

    STY bgDataIndex
    LDA #$00
    STA counter
    updateBgData_data:
        LDY counter
        LDA (dataAdr), Y
        INY
        STY counter

        LDY bgDataIndex
        INY
        STA bgDrawData, Y
        STY bgDataIndex

        DEX
        CPX #$00
        BNE updateBgData_data
        LDY bgDataIndex
    INY
    STY bgDataIndex
    updateBgData_end:
    RTS
