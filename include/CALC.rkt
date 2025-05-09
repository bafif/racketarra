#lang racket

(require "BASE.rkt")
(provide fret-gen char->note chord-calc fretin-chord fret-notas)

(define (fret-gen n color)
  (fret n n (+ n 5) (+ n 10) (+ n 15) (+ n 19) (+ n 24) color))

(define (char->note ch)
  (if (char? ch)
      (cond
        [(char=? ch #\E) 0]
        [(char=? ch #\F) 1]
        [(char=? ch #\G) 3]
        [(char=? ch #\A) 5]
        [(char=? ch #\B) 7]
        [(char=? ch #\C) 8]
        [(char=? ch #\D) 10])
      (cond
        [(char=? (string-ref ch 1) #\b)
         (char->note (- (string-ref ch 0) 1))]
        [(char=? (string-ref ch 1) #\#)
         (char->note (+ (string-ref ch 0) 1))]
        [(char=? (string-ref ch 1) #\m)
         (char->note (string-ref ch 0))]
        ))
  )

(define (chord-calc chord)
  (if (char? chord)
      (list (char->note chord)
            (modulo (+ (char->note chord) 4) 12)
            (modulo (+ (char->note chord) 7) 12))
      (cond
        [(= (string-length chord) 2)
         (cond
           [(or    (char=? (string-ref chord 1) #\#)
                   (char=? (string-ref chord 1) #\b)
                   )
            (list (char->note chord)
                  (modulo (+ (char->note chord) 4) 12)
                  (modulo (+ (char->note chord) 7) 12)
                  )]
           [(char=? (string-ref chord 1) #\m)
            (list (char->note (string-ref chord 0))
                  (modulo (+ (char->note chord) 3) 12)
                  (modulo (+ (char->note chord) 7) 12)
                  )]
           )]
        [(= (string-length chord) 3)
         (cond
           [(or    (char=? (string-ref chord 1) #\#)
                   (char=? (string-ref chord 1) #\b)
                   )
            (list (char->note chord)
                  (modulo (+ (char->note chord) 4) 12)
                  (modulo (+ (char->note chord) 7) 12))]
           [(char=? (string-ref chord 2) #\m)
            (list (char->note (substring chord 0 1))
                  (modulo (+ (char->note (substring chord 0 1)) 3) 12)
                  (modulo (+ (char->note (substring chord 0 1)) 7) 12)
                  )])])))

(define (fret-notas fret)
  (list   (modulo (fret-NOTA1 fret) 12) (modulo (fret-NOTA2 fret) 12)
          (modulo (fret-NOTA3 fret) 12) (modulo (fret-NOTA4 fret) 12)
          (modulo (fret-NOTA5 fret) 12) (modulo (fret-NOTA6 fret) 12) ))

(define (notein-chord nota chord)
  (cond
    [(= nota (first chord)) 1]
    [(= nota (second chord)) 2]
    [(= nota (third chord)) 3]
    [else 0]))

(define (fretin-chord notas chord)
  (cond
    [(empty? notas) (list)]
    [else (append (list (notein-chord (first notas) chord))
                  (fretin-chord (rest notas) chord))]))
