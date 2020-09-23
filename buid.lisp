(in-package :buid)

(defconstant *unix-epoch*
  (encode-universal-time 0 0 0 1 1 1970 0))

(defun unix-to-universal-time (unix-time)
  (+ unix-time *unix-epoch*))

(defvar *buid-epoch*
  (unix-to-universal-time 1586026830))

(defun get-centiseconds-since-epoch ()
  (* (- (get-universal-time) *buid-epoch*) 100))

(defconstant *randomness-mask*
  #x7FFFFFFFFFFFFFFFFFFFFF)

(defun get-randomness ()
  (sr:number *randomness-mask*))

(defun make-buid-factory ()
  "Returns a new buid factory.  Factories are not thread-safe."
  (let ((last-t 0)
        (last-r 0))
    (lambda ()
      (let ((new-t (get-centiseconds-since-epoch))
            (s (make-string 22 :initial-element #\0)))
        (if (= new-t last-t)
            (setq last-r (1+ last-r))
            (setq last-t new-t
                  last-r (get-randomness)))
        (write-base62-integer last-r s 22)
        (write-base62-integer last-t s 7)
        s))))

(defvar *factory*
  (make-buid-factory)
  "The default buid factory.")

(defun buid (&optional (f *factory*))
  "Generates a new buid using the factory F."
  (funcall f))
