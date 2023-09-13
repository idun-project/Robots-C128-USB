ACME=/usr/bin/acme

BIN=graphics-128\
sprites-128\
faces-128\
intro-128\
loader-128\
boot-128\
game0-128\
game1-128\
common-128\
bootsect.bin

INC=const.inc\
macro.inc

all: $(INC) $(BIN)

common-128: faces-128 game0-128 game1-128 common.asm
	$(ACME) common.asm

game1-128: game0-128 background_tasks.asm
	$(ACME) game1.asm

game0-128: graphics-128 game0.asm
	$(ACME) game0.asm

graphics-128: graphics.asm
	$(ACME) graphics.asm

sprites-128: sprites.asm
	$(ACME) sprites.asm

faces-128: faces.asm
	$(ACME) faces.asm

boot-128: loader-128 boot.asm
	$(ACME) boot.asm

loader-128: intro-128 loader.asm
	$(ACME) loader.asm

intro-128: intro.asm
	$(ACME) intro.asm

bootsect.bin: bootsect.asm
	$(ACME) bootsect.asm
	
image:
	cc1541 -n 128-robots -i 2a -w boot-128 -w loader-128 -w intro-128 -w common-128 \
	-w faces-128 -w game0-128 -w graphics-128 -w music-128 -w game1-128 -w tileset-128 \
	-w sprites-128 -w level-a-128 -w level-b-128 -w level-c-128 -w level-d-128 \
	-w level-e-128 -w level-f-128 -w level-g-128 -w level-h-128 -w level-i-128 \
	-w level-j-128 -w level-k-128 -w level-l-128 -w level-m-128 -w level-n-128 \
	-w level-o-128 128-Robots.d71
test:
	x128 -pal -40col -idunhost localhost:25232 -idunio 128-Robots.d71
clean:
	rm $(BIN)
	rm *.sym
	rm 128-Robots.d71