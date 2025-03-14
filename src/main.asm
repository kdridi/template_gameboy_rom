INCLUDE "add_numbers.asm"
INCLUDE "test_addition.asm"

SECTION "Main", ROM0[$150]

Main:
    call test_addition
    jp Main ; Boucle infinie pour garder l'émulateur actif
