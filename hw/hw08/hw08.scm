(define (rle s)
  ; consume all val element
  (define (consume s prev count)
    (if (null? s)
      ; base case: s is nil, return current result as a stream
      (cons-stream (list prev count) nil)
      ; recursive case: consume an element each time
      (if (eq? prev (car s))
        ; consume (car s)
        (consume (cdr-stream s) prev (+ count 1))
        ; add (prev count) to the stream, then consume next element
        (cons-stream (list prev count)
                     (consume s (car s) 0)))))

  (if (null? s)
    nil
    (consume s (car s) 0)))

(define (group-by-nondecreasing s)
  (define (consume_list s prev group)
    (if (null? s)
      ; base case: s is nil, return current group as a stream
      (cons-stream group nil)
      ; recursive case: consume a list each time
      (if (>= (car s) prev)
        ; consume (car s)
        (consume_list (cdr-stream s) (car s) (append group (list (car s))))
        ; add current group to the stream, then consume next element
        (cons-stream group
                     (consume_list s (car s) nil)))))

  (if (null? s)
    nil
    (consume_list s (car s) nil)))


(define finite-test-stream
  (cons-stream 1
               (cons-stream 2
                            (cons-stream 3
                                         (cons-stream 1
                                                      (cons-stream 2
                                                                   (cons-stream 2
                                                                                (cons-stream 1 nil))))))))

(define infinite-test-stream
  (cons-stream 1
               (cons-stream 2
                            (cons-stream 2
                                         infinite-test-stream))))

