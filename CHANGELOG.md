# CHANGELOG

The format of this CHANGELOG is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

This project try to follow the [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

-----------------

## **[0.0.1]** - _2021-09-06_

### **Added**

#### Project

- Makefile.
- Config file "lightPuzzle.cfg" for ld65.
- CHR file "lightPuzzle.chr" with basic textures.

#### ASM

- Audio
  - init_apu subroutine to initialize the APU.
  - play_note subroutine to play a note with a frequency locate in periodTable.
- Data
  - Default palettes data for sprites and background.
  - Text txt_null and txt_menu.
  - periodTable low and high address.
  - levelArray which contains address to levels.
  - Levels level_01 and level_02.
  - levelMetaArray which contains address to levels information.
  - Levels meta of level_01 and level_02.
  - MetaTileArray which contains address to metatiles data.
  - MetaTile metaTile_00 and metaTile_01.
- Game
  - Empty init subroutine.
- Graphics
  - Empty drawLevel subrountine.
  - drawMetaTile subrountine to draw a metatile at a given position.
  - drawMenu subrountine to draw the menu stage.
  - updateBgData subroutine to update background tiles during game with data in bgDrawData.
  - loadPalettes subrountine to load default palettes.
  - Empty updateSprite subrountine.
- Stage
  - menu
  - menu_load
  - play
  - play_load
- Vector
  - irq
  - reset
  - vblank (nmi)
- Other
  - constant file for every constant
  - readjoy subroutine to read controllers inputs.
  - lightPuzzle file that define the NES file header and includes all other files.
  - main subroutine that wait for vblank to end and call the current stage subroutine.
  - memory file to define all variables.
  - incDataAdr subroutine to increase the 16bits value dataAdr.
  - decDataAdr subroutine to decrease the 16bits value dataAdr.
  - getMTileNametableAdr subroutine that gets the PPU address of a mtile.

-----------------
