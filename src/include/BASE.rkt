#lang racket

(provide GLOBAL_SCALE)

(provide fret fret-NUM fret-NOTA fret-COLOR)


; GRAPHIC ENVIRONMENT
;;;;;;;;;;;;;;;;;;;;;

; Value by which the rest of the graphical interface is scaled.
(define GLOBAL_SCALE 3/2)

; COMMON STRUCTURES
;;;;;;;;;;;;;;;;;;;;;

; Structure that represents the divisions of the string into notes.
(struct fret [NUM NOTA COLOR])