import sys

LV_WIDTH = 16
LV_HEIGHT = 15
NB_OBJ = 8

LV_POS = (3, 0)  # row, col
OBJ_POS = (1, 18)  # row, col
PAL_POS = (2, 19)  # row, col

SPE_ARRAY = 0xFF

TILES = [
    "", "▒", ".", "", "▧", "", "", "", "💀", "", "", "", "", "", "", "",
    "", "", "", "", "↥", "↧", "↤", "↦", "﹀", "︿", "❭", "❬", "", "", "", "",
    "╱", "╲", "", "", "", "", "", "", "◢", "◣", "◥", "◤", "", "", "", "",
    "◫", "⑄", "", "", "⇿", "↕", "", "", "⇄", "⇅", "", "", "", "", "", ""
]


def find_next_rle_size(lv):
    v = lv[0]
    size = 0
    while size < len(lv) and lv[size] == v:
        size += 1
    return size


inputfile = "lv.csv"
outputfile = "lv.asm"

if len(sys.argv) > 1:
    inputfile = sys.argv[1]
if len(sys.argv) > 2:
    outputfile = sys.argv[2]


lv_asm = "; Generated level\n\n"
lv = []
lv_rle = []

print("read file...")
with open(inputfile, "r", encoding='utf-8') as f:
    lv_csv = f.readlines()

print("read level...")
for r in lv_csv[LV_POS[0]:LV_POS[0]+LV_HEIGHT]:
    cells = r.replace("\n", "").split(",")[LV_POS[1]:LV_POS[1]+LV_WIDTH]
    print(cells)
    for c in cells:
        if c in TILES:
            lv.append(TILES.index(c))
        else:
            lv.append(0)

print("compress level...")
while (len(lv) > 0):
    size = find_next_rle_size(lv)
    if size > 3:
        lv_rle.append(0xFF)
        lv_rle.append(size-1)
        lv_rle.append(lv[0])
        lv = lv[size:]
    else:
        lv_rle.append(lv.pop(0))
lv_asm += "; level grid\n.byte "
for c in lv_rle:
    lv_asm += str(c) + ","
lv_asm = lv_asm[0:-1]

print("read objects...")
obj_count = lv_csv[OBJ_POS[0]].replace("\n", "").split(",")[
    OBJ_POS[1]:OBJ_POS[1]+NB_OBJ]
print(obj_count)
lv_asm += "\n; level objects\n.byte"
for i in range(0, len(obj_count), 2):
    lv_asm += " $"
    lv_asm += hex(int(obj_count[i+1]))[2:]
    lv_asm += hex(int(obj_count[i+0]))[2:]
    lv_asm += ","
lv_asm += " $00, $00, $00, $00\n"

pal_0 = lv_csv[PAL_POS[0]].replace("\n", "").split(",")[PAL_POS[1]]
pal_1 = lv_csv[PAL_POS[0]].replace("\n", "").split(",")[PAL_POS[1]+1]
lv_asm += "; palettes\n.byte " + str(pal_0) + "," + str(pal_1)

print("write file...")
with open(outputfile, "w") as f:
    f.write(lv_asm)

print("done.")
