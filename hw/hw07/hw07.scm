(define (cddr s) (cdr (cdr s)))

; return the second elements of a list
(define (cadr s) (car (cdr s)))

; return the third elements of a list
(define (caddr s) (car (cddr s)))

; return the sign of a number
(define (sign num)
  (cond 
    ((< num 0) -1)
    ((= num 0) 0)
    (else      1)))

(define (square x) (* x x))

; calculate pow(x, y)
(define (pow x y)
  ; base case: y = 1, just return x
  (if (= y 1)
      x
      ; recursive call
      (if (even? y)
          (square (pow x (quotient y 2)))
          (* x (square (pow x (quotient y 2)))))))

; remove duplicates in s
(define (unique s)
  ; base case: s is nil
  (if (null? s)
      nil
      ; recursive call
      (cons (car s)
            ; remove (car s) in (cdr s), then call unique on the result
            (unique (filter
                     (lambda (x) (not (eq? x (car s)))) ; lambda expression
                     (cdr s))))))

; return a list contains n(number) x
(define (replicate x n)
  (define (replicate-iter x n lst)
    (if (= n 0)
        lst
        (replicate-iter x (- n 1) (cons x lst))))
  (replicate-iter x n nil))

; combines the first n natural numbers according to the following parameters:
; 1. combiner: a function of two arguments
; 2. start: a number with which to start combining
; 3. n: the number of natural numbers to combine
; 4. term: a function of one argument that computes the nth term of a sequence
(define (accumulate combiner start n term)
  (if (= n 0)
      start
      ; combine term(n) and accumulate(n - 1)
      (combiner (term n)
                (accumulate combiner start (- n 1) term))))

; tail recursion
(define (accumulate-tail combiner start n term)
  (define (accumulate-iter combiner num term result)
    ; base case: num > n
    (if (> num n)
        result
        ; recursive case: combine result and start to get a new result
        (accumulate-iter combiner
                         (+ num 1)
                         term
                         (combiner result (term num)))))
  (accumulate-iter combiner 1 term start))

(define-macro
 (list-of map-expr for var in lst if filter-expr)
 'YOUR-CODE-HERE)
