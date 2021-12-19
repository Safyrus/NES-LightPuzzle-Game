; X = level
draw_level:
    PHA
    TXA
    PHA
    TYA
    PHA

    ; get level address
    LDA level_array_hi, X
    STA data_adr_h
    LDA level_array_lo, X
    STA data_adr_l

    LDX #$00
    @loop:
        ; Check if Special Mtile
        LDY #$00
        LDA (data_adr), Y
        CMP #$FF
        BEQ @array

        @normal:
            ; draw Mtile
            TAY
            JSR draw_metatile
            INX
            JSR inc_data_adr
            JMP @loop_end

        @array:
            ; get length
            JSR inc_data_adr
            LDA (data_adr), Y
            STA counter
            ; get tile
            JSR inc_data_adr
            @array_loop:
                LDY #$00
                LDA (data_adr), Y
                TAY
                JSR draw_metatile
                INX

                LDY counter
                DEY
                STY counter
                CPY #$00
                BNE @array_loop

        @loop_end:
        CPX #$F0
        BNE @loop

    PLA
    TAY
    PLA
    TAX
    PLA
    RTS

; X = Coord, Y= ID
draw_metatile:
    ; push registers
    PHA
    TXA
    PHA
    ; push data_adr
    LDA data_adr_l
    PHA
    LDA data_adr_h
    PHA

    ; set VRAM adr
    JSR get_metatile_nametable_adr
    BIT PPUSTATUS   ; reset adress latch
    LDA data_adr_h
    STA PPUADDR
    LDA data_adr_l
    STA PPUADDR

    ; push X
    TXA
    PHA
    
    ; get MTile adr
    LDA metatile_array_hi, Y
    STA data_adr_h
    LDA metatile_array_lo, Y
    STA data_adr_l
    LDX #$00
    LDA (data_adr, X)

    ; set upper left tile
    STA PPUDATA

    ; inc MTile adr
    JSR inc_data_adr
    LDA (data_adr, X)

    ; set upper right tile
    STA PPUDATA

    ; Pull X
    PLA
    TAX
    ; Push MTile adr
    LDA data_adr_l
    PHA
    LDA data_adr_h
    PHA

    ; set VRAM adr
    JSR get_metatile_nametable_adr
    LDX #$20        ; add $20 to data_adr
    JSR add_data_adr
    BIT PPUSTATUS   ; reset adress latch
    LDA data_adr_h   ; set VRAM adr
    STA PPUADDR
    LDA data_adr_l
    STA PPUADDR

    ; Pull MTile adr
    PLA
    STA data_adr_h
    PLA
    STA data_adr_l

    ; inc MTile adr
    JSR inc_data_adr
    LDX #$00
    LDA (data_adr, X)

    ; set lower left tile
    STA PPUDATA

    ; inc MTile adr
    JSR inc_data_adr
    LDA (data_adr, X)

    ; set lower right tile
    STA PPUDATA

    ; pull data_adr
    PLA
    STA data_adr_h
    PLA
    STA data_adr_l
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
    STA vram_adr_h
    LDA #$A8
    STA vram_adr_l
    LDA #>txt_game_title
    STA data_adr_h
    LDA #<txt_game_title
    STA data_adr_l
    JSR draw_text

    ; display txt_menu
    LDA #$21
    STA vram_adr_h
    LDA #$2E
    STA vram_adr_l
    LDA #>txt_menu
    STA data_adr_h
    LDA #<txt_menu
    STA data_adr_l
    JSR draw_text

    ; display txt_level
    LDA #$CC
    STA vram_adr_l
    LDA #>txt_level
    STA data_adr_h
    LDA #<txt_level
    STA data_adr_l
    JSR draw_text

    ; display txt_version
    LDA #$23
    STA vram_adr_h
    LDA #$0D
    STA vram_adr_l
    LDA #>txt_version
    STA data_adr_h
    LDA #<txt_version
    STA data_adr_l
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
    STA vram_adr_h
    LDA #$80
    STA vram_adr_l
    LDA #>txt_ui_1
    STA data_adr_h
    LDA #<txt_ui_1
    STA data_adr_l
    JSR draw_text

    LDA #$60
    STA vram_adr_l
    LDA #>txt_ui_2
    STA data_adr_h
    LDA #<txt_ui_2
    STA data_adr_l
    JSR draw_text

    LDA #$40
    STA vram_adr_l
    LDA #>txt_ui_3
    STA data_adr_h
    LDA #<txt_ui_3
    STA data_adr_l
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


; data_adr = text pointer
; vram_adr = text location
draw_text:
    pushreg

    BIT PPUSTATUS   ; reset adress latch
    LDA vram_adr_h   ; set the vram address to start from
    STA PPUADDR
    LDA vram_adr_l
    STA PPUADDR

    LDY #$00
    @loop:
        LDA (data_adr), Y
        CMP #$FF
        BEQ @end
        STA PPUDATA
        JSR inc_data_adr
        JMP @loop
    @end:
    pullreg
    RTS
