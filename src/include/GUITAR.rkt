#lang racket

(require 2htdp/image)
(require "BASE.rkt")
(require "CALC.rkt")

;(provide NECK_WIDTH NECK_HEIGHT NECK_COLOR)
;(provide neck)

;(provide IRON_WIDTH IRON_HEIGHT IRON_COLOR)
;(provide iron)

;(provide FRET_WIDTH)
;(provide fret)

(provide fret-img frets-img frets-list NECK_COLOR guitar-img STRING_LITSEP FRET_WIDTH iron-img)

; PARTS
;;;;;;;

(define NECK_WIDTH  (* GLOBAL_SCALE 500))   ; Largo del mástil
(define NECK_HEIGHT (* GLOBAL_SCALE 60))    ; Ancho del mástil
(define NECK_COLOR  (make-color 40 40 0))   ; Color del mástil

(define neck-img (rectangle NECK_WIDTH NECK_HEIGHT "solid" NECK_COLOR))

(define IRON_WIDTH  (* GLOBAL_SCALE 2))         ; Largo del hierro
(define IRON_HEIGHT (* NECK_HEIGHT 31/30))        ; Ancho del hierro
(define IRON_COLOR  (make-color 150 150 50))    ; Color del hierro

(define iron-img (rectangle IRON_WIDTH IRON_HEIGHT "solid" IRON_COLOR))

(define FRET_WIDTH  (* GLOBAL_SCALE 20))         ; Largo del traste

(define (fret-img COLOR) (beside/align "middle"
                                       (rectangle (- FRET_WIDTH IRON_WIDTH)
                                                  NECK_HEIGHT
                                                  "solid"
                                                  COLOR)
                                       iron-img))

(define frets-list (build-list 25 (λ (i) (fret-gen i NECK_COLOR))))

(define STRING_WIDTH NECK_WIDTH)  ; Largo de la cuerda
(define STRING_HEIGHT (* GLOBAL_SCALE 2))  ; Largo de la cuerda
(define STRING_COLOR (make-color 180 180 180))  ; Largo de la cuerda
(define STRING_BIGSEP (/ IRON_HEIGHT 12))
(define STRING_LITSEP (/ NECK_HEIGHT 6))

(define string-img (rectangle STRING_WIDTH STRING_HEIGHT "solid" STRING_COLOR))

; GUITAR

(define (frets-img lst)
  (cond
    [(empty? lst) iron-img]
    [else (beside (fret-img (struct-copy color (fret-COLOR (first lst)) [alpha 0]))
                  (frets-img (rest lst)))]))

(define strings-img
  (underlay/xy string-img 0 STRING_LITSEP
               (underlay/xy string-img 0 STRING_LITSEP
                            (underlay/xy string-img 0 STRING_LITSEP
                                         (underlay/xy string-img 0 STRING_LITSEP
                                                      (underlay/xy string-img 0 STRING_LITSEP
                                                                   string-img
                                                                   ))))))

(define (guitar-img lst)
  (overlay/xy (underlay/xy (frets-img lst) 0
                           STRING_BIGSEP strings-img)
              0 (/ (- IRON_HEIGHT NECK_HEIGHT) 2)
              neck-img
              ))