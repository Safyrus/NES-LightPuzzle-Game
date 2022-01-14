stage_menu:
    LDA draw_states
    AND #%11100000
    ORA #%00011101
    STA draw_states

    ; reset attributes
    LDX #$00
    LDA #$55
    @atr_rst:
        STA attributes, X
        INX
        CPX #$40
        BNE @atr_rst
    
    LDA stage_state
    AND #%00000011
    BEQ @select_start
    CMP #$01
    BEQ @select_resume
    JMP @select_level

    ; change attributes to highlight the selected option
    @select_start:
        LDX #$23
        LDA #$AF
        STA attributes, X
        INX
        STA attributes, X
        JMP @next
    @select_resume:
        LDX #$23
        LDA #$FA
        STA attributes, X
        INX
        STA attributes, X
        JMP @next
    @select_level:
        LDX #$2A
        LDA #$AF
        STA attributes, X
        INX
        STA attributes, X
        INX
        STA attributes, X
        INX
        STA attributes, X
        INX
        STA attributes, X
        JMP @next

    @next:
    ; set level index text to curs_x and curs_y
    LDA level_index
    AND #%00001111
    CLC
    ADC #$10
    STA curs_y
    LDA level_index
    AND #%11110000
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC #$10
    STA curs_x

    ; write level index text
    LDA #$22
    STA vram_adr_h
    LDA #$99
    STA vram_adr_l
    LDA #>curs_x
    STA data_adr_h
    LDA #<curs_x
    STA data_adr_l
    LDX #$02
    JSR update_bg_data

    ; buttons actions
    LDA buttons_1_timer
    BEQ @btn
    JMP @end
    @btn:
        CLC
        LDA buttons_1
        @A:
        ASL
        BCC @B
            LDX #(2*12)+3
            JSR play_note
            JMP @end
        @B:
        ASL
        BCC @SELECT
            LDX #(2*12)+0
            JSR play_note
            JMP @end
        @SELECT:
        ASL
        ; nothing to do when SELECT is pressed
        ; BCC @START
        @START:
        ASL
        BCC @UP
            ; is the START or RESUME options selected ?
            LDA stage_state
            CMP #$02
            BEQ @START_end
            ; is the START option selected ?
            CMP #$00
            BNE @START_load
                ; then set the level to 0
                LDA #$00
                STA level_index
            @START_load:
            ; activate the resume game flag
            LDA game_flags
            ORA #%00000001
            STA game_flags
            ; change the stage to level_load
            JSR change_to_level_load
            @START_end:
            JMP @end
        @UP:
        ASL
        BCC @DOWN
            ; decrease the selected option index
            LDX stage_state
            DEX
            ; have we decremented too low ?
            CPX #$FF
            BNE @UP_resume
                ; then set the index to 2
                LDX #$02
                JMP @UP_state
            @UP_resume:
            ; is the index on the RESUME option ?
            CPX #$01
            BNE @UP_state
                ; is the RESUME option available ?
                LDA game_flags
                AND #%00000001
                BNE @UP_state
                    ; if not, decrease the index again
                    DEX
            @UP_state:
            ; store the new selected option index
            STX stage_state
            JMP @end
        @DOWN:
        ASL
        BCC @LEFT
            ; increase the selected option index
            LDX stage_state
            INX
            ; have we incremented too high ?
            CPX #$03
            BNE @DOWN_resume
                ; then set the index to 0
                LDX #$00
            @DOWN_resume:
            ; is the index on the RESUME option ?
            CPX #$01
            BNE @DOWN_state
                ; is the RESUME option available ?
                LDA game_flags
                AND #%00000001
                BNE @DOWN_state
                    ; if not, increase the index again
                    INX
            @DOWN_state:
            STX stage_state
        @LEFT:
        ASL
        BCC @RIGHT
            LDA stage_state
            CMP #$02
            BNE @end
            LDX level_index
            DEX
            STX level_index
            CPX #LEVEL_MAX
            BCC @end
            LDX #LEVEL_MAX
            DEX
            STX level_index
            JMP @end
        @RIGHT:
        ASL
        BCC @btn_end
            LDA stage_state
            CMP #$02
            BNE @end
            LDX level_index
            INX
            STX level_index
            CPX #LEVEL_MAX
            BCC @end
            LDX #$00
            STX level_index
            JMP @end
    @btn_end:

    @end:
    RTS
