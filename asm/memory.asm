; Memory Map
; $0000-$00FF: Zero Page with global variables
; $0100-$01FF: Stack
; $0200-$02FF: OAM Buffer

.segment "ZEROPAGE"
drawStates: .res 1 ; 7: draw_end flag, 6:disablePPU ,5:PPUDisable, 1: sprUpdate, 0: bgUpdate
gameStage: .res 1
PPUOffcounter: .res 1

dataAdr:
dataAdr_l: .res 1
dataAdr_h: .res 1
vramAdr:
vramAdr_l: .res 1
vramAdr_h: .res 1
counter: .res 1
tmp: .res 1

buttons1: .res 1
buttons2: .res 1

string: .res 8

bgDataIndex: .res 1
bgDrawData: .res 32


.segment "OAM"
; sprite 0
spr0_y: .res 1
spr0: .res 1
spr0_atr: .res 1
spr0_x: .res 1
