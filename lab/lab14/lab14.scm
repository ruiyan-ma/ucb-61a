(define (split-at lst n)
  (define (consume lst n ans)
    (if (null? lst)
      ; base case 1: lst is nil, return (ans nil)
      (cons ans nil)
      (if (eq? n 0)
        ; base case 2: n is 0, return (ans lst)
        (cons ans lst)
        ; recursive case: consume (car lst)
        (consume (cdr lst)
                 (- n 1)
                 (append ans (list (car lst)))))))

  (consume lst n nil))


(define-macro (switch expr cases)
              (cons 'cond
                    (map
                      (lambda (case) (cons (list 'eq? expr (car case)) (cdr case)))
                      cases)))

