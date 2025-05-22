#lang racket

(require 2htdp/image)
(require "BASE.rkt")
(require "CALC.rkt")
(require "GUITAR.rkt")
(provide guitar-img frets-list chords-img)

(define NOTE_SIZE (* GLOBAL_SCALE 5))

(define (note-img color) (circle NOTE_SIZE "solid" color))

(define (note-color n)
  (cond
    [(= n 0) (color 0 0 0 0)]
    [(= n 1) (color 150 10 90)]
    [(= n 2) (color 200 200 0)]
    [(= n 3) (color 0 90 0)]))

(define (fret-chord-layer lst)
  (underlay/xy    (note-img (note-color (first lst))) 0 STRING_LITSEP
                  (underlay/xy (note-img (note-color (second lst))) 0 STRING_LITSEP
                               (underlay/xy (note-img (note-color (third lst))) 0 STRING_LITSEP
                                            (underlay/xy (note-img (note-color (fourth lst))) 0 STRING_LITSEP
                                                         (underlay/xy (note-img (note-color (fifth lst))) 0 STRING_LITSEP
                                                                      (note-img (note-color (sixth lst)))))))))


(define (chords-img chord lst)
  (cond
    [(empty? lst) iron-img]
    [else (underlay/xy (fret-chord-layer (fretin-chord (fret-notes (first lst))
                                                       (chord-calc chord)))
                       FRET_SPACING 0 (chords-img chord (rest lst)))]))
