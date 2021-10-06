# CHANGELOG

The format of this CHANGELOG is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

This project try to follow the [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

-----------------

## **[0.1.0]** - _2021-10-06_

### **Added**

#### ASM

- _Data:_
  - select_tiles array to know what metatiles can be selected.
  - New text (game_title, ui_1, ui_2, ui_3, version, level).
  - Add two new level.
- _Game:_
  - remove_at_cursor subroutine to remove a previously placed object from the
    level by pressing B, also update the number of this object and the UI display.
  - change_at_cursor subroutine to change the state of a previously placed object
    in the level (only mirrors are affected for now).
  - level_place_edit subroutine to transfer level_edit metatiles to the level.
  - load_object subroutine to load object type and numbers in
    level_selectable_object arrays and set maxSelected.
- _Graphics:_
  - draw_ui subroutine to draw the UI on the second nametable.
  - draw_text subroutine to draw a string of characters.
  - update_ui_count subroutine to update one of the number of an object.
- _Stage:_
  - LevelWin and LevelLoose controls (A or B) to return to the menu.
- _Variables:_
  - ppu_ctrl variable to save the last data send to PPUCTRL.
  - selected variable to know what object has been selected
    and maxSelected variable to know how many objects can be selected.
  - level_edit page to save change made to the level by the player.
  - level_selectable_object_type array to know what type of object we can select
    in the level.
  - level_selectable_object_count array to know how many objects we have in the level.
  - change_to_menu_load subroutine.
- _Other:_
  - Constants LEVEL_MAX and SPR::ZERO.
  - wait_spr0 subroutine to return once a sprite zero hit has happened.
  - wait_ui subroutine to wait for the UI to be drawn.

### **Changed**

- Tiles location in CHR and add a sprite for spr0.

#### ASM

- _Data:_
  - Renamed metatile UI_TOP to UI_BOT.
  - Level 0 by replacing void and UI tiles by walls and changing the number of objects.
  - Rename Level 1 to Level Debug and change the number of objects to max.
- _Game:_
  - change control to place a tile to A.
  - place_at_cursor now place the selected object in the level and
    update the number of this object and its display in the UI.
  - load_level to also reset the level_edit and loading object.
- _Graphics_:
  - draw_menu stage to now display the temporary game title, the version and the
    selected level.
- _Stage:_
  - Menu stage to now select the level to load.
  - MenuLoad now reset palette, attribute and spr0.
  - LevelLoad now load the level in level_index, reset selected object to 0,
    load UI default palette and draw the UI.
  - LevelEdit to now draw the UI, change or remove the object at the cursor,
    select another item by pressing SELECT. Also switching to LevelPlay is now
    done by pressing START and add placed object to the level.
- _Vector:_
  - In reset, move palette and attribute reset to the stage MenuLoad
    and initialized ppu_ctrl.
  - Vblank update PPUCTRL with ppu_ctrl during scroll update.
- _Other:_
  - Laser are now updated every 10 frames.
  - Constant MTILE::UITOP to MTILE::UIBOT.
  - Cartridge mirroring to vertical.

### **Fixed**

- Typo for vblank labels (vblank_scroll and vblank_palette).
- In LevelPlay, wait for button timer before switching to LevelLoad.

### **Removed**

- txt_null and txt_pressplay.

-----------------

## **[0.0.5]** - _2021-10-03_

### **Added**

#### ASM

- New arrays in memory (attributes and palettes).
- Labels in the level memory page to access level palettes and other data.
- drawStates flags (for updating attributes, palettes and scroll).
- change_to_level_load subroutine.
- _Data:_
  - palettes table (only 6 palettes are unique for now).
- _Graphics_:
  - change_attribute subroutine to change the attribute of a metatile.
  - set_palette subroutine to change a palette.
- _Vector_:
  - Vblank can now change the nametable attributes and palettes using the
    attributes and the palettes array.

### **Changed**

- CHR laser sprites to use only 1 color, background text color and some object
  sprites (mirrors, emitters, receivers).

#### ASM

- bgDrawData size from 32 to 63 bytes.
- drawStates comment about flag description.
- Renamed load_palettes in load_palettes_ppu and reset_nametable_palette in reset_nametable_attributes.
- _Data:_
  - level 00 and 01 palettes.
- _Graphics_:
  - Update metatile attribute when changing its sprite.
- _Stage:_
  - Refactor in stages Menu, LevelWin, LevelLoose and LevelPlay action that change
    the stage to LevelLoad to use the change_to_level_load subroutine.
  - Enable scroll update in Menu.
  - Placing laser in LevelEdit when pressing A instead of LevelLoad.
  - Disable sprites when switching from LevelEdit to LevelPlay.
  - Disable palette update and activate background, sprites, attributes and
    scroll in LevelEdit.
  - Load level palettes and set attribute table in LevelLoad.
- _Vector_:
  - Load the first 8 palettes of the palette table during reset before
    resetting the nametable attributes.

### **Removed**

- Default palettes.

-----------------

## **[0.0.4]** - _2021-09-27_

### **Added**

- SPR enum for sprites.
- BTN_TIMER constant to set the number of frame to wait when a button is pressed.
- New variables (buttons1Timer, cursX, cursY and cursAnimTimer)
  and sprites addresses (sprCursUL, sprCursUR, sprCursDL, sprCursDR).
- _Data:_
  - txt_win and txt_loose.
  - 10 data bytes to levels (unused for now).
- _Game:_
  - New laser_action subroutines (receive_up, receive_down, receive_left, receive_right).
  - add_laser subroutines in game/laser/add.asm to add a new laser in the level.
  - update_btn_timer subroutine to update the number of frame remaining to press
    a button again.
  - move_cursor subroutine to move the cursor based on inputs.
  - place_at_cursor subroutine to place a different metatile where the cursor is.
  - level_place_lasers subroutine to place lasers on the level base on the
    location of emitters.
- _Graphics_:
  - New laser_draw subroutines (receive_up, receive_down, receive_left, receive_right).
  - update_cursor_sprite subroutine to update the cursor sprites.
- _Stage:_
  - Very basic win and loose stage that just reload the level when pressing
    start or select.
  - A cursor in level_edit stage.

### **Changed**

- Refactor subroutines names.
- STG constant type into an enum.
- Include new files.
- Main subroutine to include the new stages and call update_btn_timer at the end.
- _Game:_
  - Move all laser_action subroutines into game/laser/action.asm
  - Move all move_laser subroutines into game/laser/move.asm
  - load_level subroutine to load the 10 data bytes.
- _Stage:_
  - Play... stages names for Level..., change constants and files names accordingly.
  - level_load by letting the game place the lasers.
  - level_play that now check if every laser has stop and change the stage to win
    or loose if there are at least one receiver off. Also add laser behavior for
    off receiver.

### **Fixed**

- metaTile_EMIT_LEFT and metaTile_EMIT_RIGHT being inverted.
  Same for metaTile_RECEIVE_LEFT and metaTile_RECEIVE_RIGHT.

### **Removed**

- Level 00 test mirrors.
- level_load test lasers.

-----------------

## **[0.0.3]** - _2021-09-22_

### **Added**

#### Project

- Add stack segment in config.

#### ASM

- Macros for push and pull registers.
- Include new ASM files in lightPuzzle.asm.
- _Data:_
  - txt_pressplay (PRESS TO PLAY).
- _Game:_
  - game/laser.asm with subroutines to update lasers positions and states.
  - moveLaserMirror1 (\\ mirror) and moveLaserMirror2 (/ mirror) subroutines
    in laser.asm to update the direction of the laser based on the direction
    in which it came.
  - Multiple laserAction subroutines in laser.asm to move the laser depending
    on which type of metatile it collides with. *List of new laserAction subroutine:
    "laserhor, laserver, mirror_1, mirror_2, mirror_ul, mirror_ur, mirror_dl,
    mirror_dr, mirror_cross1, mirror_cross2"*
- _Graphics_:
  - resetNametablePalette subroutine to set the first default palette in
    nametable 1.
  - graphics/laser.asm with multiples laserDraw subroutines to update
    the metatile of where a laser is standing. *list of subroutine: "ground,
    crosshor, crossver, mirror2, mirror1, mirror_ul, mirror_ur, mirror_dl, mirror_dr"*

### **Changed**

#### Project

- Update background tiles graphic.
- Update Makefile.

#### ASM

- Metatile enum constant names
- Replace push and pull registers instructions with macros.
- Replace labels in subroutines with cheap labels.
- Rename laserArray_meta to laserArray_state.
- _Game:_
  - laserAction_move to match the new laserAction subroutine type behavoir.
- _Stage:_
  - The stage change from play to play_level now required to press a button.
  - play_load stage to add a new test laser and display txt_pressplay.
  - play_level stage for laser to react on more metatile
    and a way to return to the menu by pressing select or start.
- _Data:_
  - Default palette colors.
  - Metatiles array and data to match the new constants
    and remove duplicated metatiles data.
  - Level 01 to display 64 metatiles.
  - Level 00 by adding multiple mirrors to test lasers.

### **Fixed**

- Spelling mistake in CHANGELOG.
- Palette not being set on reset.

### **Removed**

- Useless CMP instructions.

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
  - Empty drawLevel subroutine.
  - drawMetaTile subroutine to draw a metatile at a given position.
  - drawMenu subroutine to draw the menu stage.
  - updateBgData subroutine to update background tiles during game with data in bgDrawData.
  - loadPalettes subroutine to load default palettes.
  - Empty updateSprite subroutine.
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
  - getMTileNametableAdr subroutine that gets the PPU address of a metatile.

-----------------
