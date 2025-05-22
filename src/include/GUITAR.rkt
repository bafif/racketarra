#lang racket

(require 2htdp/image)
(require "BASE.rkt")
(require "CALC.rkt")

(provide fret-img frets-img frets-list NECK_COLOR guitar-img STRING_LITSEP FRET_SPACING iron-img)

; PARTS
;;;;;;;

(define NECK_LENGTH  (* GLOBAL_SCALE 500))
(define NECK_WIDTH (* GLOBAL_SCALE 60))
(define NECK_COLOR  (make-color 40 40 0))

(define neck-img (rectangle NECK_LENGTH NECK_WIDTH "solid" NECK_COLOR))

(define FRET_WIDTH  (* GLOBAL_SCALE 2))
(define FRET_LENGTH (* NECK_WIDTH 31/30))
(define FRET_COLOR  (make-color 150 150 50))

(define iron-img (rectangle FRET_WIDTH FRET_LENGTH "solid" FRET_COLOR))

(define FRET_SPACING  (* GLOBAL_SCALE 20))

(define (fret-img COLOR) (beside/align "middle"
                                       (rectangle (- FRET_SPACING FRET_WIDTH)
                                                  NECK_WIDTH
                                                  "solid"
                                                  COLOR)
                                       iron-img))

(define frets-list (build-list 25 (lambda (i) (fret-gen i NECK_COLOR))))

(define STRING_LENGTH NECK_LENGTH)
(define STRING_WIDTH (* GLOBAL_SCALE 2))
(define STRING_COLOR (make-color 180 180 180))
(define STRING_BIGSEP (/ FRET_LENGTH 12))
(define STRING_LITSEP (/ NECK_WIDTH 6))

(define string-img (rectangle STRING_LENGTH STRING_WIDTH "solid" STRING_COLOR))

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
              0 (/ (- FRET_LENGTH NECK_WIDTH) 2)
              neck-img
              ))
