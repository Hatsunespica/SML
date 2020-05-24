(*
variables in ML do not vary
ML is lexical scoping
*)

(*
Type bindings
type tycon1 = typ1
and ...
and tyconn = typn

type float = real and average = float
*)

(*
Value bindings
val var1 :typ1 = exp1
and ...
and varn : typn = expn

val pi : real = 3.14 and e:real = 2.17
binding is not assignment. variables are never changed, but we could shadow a binding.
*)

(*
Limiting scope
let dec in exp end
dec is any declarations and exp is any pressions. The scope of the declaration dec is limited to the expression exp.


local dec in dec' end
the scope of the bindings in dec is limited to the declaration dec'
*)


(*
Typing and evaluation
Type checking must take account ofthe declared type of a variable
Evaluation must take accound of the declared value of a variable

It is achieved by maintaining envrionments for type checking and evaluation. The type environmnt records the types of variables; the value envrionments recored their values.
*)
