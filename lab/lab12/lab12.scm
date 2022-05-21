
(define-macro (def func args body)
              `(define ,(cons func args) ,body))


(define (map-stream f s)
  (if (null? s)
    nil
    (cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define all-three-multiples
  (map-stream (lambda (x) (+ x 3))
              (cons-stream 0 all-three-multiples)))


(define (compose-all funcs)
  (if (null? funcs)
    ; base case: return x
    (lambda (x) x)
    ; recursive case: invoke (car funcs) on x first,
    ; then invoke (compose-all (cdr funcs)) on the result
    (lambda (x)
      ((compose-all (cdr funcs)) ((car funcs) x)))))

(define (helper num stream)
  (if (null? stream)
    ; base case: stream is nil
    nil
    ; recursive case: construct stream with new element, and the rest of stream
    (cons-stream
      (+ num (car stream))
      (helper (+ num (car stream)) (cdr-stream stream))
      )
    )
  )

(define (partial-sums stream)
  ; a1 + 0, a2 + a1, ...
  (helper 0 stream)
  )

