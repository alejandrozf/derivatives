(load "derivatives.lisp")
;;; Convert the expressions to WFFs

;;; simple polynomials
(setf wff1 (wff '(4 X 3) ))
(setf wff2 (wff '((2 X 3) + (5 x 2) ) ))
(setf wff3 (wff '((3 X 3) + 5) ))
(setf wff4 (wff '((4 X 3) + (6 X) ) ))
(setf wff5 (wff '((5 x 4) + ((3 X 2) + (5 X))) ))

;;; SIN 
(setf wff6 (wff '(SIN X) ))
(setf wff7 (wff '( SIN ( 7 X 2) ) ))
(setf wff8 (wff '( (8 X 3) + (SIN (2 X)) ) ))

;;; diff, product, quotient
(setf wff9 (wff '( (9 X 4) - (2 X 3)) ))
(setf wff10 (wff '( (10 X 3) * (5 X 2)) ))
(setf wff11 (wff '( (11 X 3) / (2 X 1) ) ))
(setf wff12 (wff '( (12 X 4) * ( (1 X 5) + (2 X 4)) ) ))

;;; more complex
(setf wff13 (wff '(SIN ( (13 X 2) / (2 X 3)) ) ))
(setf wff14 (wff '(COS ( 14 X)) ))

;;; others
(setf wff15 (wff '( (15 X 1) - (15 X)) ))
(setf wff16 (wff '( ((16 X) + 5) * (4 X)) ))

;;; unary
(setf wff17 (wff '( - (17 X 2) ) ))
(setf wff18 (wff '( - (COS ( 18 X)) ) ))

;;; simple?
(setf wff19 (wff '(19 X) ))
(setf wff20 (wff '( (20 X 2) - ( 20 x 2)) ))
(setf wff21 (wff '(-(cos X)) ))
(setf wff22 (wff '(- (sin (- (22 X 2)))) ))
(setf wff23 (wff '( (- (23 X 2)) * (- (3 X 3))) ))
(setf wff24 (wff '(cos (- (24 X 2))) ))

;;; Take the derivatives
(format t "~a <- ~a~%"  wff1 'wff1)
(format t "~a <- ~a~%" (der wff1) '(der wff1))
(format t "~a <- ~a~%" wff2 'wff2)
(format t "~a <- ~a~%" (der wff2) '(der wff2))
(format t "~a <- ~a~%" wff3 'wff3)
(format t "~a <- ~a~%" (der wff3) '(der wff3))
(format t "~a <- ~a~%" wff4 'wff4)
(format t "~a <- ~a~%" (der wff4) '(der wff4))
(format t "~a <- ~a~%" wff5 'wff5)
(format t "~a <- ~a~%" (der wff5) '(der wff5))

;;; SIN
(format t "~a <- ~a~%" wff6 'wff6)
(format t "~a <- ~a~%" (der wff6) '(der wff6))
(format t "~a <- ~a~%" wff7 'wff7)
(format t "~a <- ~a~%" (der wff7) '(der wff7))
(format t "~a <- ~a~%" wff8 'wff8)
(format t "~a <- ~a~%" (der wff8) '(der wff8))


;;; difference
(format t "~a <- ~a~%" wff9 'wff9)
(format t "~a <- ~a~%" (der wff9) '(der wff9))

;;; product
(format t "~a <- ~a~%" wff10 'wff10)
(format t "~a <- ~a~%" (der wff10) '(der wff10))

;;; quotient
(format t "~a <- ~a~%" wff11 'wff11)
(format t "~a <- ~a~%" (der wff11) '(der wff11))

;;; more complex product
(format t "~a <- ~a~%" wff12 'wff12)
(format t "~a <- ~a~%" (der wff12) '(der wff12))

;;; Chain rule with SIN
(format t "~a <- ~a~%" wff13 'wff13)
(format t "~a <- ~a~%" (der wff13) '(der wff13))

;;; COS
(format t "~a <- ~a~%" wff14 'wff14)
(format t "~a <- ~a~%" (der wff14) '(der wff14))

;;; difference x
(format t "~a <- ~a~%" wff15 'wff15)
(format t "~a <- ~a~%" (der wff15) '(der wff15))

;;; producct
(format t "~a <- ~a~%" wff16 'wff16)
(format t "~a <- ~a~%" (der wff16) '(der wff16))

;;; unary
(format t "~a <- ~a~%" wff17 'wff17)
(format t "~a <- ~a~%" (der wff17) '(der wff17))

(format t "~a <- ~a~%" wff18 'wff18)
(format t "~a <- ~a~%" (der wff18) '(der wff18))

;;; simple?
(format t "~a <- ~a~%" wff19 'wff19)
(format t "~a <- ~a~%" (der wff19) '(der wff19))

(format t "~a <- ~a~%" wff20 'wff20)
(format t "~a <- ~a~%" (der wff20) '(der wff20))

(format t "~a <- ~a~%" wff21 'wff21)
(format t "~a <- ~a~%" (der wff21) '(der wff21))

(format t "~a <- ~a~%" wff22 'wff22)
(format t "~a <- ~a~%" (der wff22) '(der wff22))

(format t "~a <- ~a~%" wff23 'wff23)
(format t "~a <- ~a~%" (der wff23) '(der wff23))

(format t "~a <- ~a~%" wff24 'wff24)
(format t "~a <- ~a~%" (der wff24) '(der wff24))

(print 'DONE)
