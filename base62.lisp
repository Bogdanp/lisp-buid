(in-package :buid.base62)

(eval-when (:compile-toplevel)
  (defvar *alphabet*
    "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"))

(defmacro int2char (n)
  "Converts N to a base 62 character. Returns NIL when N is outside
the range [0, 62)."
  (let ((n-name (gensym "N"))
        (table (loop :for i :from 0 :to (1- (length *alphabet*))
                  :collect `(,i ,(elt *alphabet* i)))))
    `(let ((,n-name ,n))
       (case ,n-name ,@table))))

(defun write-base62-integer (n out size)
  "Writes N to OUT as a base 62 value from SIZE downto 0."
  (do ((n n (floor n 62))
       (i (1- size) (1- i)))
      ((or (= n 0) (= i 0)))
    (setf (elt out i) (int2char (rem n 62)))))
