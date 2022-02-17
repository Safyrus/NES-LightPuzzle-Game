; X = level
draw_level:
    pushreg

    ; get level address
    LDA level_array_hi, X
    STA data_adr_h
    LDA level_array_lo, X
    STA data_adr_l

    ; save level index
    TXA
    PHA

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
    CMP #$00
    BNE @lv1
    JSR draw_text_level_0
    @lv1:
    CMP #$01
    BNE @lv5
    JSR draw_text_level_1
    @lv5:
    CMP #$05
    BNE @end
    JSR draw_text_level_5

    @end:
    pullreg
    RTS

draw_level_edit:
    pushreg

    LDX #$00
    @loop:
        ; draw
        LDA level_edit, X
        BEQ @loop_end
        TAY
        JSR draw_metatile

        @loop_end:
        ; loop
        INX
        CPX #$F0
        BNE @loop

    pullreg
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
    
    LDX #LEVEL_MAX
    JSR draw_level  ; Draw the title level

    ; display txt_start
    LDA #$22
    STA vram_adr_h
    LDA #$0A
    STA vram_adr_l
    LDA #>txt_start
    STA data_adr_h
    LDA #<txt_start
    STA data_adr_l
    JSR draw_text

    LDA game_flags
    AND #%00000001
    BEQ @draw_txt_resume_end
        ; display txt_resume
        LDA #$4A
        STA vram_adr_l
        LDA #>txt_resume
        STA data_adr_h
        LDA #<txt_resume
        STA data_adr_l
        JSR draw_text
    @draw_txt_resume_end:

    ; display txt_selectlevel
    LDA #$8A
    STA vram_adr_l
    LDA #>txt_selectlevel
    STA data_adr_h
    LDA #<txt_selectlevel
    STA data_adr_l
    JSR draw_text

    ; display txt_version
    LDA #$23
    STA vram_adr_h
    LDA #$0A
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

    ; set PPU address to the top left of the second nametable
    BIT PPUSTATUS
    LDA #$24
    STA PPUADDR
    LDA #$00
    STA PPUADDR

    ; clean 5 rows of tiles
    LDX #$00
    LDA #$00
    @loop_void:
        STA PPUDATA
        INX
        CPX #($5*$20)
        BNE @loop_void

    ; draw the bottom line
    LDX #$00
    LDA #$52
    @loop_line:
        STA PPUDATA
        INX
        CPX #$20
        BNE @loop_line

    ; draw the number of items
    LDY #$00
    @loop_item_number:
        ; find the item index
        TYA
        TAX
        JSR find_item_index

        ; compute the item position on the UI
        LDA #$24
        STA vram_adr_h
        TXA
        ASL
        ASL
        CLC
        ADC #$81
        CMP #$96
        BCC @draw
        SEC
        SBC #$38
        CMP #$76
        BCC @draw
        SEC
        SBC #$38
        SEC

        @draw:
        ; set the PPU address
        STA vram_adr_l
        BIT PPUSTATUS
        LDA vram_adr_h
        STA PPUADDR
        LDA vram_adr_l
        STA PPUADDR

        ; draw the correct number
        LDA level_selectable_object_count, Y
        CLC
        ADC #$10
        STA PPUDATA
        ; draw a x sign
        LDA #$37
        STA PPUDATA
        ; draw the icon
        TYA
        TAX
        JSR find_item_index
        LDA tile_icon_table, X
        STA PPUDATA

        ; loop
        INY
        CPY max_selected
        BNE @loop_item_number


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


draw_text_level_0:
    PHA

    ; draw txt arrow button
    LDA #<txt_btn_move_1
    STA data_adr_l
    LDA #>txt_btn_move_1
    STA data_adr_h
    LDA #$D5
    STA vram_adr_l
    LDA #$21
    STA vram_adr_h
    JSR draw_text
    LDA #<txt_btn_move_2
    STA data_adr_l
    LDA #>txt_btn_move_2
    STA data_adr_h
    LDA #$F4
    STA vram_adr_l
    JSR draw_text
    LDA #<txt_btn_move_3
    STA data_adr_l
    LDA #>txt_btn_move_3
    STA data_adr_h
    LDA #$15
    STA vram_adr_l
    LDA #$22
    STA vram_adr_h
    JSR draw_text

    ; draw txt start button
    LDA #<txt_btn_start
    STA data_adr_l
    LDA #>txt_btn_start
    STA data_adr_h
    LDA #$54
    STA vram_adr_l
    JSR draw_text

    ; draw txt goal
    LDA #<txt_goal
    STA data_adr_l
    LDA #>txt_goal
    STA data_adr_h
    LDA #$2B
    STA vram_adr_l
    LDA #$21
    STA vram_adr_h
    JSR draw_text

    PLA
    RTS


draw_text_level_1:
    PHA

    ; draw txt A button
    LDA #<txt_btn_a_1
    STA data_adr_l
    LDA #>txt_btn_a_1
    STA data_adr_h
    LDA #$26
    STA vram_adr_l
    LDA #$23
    STA vram_adr_h
    JSR draw_text
    LDA #<txt_btn_a_2
    STA data_adr_l
    LDA #>txt_btn_a_2
    STA data_adr_h
    LDA #$48
    STA vram_adr_l
    JSR draw_text

    ; draw txt B button
    LDA #<txt_btn_b
    STA data_adr_l
    LDA #>txt_btn_b
    STA data_adr_h
    LDA #$31
    STA vram_adr_l
    JSR draw_text

    PLA
    RTS


draw_text_level_5:
    PHA

    ; draw txt select button
    LDA #<txt_btn_select
    STA data_adr_l
    LDA #>txt_btn_select
    STA data_adr_h
    LDA #$2A
    STA vram_adr_l
    LDA #$23
    STA vram_adr_h
    JSR draw_text

    PLA
    RTS
