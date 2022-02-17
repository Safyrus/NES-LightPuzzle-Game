# CHANGELOG

The format of this CHANGELOG is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

This project try to follow the [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

-----------------

## **[0.2.1]** - _2022-02-17_

### **Added**

#### ASM

- _Data:_
  - tile_icon_table.
- _Game:_
  - "find_item_selectable_index" subroutine to find the index of a tile
    in the level_selectable_object_type array.
  - "clear_level_edit" function to clear tiles placed by the player.
  - level_edit_load function to update the number of items
    by accounting for already placed ones.
- _Graphics:_
  - "draw_level_edit" function to draw tiles that have been placed by the player.
- _Other:_
  - Constant TILE_TABLE_SIZE.

### **Changed**

#### ASM

- _Data:_
  - txt_version to "V0.2.1".
- _Game:_
  - some functions to call clear_level_edit (change_to_menu_load, stage_level_win).
  - load_level function to not removed placed items.
  - stage_level_load function to draw the level after it has been loaded
    and to draw already placed tiles.
- _Graphics:_
  - draw_ui function to make the UI only show item that are used in the level.
- _Other:_
  - APU constants name.

### **Fixed**

- Changelog of version 2.0.0.

### **Removed**

- strings txt_ui_1, txt_ui_2 and txt_ui_3.

-----------------

## **[0.2.0]** - _2022-01-26_

### **Added**

- Game name and "Safyrus Games" logo in CHR.

#### ASM

- _Data:_
  - New metatiles (TITLE_NAME 1 to 5, TITLE_EFFECT 1 to 5, TITLE_LASER,
    TITLE_LASER_DIAGONAL 1 and 2, TITLE_SAPHYR, TITLE_SAFYRUS_GAMES 1 and 2).
  - New title level (not a real level).
  - 3 new levels.
  - select_tiles_index_table to map a tile in tile_table to a tile in select_tiles.
- _Other:_
  - New metatiles constants.

### **Changed**

- Game name from "lightPuzzle" to "Reflection".
- The default Mario font for a custom one in CHR.

#### ASM

- _Data:_
  - txt_version to "V0.2.0".
  - palette 1.
  - Move tile_table and newtile_table to global.
- _Game:_
  - Remove objects in LevelPlay can now be done in any orientation.
- _Graphics:_
  - "draw_menu" function by drawing the title level.
  - Texts position in the menu.
  - UI and UI sprites, in LevelPlay, is hided when cursor is on top.
- Stage:_
  - Menu stage background palette.

### **Fixed**

- Emitter and receiver objects not changing orientation.

### **Removed**

- txt_menu and txt_game_title.

-----------------

## **[0.1.5]** - _2022-01-12_

### **Added**

- SKULL graphic in CHR.

#### ASM

- _Data:_
  - 5 levels.

### **Changed**

#### ASM

- _Data:_
  - txt_version to "V0.1.5".
  - CROSS metatiles tiles.
  - palette 6 and 7.
- Stage:_
  - In LevelPlay, condition for winning or loosing are now check every tick.
- _Other:_
  - LEVEL_MAX to 20.
  - Refactor CROSS metatiles, functions and file names to SKULL.

-----------------

## **[0.1.4]** - _2021-12-26_

### **Added**

#### ASM

- Stage:_
  - In menu, new options start and resume.
    Start load the first level.
    Resume (available when start had been selected at least one time)
    load the selected level.
- _Data:_
  - new texts (start, resume, selectlevel).
- _Other:_
  - new variable "game_flags" to save some states of the game.
  - "laser_pos_to_vram_adr" to transform a laser position into a VRAM address.

### **Changed**

- The gitignore.

#### ASM

- Split laser actions and graphics into multiple files.
- Refactor "big if else block" codes to "switch table" to take less space and time.
- _Game:_
  - Refactor move_laser_mirror functions to take less space and time.
  - Refactor add_laser functions to take less space.
- Stage:_
  - In level_win, load the next level when pressing START or SELECT.
    Return to menu if it is the last level.
  - In menu, refactor code layout.
- _Data:_
  - txt_version to "V0.1.4".
- _Graphics:_
  - draw_menu to draw a text for each option.
  - Colors of the menu stage from gray to green.
  - Refactor laser graphic functions to take less space.
- _Other:_
  - draw_states flags in change_to_menu_load.

### **Removed**

- txt_level.
- WIN stage constant.
- Useless push and pull in IRQ vector.

-----------------

## **[0.1.3]** - _2021-12-22_

### **Added**

- Multiple buttons tiles and one sprite for the selected UI item in the CHR file.

#### ASM

- _Data:_
  - new texts (goal, btn_move_1, btn_move_2, btn_move_3, btn_start, btn_a_1,
    btn_a_2, btn_b, btn_select).
  - 2 new levels to explain controls.
- _Graphics:_
  - Specific text is display depending on the level loaded in draw_level function.
    (currently only use for level 0, 1 and 5).
  - "draw_text_level_0", "draw_text_level_1" and "draw_text_level_5" functions
    to draw text for a specific level.
  - "update_sprite_item_selected" function to update sprites of the selected item.
- _Other:_
  - SPR constants (SELECTED, BTN_A, BTN_B, BTN_START, BTN_SELECT,
    BTN_UP, BTN_DOWN, BTN_LEFT, BTN_RIGHT).
  - "stage_state" variable.
  - 3 sprite variables (spr_selected_left, spr_selected_middle, spr_selected_right).
  - "find_item_index" function to find the index of an item type
    in select_tiles array.

### **Changed**

- Move glass sprite position in the CHR file.

#### ASM

- _Data:_
  - metatile_GLASS to fit the new glass tile position.
  - txt_version to "V0.1.3".
  - MIRRORC_UL to MIRRORC_DR in select_tiles array.
  - level 1 (used to be 0).
- _Graphics:_
  - update_ui_count to use find_item_index.
- _Stage:_
  - level_load stage to set stage_state to a non-zero value.
  - level_edit to update palettes only when stage_state is not zero
    and set it to zero afterward. Also call update_sprite_item_selected
    when select is pressed.
- _Other:_
  - Normalized function and variable names
  - LEVEL_MAX to 15.

### **Fixed**

- Graphical glitch when loading a level caused by the vblank writing data
  to the PPU when it should not.
- Items number not being correct when loading a level.

-----------------

## **[0.1.2]** - _2021-12-18_

### **Added**

- Glass tile in CHR ROM.

#### ASM

- _Game:_
  - Laser behavior for doors, glasses and cross.
  - Doors can now be place and rotate.
  - "move_laser_restart" function to make lasers (with the restart flag)
    move again at a certain position.
  - "laser_action_stop_restart" function to activate the S and R flag of the laser.
- _Graphics:_
  - functions to draw doors and crosses.
- _Data:_
  - 6 new levels (1 to test the door, another to test the cross).
  - CROSS metatiles.
- _Other:_
  - Comments for variables.
  - CROSS mtile constants.

### **Changed**

- Icon tiles position in CHR ROM.

#### ASM

- _Data:_
  - UI string icon because of the tiles position modification.
  - select_tiles to have the DOOR_H metatiles.
- _Vectors_:
  - Vblank scroll update to work without ppu_ctrl.
- _Other:_
  - Metatile names (LOCK to GLASS, DOORL_H to DOOR_H_ON, DOORL_V to DOOR_V_ON).
  - LEVEL_MAX to 13 and LASER_MAX to 48.

### **Fixed**

- Missing push and pop.

### **Removed**

- Timer wall icon and metatiles in CHR ROM.
- Metatiles TIMEWALL_OFF and TIMEWALL_ON.
- Variables (level_AntiLaserCount, laserAntiArray_pos, laserAntiArray_state, ppu_ctrl).
- Useless push and pop in laser action functions.

-----------------

## **[0.1.1]** - _2021-12-11_

### **Added**

#### ASM

- _Data:_
  - 3 new simple levels to test the corner mirror, splitter and merger.
  - Metatiles splitter ON, merger ON and merger semi ON.
- _Graphics:_
  - "laser_draw_activate" to change the palette to the active one at a laser position.
- _Game:_
  - Laser behavior for corner mirrors in all 4 direction.
  - Laser behavior for splitters and mergers.
  - Corner mirrors, splitters and mergers can now be place and rotate.
- _Other:_
  - Constant MAXLASERPERFRAME with a value of 3.
  - A variable level_LaserDoneCounter.

### **Changed**

- Some icon tiles in CHR ROM.

#### ASM

- _Data:_
  - Palettes 3 to 5.
  - Default placeable tiles.
  - Debug level to test the game behavior with a lot of lasers.
  - Update UI string.
- _Stage:_
  - Inputs in LevelPlay to reset only when SELECT is pressed.
  - Refactor laser loop in LevelPlay.
  - LevelPlay laser loop do update a maximum of MAXLASERPERFRAME per frame.
  - "level_place_lasers" function to reset "level_LaserDoneCounter" to 0.
- _Other:_
  - Constants LEVEL_MAX to 7 and LASER_MAX to 32.

### **Fixed**

- Level glitching when too many lasers needed to be updated.

### **Removed**

- Useless levelMeta.asm file.
- Metatiles of MIRRORC_ON type.
- Useless push and pop.

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
