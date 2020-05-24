(*
 * Most familiar programming languages, such as C or Java, are based on an imperiative model of computation. Each step of exectuion examines the current contents of memeory perofrms a simple computation, modifies the memory, and continues with the next insturction.
 * The emphasis in ML is on computation by evaluation of expressions. It brings several advantages. Because of its close relationship to math, it is much easier to develop mathematical techniques for reasonning about the behavior of programs.
 *)

(*
 * Each expression has three important characteristics:
 * It may or may not have a type
 * It may or may not have a value
 * It may or may not engender an effect
 * Well-typed: every expression is required to have at least one type, otherwise it's called ill-typed. The type checker determine whether or not an expression is well-typed, rejecting with an error those that are not.

Effects include such phenomena as raising an exception, modifying memory, performing input or ouput, or sending a message on the network. It calls side effects sometimes.
 *)

(*
A type is defiend by specifying three things:
a name for the type
the values of the type
the operations that may be performed on values of the type
 *)

(*
Basic types:
int,real
char #"a"
string "asd"
bool true|false; if exp then exp1 else exp2

*)
