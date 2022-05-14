(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Helper function: takes in an element FIRST and a list of lists RESTS,
; adds first to the beginning of each list in RESTS
(define (cons-all first rests)
  (map
    (lambda (x) (append (list first) x)) ; an one-argument function
    rests)) ; a list

; Turn ((a 1) (b 2) (c 3)) into ((a b c) (1 2 3))
(define (zip pairs)
  (define (zip_helper pairs firsts seconds)
    (if (null? pairs)
      ; base case: pairs is nil
      (list firsts seconds) ; no more elements to add
      ; recursive case: process one pair each time
      (zip_helper
        (cdr pairs)
        (append firsts (list (car (car pairs)))) ; append pair.first into firsts
        (append seconds (list (car (cdr (car pairs)))))))) ; append pair.rest.first into seconds
  (zip_helper pairs nil nil))

;; Problem 16
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 16
  ; Define a helper to record the index
  (define (enum_helper s i)
    ; base case: s is nil
    (if (eq? s nil)
      nil
      (cons (cons i (cons (car s) nil))
            (enum_helper (cdr s) (+ i 1)))))
  (enum_helper s 0))
; END PROBLEM 16

;; Problem 17
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 17
  ; base case: total == 0
  (if (= total 0)
    (list nil)  ; return an empty list
    (if (null? denoms)
      nil ; base case: no denoms to use
      (if (>= total (car denoms)) ; tree recursion
        ; total >= (car denoms) => we can use (car denoms)
        (append
          (cons-all (car denoms) (list-change (- total (car denoms)) denoms)) ; use (car denoms)
          (list-change total (cdr denoms)))           ; do not use (car denoms)
        ; total < (car denoms) => we can't use it
        (list-change total (cdr denoms))))))
; END PROBLEM 17

;; Problem 18
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda

; > (let-to-lambda 1)
; 1

; > (let-to-lambda '(+ 1 2))
; (+ 1 2)

; > (let-to-lambda '(let ((a 1) (b 2)) (+ a b)))
; ((lambda (a b) (+ a b)) 1 2)

(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 18
         ; return the value directly
         expr
         ; END PROBLEM 18
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 18
         ; return the quote expression directly.
         expr
         ; END PROBLEM 18
         )
        ((or (lambda? expr) (define? expr))
         ; example: (define x 1)
         (let ((form   (car expr))  ; define
               (params (cadr expr)) ; x
               (body   (cddr expr))) ; (1)
           ; BEGIN PROBLEM 18
           ; apply let-to-lambda to each element in body
           (cons form (cons params (map let-to-lambda body)))
           ; END PROBLEM 18
           ))
        ((let? expr)
         ; example: (let ((a 1) (b 2)) (+ a b))
         (let ((values (cadr expr)) ; ((a 1) (b 2))
               (body   (cddr expr))); ((+ a b))
           ; BEGIN PROBLEM 18
           ; use zip to turn ((a 1) (b 2)) into ((a b) (1 2))
           (define pairs (zip values))
           ; target: ((lambda (a b) (+ a b)) 1 2)
           (append
             ; lambda function
             (list (cons 'lambda ; lambda
                         (cons (car pairs) ; (a b)
                               (map let-to-lambda body)))) ; body after applied let-to-lambda to all elements
             ; arguments
             (map let-to-lambda (cadr pairs)))
           ; END PROBLEM 18
           ))
        (else
          ; BEGIN PROBLEM 18
          (cons (car expr) (map let-to-lambda (cdr expr)))
          ; END PROBLEM 18
          )))
