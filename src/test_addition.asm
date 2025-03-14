SECTION "Test Addition", ROM0

test_addition:
    ld a, 3          ; Charger la valeur 3 dans le registre A
    ld b, 4          ; Charger la valeur 4 dans le registre B
    call add_numbers ; Appeler la fonction d'addition
    cp 7             ; Comparer le résultat avec 7
    jp nz, test_failed ; Sauter à test_failed si ce n'est pas égal
    jp test_passed   ; Sauter à test_passed si égal

test_passed:
    ; Code pour indiquer que le test a réussi
    ret

test_failed:
    ; Code pour indiquer que le test a échoué
    ret
