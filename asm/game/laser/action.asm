; X = laser index
; Y = laser position
laser_action_move:
    PHA

    TYA
    STA laserArray_pos, X   ; set new laser position

    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_ground:
    PHA
    TYA
    PHA

    TYA
    STA laserArray_pos, X   ; set new laser position

    TXA
    TAY
    JSR laser_draw_ground

    PLA
    TAY
    PLA
    RTS


; X = laser index
laser_action_stop:
    PHA

    LDA laserArray_state, X
    ORA #%00000100
    STA laserArray_state, X

    PLA
    RTS

; X = laser index
laser_action_stop_restart:
    PHA

    LDA laserArray_state, X
    ORA #%00001100
    STA laserArray_state, X

    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_laserhor:
    PHA
    TYA
    PHA

    TYA
    STA laserArray_pos, X   ; set new laser position
    TXA
    TAY
    JSR laser_draw_crosshor

    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_laserver:
    PHA
    TYA
    PHA

    TYA
    STA laserArray_pos, X   ; set new laser position
    TXA
    TAY
    JSR laser_draw_crossver

    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_1:
    PHA
    TYA
    PHA

    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_mirror1

    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_2:
    PHA
    TYA
    PHA

    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_mirror2

    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_ul:
    PHA
    TYA
    PHA

    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_mirror_ul

    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_ur:
    PHA
    TYA
    PHA

    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_mirror_ur

    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_dl:
    PHA
    TYA
    PHA

    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_mirror_dl

    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_dr:
    PHA
    TYA
    PHA

    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_mirror_dr

    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_mirror_cross1:
    JMP move_laser_mirror1

; X = laser index
; Y = laser position
laser_action_mirror_cross2:
    JMP move_laser_mirror1

; X = laser index
; Y = laser position
laser_action_receive_up:
    PHA
    TYA
    PHA

    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X

    LDA laserArray_state, X ; check if the laser is going down
    AND #%00000011
    CMP #$01
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_up

    @end:
    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_receive_down:
    PHA
    TYA
    PHA

    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X

    LDA laserArray_state, X ; check if the laser is going up
    AND #%00000011
    CMP #$00
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_down

    @end:
    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_receive_left:
    PHA
    TYA
    PHA

    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X

    LDA laserArray_state, X ; check if the laser is going right
    AND #%00000011
    CMP #$03
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_left

    @end:
    PLA
    TAY
    PLA
    RTS

; X = laser index
; Y = laser position
laser_action_receive_right:
    PHA
    TYA
    PHA

    TYA
    STA laserArray_pos, X   ; set new laser position

    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X

    LDA laserArray_state, X ; check if the laser is going left
    AND #%00000011
    CMP #$02
    BNE @end

    TXA                     ; if yes, change the receiver to an active one
    TAY
    JSR laser_draw_receive_right

    @end:
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_corner_ul:
    PHA
    TYA
    PHA

    LDA laserArray_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$01    ; is it going down ?
    BEQ @yes
    CMP #$03    ; is it going right ?
    BEQ @yes

    @nop:
    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X
    JMP @end

    @yes:
    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_activate

    @end:
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_corner_ur:
    PHA
    TYA
    PHA

    LDA laserArray_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$01    ; is it going down ?
    BEQ @yes
    CMP #$02    ; is it going left ?
    BEQ @yes

    @nop:
    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X
    JMP @end

    @yes:
    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_activate

    @end:
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_corner_dl:
    PHA
    TYA
    PHA

    LDA laserArray_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$00    ; is it going up ?
    BEQ @yes
    CMP #$03    ; is it going right ?
    BEQ @yes

    @nop:
    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X
    JMP @end

    @yes:
    JSR move_laser_mirror2

    TXA
    TAY
    JSR laser_draw_activate

    @end:
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_mirror_corner_dr:
    PHA
    TYA
    PHA

    LDA laserArray_state, X  ; get direction of the laser
    AND #%00000011
    CMP #$00    ; is it going up ?
    BEQ @yes
    CMP #$02    ; is it going left ?
    BEQ @yes

    @nop:
    LDA laserArray_state, X ; stop the laser
    ORA #%00000100
    STA laserArray_state, X
    JMP @end

    @yes:
    JSR move_laser_mirror1

    TXA
    TAY
    JSR laser_draw_activate

    @end:
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_splitter_h:
    PHA

    ; check if laser is going verticaly
    LDA laserArray_state, X
    AND #%00000010
    BNE @end

    ; add 2 laser going left and right
    JSR add_laser_left
    JSR add_laser_right
    ; set splitter to ON
    LDA #MTILE::SPLITTER_H_ON
    STA level, Y

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_splitter_v:
    PHA

    ; check if laser is going horizontaly
    LDA laserArray_state, X
    AND #%00000010
    BEQ @end

    ; add 2 laser going up and down
    JSR add_laser_up
    JSR add_laser_down
    ; set splitter to ON
    LDA #MTILE::SPLITTER_V_ON
    STA level, Y

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_merger_h:
    pushreg

    ; check if laser is going verticaly
    LDA laserArray_state, X
    AND #%00000010
    BNE @end

    ; set merger to a "1 laser state"
    LDA laserArray_state, X
    BEQ @up
    @down:
    LDA #MTILE::MERGER_H_T
    JMP @update
    @up:
    LDA #MTILE::MERGER_H_B
    @update:
    STA level, Y

    @end:
    JSR laser_action_stop
    pullreg
    RTS


; X = laser index
; Y = laser position
laser_action_merger_v:
    PHA

    ; check if laser is going horizontaly
    LDA laserArray_state, X
    AND #%00000010
    BEQ @end

    ; set merger to a "1 laser state"
    LDA laserArray_state, X
    CMP #$02
    BEQ @left
    @right:
    LDA #MTILE::MERGER_V_L
    JMP @update
    @left:
    LDA #MTILE::MERGER_V_R
    @update:
    STA level, Y

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_merger_ht:
    PHA

    ; check if laser is going up
    LDA laserArray_state, X
    CMP #$00
    BNE @end

    ; set merger to ON
    LDA #MTILE::MERGER_H_ON
    STA level, Y
    ; add 2 laser going left and right
    JSR add_laser_left
    JSR add_laser_right

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_merger_hb:
    PHA

    ; check if laser is going down
    LDA laserArray_state, X
    CMP #$01
    BNE @end

    ; set merger to ON
    LDA #MTILE::MERGER_H_ON
    STA level, Y
    ; add 2 laser going left and right
    JSR add_laser_left
    JSR add_laser_right

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_merger_vl:
    PHA

    ; check if laser is going left
    LDA laserArray_state, X
    CMP #$02
    BNE @end

    ; set merger to ON
    LDA #MTILE::MERGER_H_ON
    STA level, Y
    ; add 2 laser going up and down
    JSR add_laser_up
    JSR add_laser_down

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_merger_vr:
    PHA

    ; check if laser is going right
    LDA laserArray_state, X
    CMP #$03
    BNE @end

    ; set merger to ON
    LDA #MTILE::MERGER_H_ON
    STA level, Y
    ; add 2 laser going up and down
    JSR add_laser_up
    JSR add_laser_down

    @end:
    JSR laser_action_stop
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_door_h:
    PHA
    TYA
    PHA

    ; check if laser is going verticaly
    LDA laserArray_state, X
    AND #%00000010
    BNE @stop

    JSR laser_action_move

    ; set door to ON
    LDA #MTILE::DOOR_H_ON
    STA level, Y

    ; restart lasers at the door
    JSR move_laser_restart

    LDA counter
    BEQ @draw_close
    @draw_open:
    ; draw the open door
    TXA
    TAY
    JSR laser_draw_door_h_on
    JSR laser_draw_activate
    JMP @end
    @draw_close:
    ; draw the close but active door
    TXA
    TAY
    JSR laser_draw_activate
    JMP @end

    @stop:
    JSR laser_action_move
    JSR laser_action_stop_restart
    @end:
    JSR laser_action_stop
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_door_v:
    PHA
    TYA
    PHA

    ; check if laser is going horizontaly
    LDA laserArray_state, X
    AND #%00000010
    BEQ @stop

    JSR laser_action_move

    ; set door to ON
    LDA #MTILE::DOOR_V_ON
    STA level, Y

    ; restart lasers at the door
    JSR move_laser_restart

    LDA counter
    BEQ @draw_close
    @draw_open:
    ; draw the open door
    TXA
    TAY
    JSR laser_draw_door_h_on
    JSR laser_draw_activate
    JMP @end
    @draw_close:
    ; draw the close but active door
    TXA
    TAY
    JSR laser_draw_activate
    JMP @end

    @stop:
    JSR laser_action_move
    JSR laser_action_stop_restart
    @end:
    JSR laser_action_stop
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_door_h_on:
    PHA
    TYA
    PHA

    ; check if laser is going horizontaly
    LDA laserArray_state, X
    AND #%00000010
    BEQ @stop

    JSR laser_action_move

    ; draw the open door
    TXA
    TAY
    JSR laser_draw_door_h_on
    JMP @end

    @stop:
    JSR laser_action_stop
    @end:
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_door_v_on:
    PHA
    TYA
    PHA

    ; check if laser is going verticaly
    LDA laserArray_state, X
    AND #%00000010
    BNE @stop

    JSR laser_action_move

    ; draw the open door
    TXA
    TAY
    JSR laser_draw_door_v_on
    JMP @end

    @stop:
    JSR laser_action_stop
    @end:
    PLA
    TAY
    PLA
    RTS


; X = laser index
; Y = laser position
laser_action_glass:
    PHA
    TYA
    PHA

    JSR laser_action_move
    TXA
    TAY
    JSR laser_draw_activate

    PLA
    TAY
    PLA
    RTS
