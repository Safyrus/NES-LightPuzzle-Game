VBLANK:
    pushreg

    LDA draw_states
    AND #%01000000
    BEQ vblank_update
        LDA draw_states
        AND #%00100000
        BEQ vblank_turn_ppu_off

        LDX ppu_off_counter
        CPX #$00
        BEQ vblank_turn_ppu_flag_off
        DEX
        STX ppu_off_counter
        JMP vblank_end

        vblank_turn_ppu_off:
            LDA draw_states
            ORA #%00100000
            STA draw_states

            LDA #%00000000  ; Disable rendering
            STA PPUMASK

            JMP vblank_end

        vblank_turn_ppu_flag_off:
            LDA draw_states
            AND #%10011111
            STA draw_states

            JMP vblank_end
    vblank_update:

    LDA draw_states
    AND #%00000010
    BEQ vblank_spr_update_end
    vblank_spr_update:
        LDA #$02        ; Update sprites
        STA OAMDMA
    vblank_spr_update_end:

    LDA draw_states
    AND #%00000001
    BEQ vblank_bg_update_end
    ; Background updating
    BIT PPUSTATUS   ; reset latch
    LDX #$FF        ; reset X to 0, it will serve as an array index
    vblank_bg_update:
        INX
        LDA bg_draw_data, X       ; Check if next string length is 0
        BEQ vblank_bg_update_end ; If 0, then stop because it means
                                ; their is no more data to draw

        TAY     ; save data length in Y

        INX                 ; Write high byte of address
        LDA bg_draw_data, X
        STA PPUADDR

        INX
        LDA bg_draw_data, X   ; Write low byte of addres
        STA PPUADDR

        ; write data
        vblank_bg_update_loop:
            INX
            LDA bg_draw_data, X
            STA PPUDATA

            DEY
            CPY #$00
            BNE vblank_bg_update_loop
        JMP vblank_bg_update
    vblank_bg_update_end:

    LDA draw_states
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

    LDA draw_states
    AND #%00001000
    BEQ vblank_palette_end
    vblank_palette:
        JSR load_palettes_ppu
    vblank_palette_end:

    LDA draw_states
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
    LDA draw_states ; set draw_end flag
    ORA #%10000000
    STA draw_states

    pullreg
    RTI     ; Return
