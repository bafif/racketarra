#lang racket

(require 2htdp/image)

(provide GLOBAL_SCALE)

(provide fret fret-NUM fret-NOTA1 fret-NOTA2 fret-NOTA3
         fret-NOTA4 fret-NOTA5 fret-NOTA6 fret-COLOR)


; GRAPHIC ENVIRONMENT
;;;;;;;;;;;;;;;;;;;;;

(define GLOBAL_SCALE 3/2)

; COMMON STRUCTURES
;;;;;;;;;;;;;;;;;;;;;

(struct fret [NUM NOTA1 NOTA2 NOTA3 NOTA4 NOTA5 NOTA6 COLOR]) ; Obsolete
