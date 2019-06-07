; haribote-os
; TAB=4

    org 0xc200

    mov al, 0x13 ; VGAグラフィックス 320x320x8bitカラー
    mov ah, 0x00
    int 0x10

fin:
    hlt
    jmp fin
