stage_menu:
    LDA drawStates
    ORA #%00000001
    STA drawStates

    LDA buttons1
    AND #%00110000  ; start or select
    BNE @play
    LDA buttons1
    AND #%10000000  ; A
    BNE @A
    LDA buttons1
    AND #%01000000  ; B
    BNE @B
    JMP @end

    @A:
        LDX #(2*12)+3
        JSR play_note
        JMP @end
    @B:
        LDX #(2*12)+0
        JSR play_note
        JMP @end

    @play:
        LDA drawStates  ; Disable PPU at the next Vblank
        AND #%11111100
        ORA #%01000000
        STA drawStates
        LDA #30        ; Disable for 30 frame
        STA PPUOffcounter

        LDA #STG::LEVEL_LOAD  ; load the main game
        STA gameStage

    @end:
    RTS
