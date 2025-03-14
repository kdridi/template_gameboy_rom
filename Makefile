RGBDS_PREFIX = tmp/rgbds-prefix

# Compilateur Assembleur
ASM = $(RGBDS_PREFIX)/bin/rgbasm
LINKER = $(RGBDS_PREFIX)/bin/rgblink
FIX = $(RGBDS_PREFIX)/bin/rgbfix

# Fichiers source
SRC = src/main.asm

# Fichiers objets
OBJ = $(SRC:.asm=.o)

# Nom du fichier ROM final
ROM = game.gb

# Règles
all: $(ROM)

%.o: %.asm
	$(ASM) -I src -o $@ $<

$(ROM): $(OBJ)
	$(LINKER) -o $@ $^
	$(FIX) -v $@

clean:
	rm -f $(OBJ) $(ROM) $(ROM)

.PHONY: all clean
