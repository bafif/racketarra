#lang racket

(require 2htdp/image)
(require "include/CHORDS.rkt")

(require 2htdp/universe)

(define (window-draw x)
    (let ([fretboard (underlay/xy (guitar-img frets-list) 0 0
                                  (chords-img "Am" frets-list))])
        (let ([width (image-width fretboard)]
              [height (image-height fretboard)])
    (place-image fretboard (/ width 2) (/ height 2)
                 (empty-scene width height)))))

(define run
  (big-bang #t [to-draw window-draw]))

run
