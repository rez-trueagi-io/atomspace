;
; sparse-list.scm
;
; Same as sparse.scm but uses ListLinks.
;

(use-modules (opencog))
(use-modules (opencog exec))

(define est
	(GetLink
		(VariableList
			(TypedVariable (Variable "$vA") (Type 'Concept))
			(TypedVariable (Variable "$vB") (Type 'Predicate))
			(TypedVariable (Variable "$vC") (Type 'Any))

			(Variable "$vD")
			(Glob "rest"))

		(Unordered
			(List (Variable "$vB") (Variable "$vA"))
			(List (Variable "$vC") (Variable "$vB"))
			(List (Variable "$vD") (Variable "$vC"))
			(Glob "rest"))
	))

(define est-uni
	(GetLink
		(VariableList
			(TypedVariable (Variable "$vA") (Type 'Concept))
			(TypedVariable (Variable "$vB") (Type 'Predicate))
			(TypedVariable (Variable "$vC") (Type 'Any))

			(Variable "$vD")
			(Glob "rest"))

		(And
			(Present
				(Unordered
					(List (Variable "$vB") (Variable "$vA"))
					(List (Variable "$vC") (Variable "$vB"))
					(List (Variable "$vD") (Variable "$vC"))
					(Glob "rest")))
			(Not (Identical (Variable "$vD") (Variable "$vB"))))
	))

(Unordered
	(List (Predicate "B") (Concept "A"))
	(List (Any "C") (Predicate "B"))
	(List (Procedure "D") (Any "C"))
	(List (Anchor "E") (Procedure "D"))
	(List (Anchor "F") (Anchor "E"))
	(List (Anchor "G") (Anchor "F"))
)

; (cog-execute! est)
; ---------------------------------------------------------------------

; Palindrome matching.
; Note that the variable tags differ from the above, and so the
; query below will not match the data above.
(define palin
	(GetLink
		(VariableList
			(TypedVariable (Variable "$vA") (Type 'Predicate))
			(TypedVariable (Variable "$vB") (Type 'Concept))
			(TypedVariable (Variable "$vC") (Type 'Any))

			(Variable "$vD")
			(Glob "rest")
		)

		(Unordered
			(List (Variable "$vB") (Variable "$vA"))
			(List (Variable "$vC") (Variable "$vB"))
			(List (Variable "$vD") (Variable "$vC"))
			(Glob "rest")
		)))

(define palin-disambig
	(GetLink
		(VariableList
			(TypedVariable (Variable "$vA") (Type 'Predicate))
			(TypedVariable (Variable "$vB") (Type 'Concept))
			(TypedVariable (Variable "$vC") (Type 'Any))

			(Variable "$vD")
			(Glob "rest"))

		(And
			(Present
				(Unordered
					(List (Variable "$vB") (Variable "$vA"))
					(List (Variable "$vC") (Variable "$vB"))
					(List (Variable "$vD") (Variable "$vC"))
					(Glob "rest")))
			(Not (Identical (Variable "$vD") (Variable "$vB"))))
	))

(Unordered
	(List (Concept "BB") (Predicate "AA"))
	(List (Any "CC") (Concept "BB"))
	(List (Procedure "DD") (Any "CC"))
	(List (Any "EE") (Procedure "DD"))
	(List (Concept "FF") (Any "EE"))
	(List (Predicate "GG") (Concept "FF"))
)

; ---------------------------------------------------------------------
