; Load palettes into the VRAM adresses corresponding to palette data
load_palettes_ppu:
    LDA PPUSTATUS       ; read PPU status to reset the high/low latch
    LDA #$3F
    STA PPUADDR         ; write the high byte of $3F00 address
    LDA #$00
    STA PPUADDR         ; write the low byte of $3F00 address

    LDX #$00            ; start out at 0
    @loop:
        LDA palettes, x     ; load data from address
        STA PPUDATA         ; write to PPU
        INX                 ; X = X + 1
        CPX #$20            ; Compare X to $20(4*8 palettes)
        BNE @loop           ; Branch to loop if compare was Not Equal to zero
                            ; if compare was equal, keep going down
    RTS


reset_nametable_attributes:
    LDA PPUSTATUS   ; read PPU status to reset the high/low latch
    LDA #$23
    STA PPUADDR     ; write the high byte of $23C0 address
    LDA #$C0
    STA PPUADDR     ; write the low byte of $23C0 address

    LDX #$00        ; start out at 0
    LDA #$00        ; load default palette
    @loop:
        STA PPUDATA     ; write to PPU
        INX             ; X = X + 1
        CPX #$40        ; Compare X to $40
        BNE @loop       ; Branch to loop if compare was Not Equal to zero
                        ; if compare was equal, keep going down
    RTS


; X = index
; Y = palette
change_attribute:
    pushreg
    LDA counter
    PHA

    TXA
    AND #%00010001
    STA counter

    TXA
    LSR
    TAX

    BCC @plt_x
        TYA
        ASL
        ASL
        TAY
    @plt_x:

    TXA
    AND #$07
    STA tmp
    TXA
    LSR
    LSR
    LSR
    LSR
    TAX

    BCC @plt_y
        TYA
        ASL
        ASL
        ASL
        ASL
        TAY
    @plt_y:

    TXA
    ASL
    ASL
    ASL
    CLC
    ADC tmp
    TAX

    LDA counter
    CMP #$00
    BEQ @ul
    CMP #$01
    BEQ @ur
    CMP #$10
    BEQ @dl
    JMP @dr

    @ul:
        LDA attributes, X
        AND #%11111100
        STA attributes, X
        JMP @set
    @ur:
        LDA attributes, X
        AND #%11110011
        STA attributes, X
        JMP @set
    @dl:
        LDA attributes, X
        AND #%11001111
        STA attributes, X
        JMP @set
    @dr:
        LDA attributes, X
        AND #%00111111
        STA attributes, X

    @set:
    TYA
    ORA attributes, X
    STA attributes, X

    PLA
    STA counter
    pullreg
    RTS


; X = palette table index
; Y = background/sprite palette (.....SII  S= spr palette, I = index)
set_palette:
    pushreg

    TYA
    ASL
    ASL
    TAY

    TXA
    ASL
    ASL
    TAX

    LDA #$00
    STA tmp
    @loop:
        LDA palettes_table, X
        STA palettes, Y
        INX
        INY
        LDA tmp
        CLC
        ADC #$01
        STA tmp
        CMP #$04
        BNE @loop

    @end:
    pullreg
    RTS
