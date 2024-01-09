.model large
.code
org 100h

start:
    jmp mulai

kurs0   db 13,10,"Konversi mata uang asing ke Rupiah",13,10,
        db "Kurs Rupiah terhadap Dollar adalah Rp. 13.000 per 1 Dollar",13,10,
        db "Kurs Rupiah terhadap Euro adalah Rp. 11.000 per 1 Euro",13,10,'$'
kurs1   db 13,10,"1. Konversi Mata Uang Dollar ke Rupiah",13,10,'$'
kurs2   db "2. Konversi Mata Uang Euro ke Rupiah",13,10,'$'
kurs3   db "3. Keluar",13,10,'$'
kurs5   db "Silahkan masukkan pilihan anda : $"

kurs6   db 13,10,13,10,"masukkan nilai kurs Dollar:$"
kurs7   db 13,10,13,10,"masukkan nilai kurs Euro:$"
kurs8   db "Nilai kurs dalam rupiah: $"
kurs12  db ".000 $"
kurs9   db 13,10,13,10,"terima kasih telah menggunakan program ini..."
kurs10  db " $"
kurs11  db 13,10,"Kembali ke Menu awal $"
dol     dw ?
eu      dw ?
rup     dw ?

mulai:
    mov ah, 09h
    lea dx, kurs0
    int 21h

    mov ah, 09h
    lea dx, kurs1
    int 21h

    mov ah, 09h
    lea dx, kurs2
    int 21h

    mov ah, 09h
    lea dx, kurs3
    int 21h

    mov ah, 09h
    lea dx, kurs5
    int 21h

    mov ah, 01h
    int 21h
    mov bl, al

    cmp bl, '1'
    je  dollar
    cmp bl, '2'
    je  euro
    cmp bl, '3'
   
    jmp ulang

dollar:
    mov ah, 09h
    lea dx, kurs6
    int 21h

    call scan_num
    mov dol, cx

    mov ah, 09h
    lea dx, kurs8
    int 21h

    mov ax, dol
    mov bx, 13000
    imul bx

    mov rup, ax

    call print_num

    mov ah, 09h
    lea dx, kurs12
    int 21h

    mov ah, 09h
    lea dx, kurs9
    int 21h

    jmp ulang

euro:
    mov ah, 09h
    lea dx, kurs7
    int 21h

    call scan_num
    mov eu, cx

    mov ah, 09h
    lea dx, kurs8
    int 21h

    mov ax, eu
    mov bx, 11000
    imul bx

    mov rup, ax

    call print_num

    mov ah, 09h
    lea dx, kurs12
    int 21h

    mov ah, 09h
    lea dx, kurs9
    int 21h

    jmp ulang



define_scan_num:
    ; Definisi prosedur scan_num
    ; Meminta input angka dari pengguna dan menyimpannya di register CX
    mov cx, 0
    mov ah, 01h
    int 21h
    sub al, 30h
    mov cx, ax
    ret

define_print_num:
    ; Definisi prosedur print_num
    ; Menampilkan angka dari register AX
    mov ax, cx
    mov bx, 10
    div bx
    cmp ax, 0
    je  skip
    push ax
    call define_print_num
    pop ax
skip:
    add ah, 30h
    mov dl, ah
    mov ah, 02h
    int 21h
    ret

define_print_num_uns:
    ; Definisi prosedur print_num_uns
    ; Menampilkan angka dari register AX (unsigned)
    mov ax, cx
    mov bx, 10
    div bx
    cmp ax, 0
    je  skip
    push ax
    call define_print_num_uns
    pop ax
skip2:
    add ah, 30h
    mov dl, ah
    mov ah, 02h
    int 21h
    ret
