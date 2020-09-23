(defsystem "buid"
  :author "Bogdan Popa <bogdan@defn.io>"
  :maintainer "Bogdan Popa <bogdan@defn.io>"
  :license "BSD"
  :version "0.1.0"
  :homepage "https://github.com/Bogdanp/lisp-buid"
  :bug-tracker "https://github.com/Bogdanp/lisp-buid/issues"
  :source-control (:git "git@github.com:Bogdanp/lisp-buid.git")
  :description "An implementation of buids for Common Lisp."
  :depends-on ("secure-random")
  :serial t
  :components ((:file "packages")
               (:file "base62")
               (:file "buid")))
