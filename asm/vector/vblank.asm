VBLANK:
    pushreg

    LDA drawStates
    AND #%01000000
    BEQ vblank_update
        LDA drawStates
        AND #%00100000
        BEQ vblank_turnPPUOff

        LDX PPUOffcounter
        CPX #$00
        BEQ vblank_turnPPUFlagOff
        DEX
        STX PPUOffcounter
        JMP vblank_end

        vblank_turnPPUOff:
            LDA drawStates
            ORA #%00100000
            STA drawStates

            LDA #%00000000  ; Disable rendering
            STA PPUMASK

            JMP vblank_end

        vblank_turnPPUFlagOff:
            LDA drawStates
            AND #%10011111
            STA drawStates

            JMP vblank_end
    vblank_update:

    LDA drawStates
    AND #%00000010
    BEQ vblank_sprUpdate_end
    vblank_sprUpdate:
        LDA #$02        ; Update sprites
        STA OAMDMA
    vblank_sprUpdate_end:

    LDA drawStates
    AND #%00000001
    BEQ vblank_bgUpdate_end
    ; Background updating
    BIT PPUSTATUS   ; reset latch
    LDX #$FF        ; reset X to 0, it will serve as an array index
    vblank_bgUpdate:
        INX
        LDA bgDrawData, X       ; Check if next string length is 0
        BEQ vblank_bgUpdate_end ; If 0, then stop because it means
                                ; their is no more data to draw

        TAY     ; save data length in Y

        INX                 ; Write high byte of address
        LDA bgDrawData, X
        STA PPUADDR

        INX
        LDA bgDrawData, X   ; Write low byte of addres
        STA PPUADDR

        ; write data
        vblank_bgUpdate_loop:
            INX
            LDA bgDrawData, X
            STA PPUDATA

            DEY
            CPY #$00
            BNE vblank_bgUpdate_loop
        JMP vblank_bgUpdate
    vblank_bgUpdate_end:

    LDA drawStates
    AND #%00000100
    BEQ vblank_attribute_end
    vblank_attribute:
        BIT PPUSTATUS   ; reset latch
        LDA #$23
        STA PPUADDR
        LDA #$C0
        STA PPUADDR
        LDX #$00
        vblank_attribute_loop:
            LDA attributes, X
            STA PPUDATA
            INX
            CPX #$40
            BNE vblank_attribute_loop
    vblank_attribute_end:

    LDA drawStates
    AND #%00001000
    BEQ vblank_palette_end
    vblank_palette:
        JSR load_palettes_ppu
    vblank_palette_end:

    LDA drawStates
    AND #%00010000
    BEQ vblank_scroll_end
    vblank_scroll:
        BIT PPUSTATUS   ; reset latch
        LDA #$00        ; set scrolling position to 0,0
        STA PPUSCROLL
        LDA #$00
        STA PPUSCROLL
        LDA #$00        ; set bit 15 of t in PPU to 0
        STA PPUADDR     ; (because, for unknown reason)
        LDA #$00        ; to fix scrolling in the wrong nametable.
        STA PPUADDR
    vblank_scroll_end:

    vblank_end:
    LDA drawStates ; set draw_end flag
    ORA #%10000000
    STA drawStates

    pullreg
    RTI     ; Return
