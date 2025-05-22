#lang racket

(require "BASE.rkt")
(provide fret-gen string->note chord-calc fretin-chord fret-notes)

(define (fret-gen n color)
  (fret n n (+ n 5) (+ n 10) (+ n 15) (+ n 19) (+ n 24) color))

(define (string->note ch)
  (cond
    [(= (string-length ch) 1)
     (cond
       [(char=? (string-ref ch 0) #\E) 0]
       [(char=? (string-ref ch 0) #\F) 1]
       [(char=? (string-ref ch 0) #\G) 3]
       [(char=? (string-ref ch 0) #\A) 5]
       [(char=? (string-ref ch 0) #\B) 7]
       [(char=? (string-ref ch 0) #\C) 8]
       [(char=? (string-ref ch 0) #\D) 10])]
    [(= (string-length ch) 2)
     (cond
       [(char=? (string-ref ch 1) #\b)
        (string->note (- (string-ref ch 0) 1))]
       [(char=? (string-ref ch 1) #\#)
        (string->note (+ (string-ref ch 0) 1))])]))

(define (chord-calc chord)
  (cond
    [(= (string-length chord) 1)
     (list (string->note chord)
           (modulo (+ (string->note chord) 4) 12)
           (modulo (+ (string->note chord) 7) 12))]
    [(= (string-length chord) 2)
     (cond
       [(or    (char=? (string-ref chord 1) #\#)
               (char=? (string-ref chord 1) #\b))
        (list (string->note chord)
              (modulo (+ (string->note chord) 4) 12)
              (modulo (+ (string->note chord) 7) 12))]
       [(char=? (string-ref chord 1) #\m)
        (list (string->note (substring chord 0 1))
              (modulo (+ (string->note (substring chord 0 1)) 3) 12)
              (modulo (+ (string->note (substring chord 0 1)) 7) 12))])]
    [(= (string-length chord) 3)
     (cond
       [(char=? (string-ref chord 2) #\m)
        (list (string->note (substring chord 0 2))
              (modulo (+ (string->note (substring chord 0 2)) 3) 12)
              (modulo (+ (string->note (substring chord 0 2)) 7) 12))])]))

(define (fret-notes fret)
  (list   (modulo (fret-NOTA1 fret) 12) (modulo (fret-NOTA2 fret) 12)
          (modulo (fret-NOTA3 fret) 12) (modulo (fret-NOTA4 fret) 12)
          (modulo (fret-NOTA5 fret) 12) (modulo (fret-NOTA6 fret) 12)))

(define (notein-chord nota chord)
  (cond
    [(= nota (first chord))  1]
    [(= nota (second chord)) 2]
    [(= nota (third chord))  3]
    [else 0]))

(define (fretin-chord notas chord)
  (cond
    [(empty? notas) (list)]
    [else (append (list (notein-chord (first notas) chord))
                  (fretin-chord (rest notas) chord))]))
