# Compilateur Assembleur
ASM = rgbasm
LINKER = rgblink
FIX = rgbfix

# Fichiers source
SRC = main.asm add_numbers.asm test_addition.asm

# Fichiers objets
OBJ = $(SRC:.asm=.o)

# Nom du fichier ROM final
ROM = game.gb

# Règles
all: $(ROM)

%.o: %.asm
	$(ASM) -o $@ $<

$(ROM): $(OBJ)
	$(LINKER) -o $@.raw $^
	$(FIX) -v $@.raw

clean:
	rm -f $(OBJ) $(ROM).raw $(ROM)

.PHONY: all clean
