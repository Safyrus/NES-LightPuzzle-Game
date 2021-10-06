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

    ; display txt_game_title
    LDA #$20
    STA vramAdr_h
    LDA #$A8
    STA vramAdr_l
    LDA #>txt_game_title
    STA dataAdr_h
    LDA #<txt_game_title
    STA dataAdr_l
    JSR draw_text

    ; display txt_menu
    LDA #$21
    STA vramAdr_h
    LDA #$2E
    STA vramAdr_l
    LDA #>txt_menu
    STA dataAdr_h
    LDA #<txt_menu
    STA dataAdr_l
    JSR draw_text

    ; display txt_level
    LDA #$CC
    STA vramAdr_l
    LDA #>txt_level
    STA dataAdr_h
    LDA #<txt_level
    STA dataAdr_l
    JSR draw_text

    ; display txt_version
    LDA #$23
    STA vramAdr_h
    LDA #$0D
    STA vramAdr_l
    LDA #>txt_version
    STA dataAdr_h
    LDA #<txt_version
    STA dataAdr_l
    JSR draw_text

    RTS


;
draw_ui:
    pushreg

    BIT PPUSTATUS
    LDA #$24
    STA PPUADDR
    LDA #$00
    STA PPUADDR

    LDX #$00
    LDA #$00
    @loop_void:
        STA PPUDATA
        INX
        CPX #($5*$20)
        BNE @loop_void

    LDX #$00
    LDA #$52
    @loop_line:
        STA PPUDATA
        INX
        CPX #$20
        BNE @loop_line
    
    LDA #$24
    STA vramAdr_h
    LDA #$80
    STA vramAdr_l
    LDA #>txt_ui_1
    STA dataAdr_h
    LDA #<txt_ui_1
    STA dataAdr_l
    JSR draw_text

    LDA #$60
    STA vramAdr_l
    LDA #>txt_ui_2
    STA dataAdr_h
    LDA #<txt_ui_2
    STA dataAdr_l
    JSR draw_text

    LDA #$40
    STA vramAdr_l
    LDA #>txt_ui_3
    STA dataAdr_h
    LDA #<txt_ui_3
    STA dataAdr_l
    JSR draw_text

    LDA PPUSTATUS   ; read PPU status to reset the high/low latch
    LDA #$27
    STA PPUADDR     ; write the high byte of $27C0 address
    LDA #$C0
    STA PPUADDR     ; write the low byte of $27C0 address

    LDX #$00        ; start out at 0
    LDA #$00        ; load UI palette
    @loop:
        STA PPUDATA     ; write to PPU
        INX             ; X = X + 1
        CPX #$40        ; Compare X to $40
        BNE @loop       ; Branch to loop if compare was Not Equal to zero
                        ; if compare was equal, keep going down

    pullreg
    RTS


; dataAdr = text pointer
; vramAdr = text location
draw_text:
    pushreg

    BIT PPUSTATUS   ; reset adress latch
    LDA vramAdr_h   ; set the vram address to start from
    STA PPUADDR
    LDA vramAdr_l
    STA PPUADDR

    LDY #$00
    @loop:
        LDA (dataAdr), Y
        CMP #$FF
        BEQ @end
        STA PPUDATA
        JSR inc_dataAdr
        JMP @loop
    @end:
    pullreg
    RTS
