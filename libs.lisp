;;; ****** P U T P ******
;;; (PUTP atm ht value) 
;;;    atm - atom receiving the property
;;;    ht  - a hash table representing the property
;;;    value - the value for the specified atm
;;;  Inserts an entry in the hash-table HT for the specified
;;;  atm and value.
(defun putp (atm ht value )
    (setf (gethash atm ht) value)
)
    
;;; ****** G E T P ******
;;; (GETP atm ht) 
;;;    atm - atom receiving the property
;;;    ht  - a hash table representing the property
;;;  Returns the value for atm as the key in the 
;;;  hash-table HT
(defun getp (atm ht)
    (gethash atm ht)
)

;;; Define the derivative properties for each function
(setf DERIVATIVE (make-hash-table))
(putp 'g DERIVATIVE 'derg )
(putp '+ DERIVATIVE 'der+ )
(putp '- DERIVATIVE 'der-)
(putp 'U- DERIVATIVE 'derU-)
(putp '* DERIVATIVE 'der*)
(putp '/ DERIVATIVE 'der/ )
(putp 'sin DERIVATIVE 'dersin)
(putp 'cos DERIVATIVE 'dercos)
