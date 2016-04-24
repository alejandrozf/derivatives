(load "libs.lisp")

(defun pair? (x)
  (not (atom x)))

(defun wff (exp)
  (cond ((atom exp) exp)		                  ;atoms are return it as is
	((numberp (car exp))
	 (cond ((3-term-exp? exp) 		          ;'exp' is a term that is, (3 X 2) or (5 X)
		(cons 'G exp))
	       ((2-term-exp? exp)
		(cons 'G (append exp '(1))))
	       (list (cadr exp) (car exp) 		  ;'exp' is like (3 + g(x))
		     (wff (cadr exp)))))
	((atom (car exp))		                  ;'exp' is like (- g(x))
	 (list (convert-unary (car exp))
	       (wff (cadr exp))))                     
	(t (aux-res (cadr exp)                            ;'exp' is like (f(x) + g(x)) or more generally ((... (f(x)) ...))
		    (wff (car exp))
		    (wff (caddr exp))))))

(defun 3-term-exp? (exp)
  (and (numberp (car exp))
       (atom (cadr exp))
       (numberp (nth 2 exp))))

(defun 2-term-exp? (exp)
  (and (numberp (car exp))
       (atom (cadr exp))
       (null (nth 2 exp))))

(defun convert-unary (val)
  (if (eql val '-)
      'U- val))


(defun aux-res (a b c)
  (cond ((and (null a) (null c)) b)
	(t (list a b c))))

(defun derg (wff)
  "wff = (G C X N)"
  (let* ((c (nth 0 wff))
	 (n (nth 2 wff)))
    (if (eql n 1)
	(* c n)
	(list 'G (* c n) 'X (- n 1)))))

(defun der+ (wff)
  (list '+
	(der-prev (car wff))
	(der-prev (nth 1 wff))))

(defun der- (wff)
  (list '-
	(der-prev (car wff))
	(der-prev (nth 1 wff))))

(defun derU- (wff)
  (list 'U- (der-prev (car wff))))

(defun der* (wff)
  (let* ((1st (nth 0 wff))
	 (2nd (nth 1 wff)))
    (list '+
	  `(* ,(der-prev 1st) ,2nd)
	  `(* ,1st ,(der-prev 2nd)))))

(defun der/ (wff)
  (let* ((1st (nth 0 wff))
	 (2nd (nth 1 wff)))
    (list '/ `(- (* ,(der-prev 1st) ,2nd)
		 (* ,1st ,(der-prev 2nd)))
	  `(* ,2nd ,2nd))))

(defun dersin (wff)
  (let ((val (car wff)))
    (if (atom (car wff))
	(list 'COS val)
	(list '* `(COS ,val) (der-prev val)))))

(defun dercos (wff)
  (let ((val (car wff)))
    (if (atom (car wff))
	(list 'U- `(SIN ,val))
	(list '* `(U- (SIN ,val)) (der-prev val)))))

(defun der-prev (wff)
  (cond ((numberp wff) 0)
	((atom wff) wff)
	(t (eval `(,(getp (car wff) DERIVATIVE) ',(cdr wff))))))

(defun simplify (wff)
  (cond ((atom wff) wff)
	((and (eql (car wff) 'G)	                  ;e.g (G 2 X 0) -> 2
	      (eql (nth 3 wff) 0))
	 (nth 1 wff))
	((eql (car wff) 'G) wff)	                  ;simple terms
	((and (eql (car wff) '-)	                  ;(- exp exp) -> 0
	      (equal (nth 1 wff)
		     (nth 2 wff))) 0)
	((eql (car wff) '+)          	                  ;(+ a 0) or (+ 0 a) cases
	 (cond ((eql (nth 1 wff) 0)
		(simplify (nth 2 wff)))
	       ((eql (nth 2 wff) 0)
		(simplify (nth 1 wff)))
	       (t (list '+ (simplify (nth 1 wff))
			(simplify (nth 2 wff))))))
	((eql (car wff) 'U-)	                          ;(U- (U- wff)) becomes wff
	 (cond ((or (atom (nth 1 wff))
		    (eql (car (nth 1 wff)) 'G)) wff)
	       ((eql (car (nth 1 wff)) 'U-)
		(simplify (nth 1 (nth 1 wff))))
	       (t (list 'U- (simplify (nth 1 wff))))))
	((eql (car wff) '*)                            	  
	 (cond ((and (numberp (nth 1 wff))
		     (numberp (nth 2 wff)))
		(* (nth 1 wff) (nth 2 wff)))
	       ((and (pair? (nth 1 wff))                  ;(* (U- (G 3 X 2)) (G 5 X 3)) -> (U- (* (G 3 X 2) (G 5 X 3)))
		     (eql (car (nth 1 wff)) 'U-))
		(simplify
		 `(U- (* ,(nth 1 (nth 1 wff))
			 ,(nth 2 wff)))))
	       ((and (pair? (nth 2 wff))                  ;(* (G 3 X 2) (U- (G 5 X 3)) )) -> (U- (* (G 3 X 2) (G 5 X 3)))
		     (eql (car (nth 2 wff)) 'U-))               
		(simplify
		 `(U- (* ,(nth 1 (nth 2 wff))
			 ,(nth 1 wff)))))
	       (t (list '* (simplify (nth 1 wff))         ;normal binary * behaviour
			(simplify (nth 2 wff))))))
	((eql (car wff) 'SIN)
	 (list 'SIN (simplify (nth 1 wff))))
	((eql (car wff) 'COS)
	 (list 'COS (simplify (nth 1 wff))))
	(t (list (car wff)
		 (simplify (nth 1 wff))
		 (simplify (nth 2 wff))))))

(defun reduce-negatives (wff)
  (cond ((or (atom wff)
	     (eql (car wff) 'G))
	 wff)
	((eql (car wff) 'U-)
	 (if (and (pair? (nth 1 wff))
		  (eql (car (nth 1 wff)) 'U-))
	     (reduce-negatives (nth 1 (nth 1 wff)))
	     (list 'U- (reduce-negatives (nth 1 wff)))))
	((or (eql (car wff) 'SIN)
	     (eql (car wff) 'COS))
	 (list (car wff)
	       (reduce-negatives (nth 1 wff))))
	((or (eql (car wff) '+)
	     (eql (car wff) '-)
	     (eql (car wff) '*)
	     (eql (car wff) '/))
	 (list (car wff)
	       (reduce-negatives (nth 1 wff))
	       (reduce-negatives (nth 2 wff))))))

  
(defun der (wff)
  (reduce-negatives (simplify (der-prev wff))))



