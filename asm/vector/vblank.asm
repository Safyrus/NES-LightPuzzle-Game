VBLANK:
    PHA     ; back up registers
    TXA
    PHA
    TYA
    PHA

    LDA drawStates
    AND #%01000000
    CMP #$00
    BEQ vblank_sprUpdate
        LDA drawStates
        AND #%00100000
        CMP #$00
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

    vblank_sprUpdate:
    LDA drawStates
    AND #%00000010
    CMP #$00
    BEQ vblank_sprUpdate_end
        LDA #$02        ; Update sprites
        STA OAMDMA
    vblank_sprUpdate_end:

    LDA drawStates
    AND #%00000001
    CMP #$00
    BEQ vblank_bgUpdate_end

    ; Background updating
    bit PPUSTATUS   ; set scrolling position to 0,0
    LDX #$FF        ; reset X to 0, it will serve as an array index
    vblank_bgUpdate:
        INX
        LDA bgDrawData, X       ; Check if next string length is 0
        CMP #$00                ; If 0, then stop because it means
        BEQ vblank_bgUpdate_end ; their is no more data to draw

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

    vblank_end:
    bit PPUSTATUS   ; set scrolling position to 0,0
    LDA #$00
    STA PPUSCROLL
    LDA #$00
    STA PPUSCROLL

    LDA drawStates ; set draw_end flag
    ORA #%10000000
    STA drawStates

    PLA     ; restore regs
    TAY
    PLA
    TAX
    PLA
    
    RTI     ; Return
