#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(require "include/CHORDS.rkt")

; Represento con la escena main-scn una escena principal
;sobre la cual va a dibujarse el resto del programa.
(define (main-scn x)
  (let ([fretboard (underlay/xy (guitar-img frets-list) 0 0
                                (chords-img frets-list))])
    (let ([width (image-width fretboard)]
          [height (image-height fretboard)])
      (place-image fretboard (/ width 2) (/ height 2)
                   (empty-scene width height)))))

(define run
  (big-bang #t [to-draw window-draw]))

run