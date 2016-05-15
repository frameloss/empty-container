; pause.asm
;
;       Just waits forever. Calls the pause syscall.
;
;       This is a convenient program for replacing /bin/sh
;       inside a docker container that shouldn't actually run
;       anything, for instance a pure storage container.
;
;       This results in a container of only a about one hundred bytes,
;       (before copying in the files to be shared in a volume,)
;       and will only consume a few KB of ram.
;
;       see /usr/include/asm/unistd_64.h for syscall definitions.
;
; Build with:
;       nasm -f elf64 pause.asm
;       ld -s -o pause pause.o && rm -f pause.o
;
; Then in the Dockerfile do something like ...
;       FROM scratch
;       COPY pause /bin/sh
;       COPY /files_to_be_shared/ shared/
;       VOLUME ['/shared']
;       USER 65535
;       CMD ['']

bits 64
global _start
section .text
  _start:
    mov    rax,34 ; pause()
    syscall

