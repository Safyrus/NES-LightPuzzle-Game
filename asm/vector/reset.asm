RESET:
    SEI         ; Disable interrupt
    CLD         ; Clear/disable decimal

    LDX #$FF    ; Initialized stack
    TXS

    INX         ; X=0
    STX PPUCTRL ; Disable NMI
    STX PPUMASK ; Disable Rendering
    STX APU_DMC_FREQ ; Disable DMC IRQ

    ; Wait for the PPU to initialized
    BIT PPUSTATUS       ; Clear the VBL flag if it was set at reset time
rst_vwait1:
    BIT PPUSTATUS
    BPL rst_vwait1      ; At this point, about 27384 cycles have passed

rst_clrmem:
    LDA #$00
    STA $0000, x
    STA $0100, x
    STA $0200, x
    STA $0300, x
    STA $0400, x
    STA $0500, x
    STA $0600, x
    STA $0700, x
    INX
    BNE rst_clrmem

rst_vwait2:
    BIT PPUSTATUS
    BPL rst_vwait2      ; At this point, about 57165 cycles have passed

    LDA #%00000000
    STA APU_FRAME

    LDA #%10010000      ; Enable NMI + set background table to $1000
    STA PPUCTRL

    LDA #STG::MENU_LOAD ; set the stage to MenuLoad
    STA game_stage

    CLI

    JMP main