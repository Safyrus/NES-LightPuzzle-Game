# CHANGELOG

The format of this CHANGELOG is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

This project try to follow the [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

-----------------

## **[0.0.2]** - _2021-09-15_

### **Added**

#### Project

- Information for building and running the game in README
- A RAM segment in linker config.

#### ASM

- LASER_MAX, POS_OUTOFMAP and STG_PLAY_LEVEL constants.
- An enum for metatiles.
- Variables for the level and lasers.
- A play_level stage in main.
- _Data:_
  - A lot of metatiles
- _Game:_
  - getNextLaserPos subroutine to find the next position of a laser.
  - laserAction_move subroutine to move and draw a laser.
  - laserAction_stop subroutine to stop a laser.
  - loadLevel subroutine to load a level into RAM.
- _Graphics_:
  - drawLevel subroutine to draw a level onto the screen.
  - updateBgMTile subroutine to update a metatile on the screen during the game.
- _Stage:_
  - An empty play_error stage.
  - A new play_level stage to run the lasers in the current level.

### **Changed**

#### Project

- Some textures (notably the emitter and mirrors textures).

#### ASM

- Include new file in lightPuzzle.asm.
- Move control.asm into game folder.
- Move subroutine.asm into misc folder.
- _Data_:
  - move palette data into its own file.
  - Level 00 (old level 1) to use metatiles constant instead of hard coded value.
  - Level 01 (old level 2) to show every metatiles for testing.
- _Graphics_:
  - save dataAdr when calling drawMetaTile.
  - Move updateBgData in bgUpdate.asm.
- _Stage:_
  - The play stage will switch to stage play_level.
  - Stage play_load now load the first level, draw it to the screen
    and initialized a laser at position (9,5) going up and level_MaxFrame to 60.
- _Vector_:
  - rearrange audio initialization in reset.

### **Removed**

- Useless constants.
- Test metatiles in menu_load.
- Empty init subroutine.

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
