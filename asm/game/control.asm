;
readjoy:
    LDA #$01
    STA JOYPAD1
    STA buttons2  ; player 2's buttons double as a ring counter
    LSR A         ; now A is 0
    STA JOYPAD1
    @loop:
        LDA JOYPAD1
        AND #%00000011  ; ignore bits other than controller
        CMP #$01        ; Set carry if and only if nonzero
        ROL buttons1    ; Carry -> bit 0; bit 7 -> Carry
        LDA JOYPAD2     ; Repeat
        AND #%00000011
        CMP #$01
        ROL buttons2    ; Carry -> bit 0; bit 7 -> Carry
        BCC @loop
    RTS


update_btn_timer:
    @timer:
    LDA buttons1Timer   ; decrease buttons1Timer if it is not 0
    BEQ @timerReset
    SEC
    SBC #$01
    STA buttons1Timer
    JMP @end

    @timerReset:
    LDA buttons1        ; set buttons1Timer if any button was pressed
    BEQ @end
    LDA #BTN_TIMER
    STA buttons1Timer

    @end:
    RTS
