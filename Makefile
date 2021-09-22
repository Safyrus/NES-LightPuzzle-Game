CA65 = ../cc65/bin/ca65.exe
LD65 = ../cc65/bin/ld65.exe
#EMULATOR = ../fceux-2.2.3-win32/fceux.exe
EMULATOR = ../Mesen/Mesen.exe
HEXDUMP = ..\hexdump.exe
GAME_NAME = lightPuzzle

all:
	.\$(CA65) asm/$(GAME_NAME).asm --debug-info
	.\$(LD65) asm/$(GAME_NAME).o -C $(GAME_NAME).cfg -o $(GAME_NAME).nes --dbgfile $(GAME_NAME).DBG
	make clean

clean:
	del asm\$(GAME_NAME).o

run:
	.\$(EMULATOR) $(GAME_NAME).nes

hex:
	.\$(HEXDUMP) $(GAME_NAME).nes > dump.txt