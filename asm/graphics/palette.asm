; Load Default palettes into the VRAM adresses corresponding to palette data
loadPalettes:
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


resetNametablePalette:
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