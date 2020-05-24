type id = string;

datatype binop = Plus | Minus | Times | Div;
datatype stm= CompoundStm of stm * stm
            | AssignStm of id * exp
            | PrintStm of exp list
     and exp = IdExp of id
             | NumExp of int
             | OpExp of exp * binop * exp
             | EseqExq of stm * exp;

val prog =
    CompoundStm(AssignStm("a",OpExp(NumExp 5,Plus, NumExp 3)),
                CompoundStm(AssignStm("b",
                                      EseqExq(PrintStm[IdExp "a",
                                                       OpExp(IdExp "a", Minus, NumExp 1)],
                                              OpExp(NumExp 10, Times, IdExp "a"))),
                            PrintStm[IdExp "b"]));


fun maxargs (CompoundStm (s1,s2)) =
    let
        val ans1= maxargs s1
        val ans2 = maxargs s2
    in
        Int.max (ans1,ans2)
    end
  | maxargs (AssignStm (id1,exp1)) = maxargsExp exp1
  | maxargs (PrintStm elist) = maxargsList (elist
                                           ,List.length elist)
and maxargsExp (IdExp id1) = 0
  | maxargsExp (NumExp int1) = 0
  | maxargsExp (OpExp (e1,bop,e2)) =
    let
        val res1=maxargsExp e1
        val res2=maxargsExp e2
    in
        Int.max (res1,res2)
    end
  | maxargsExp (EseqExq (s1,e1))=
    Int.max (maxargs s1, maxargsExp e1)
and maxargsList (nil, cur) = cur
  | maxargsList ((h :: elist),cur) = maxargsList (elist,
                                                  Int.max (cur,
                                                           maxargsExp h));
type table = (id * int ) list;
fun update (tbl:table, ID:id,value:int) = (ID,value)::tbl;
fun lookup (nil, id) = 0
  | lookup ((hid,hval)::tbl : table, id)  =
    if hid=id then hval else lookup (tbl, id);

fun interpStm ((CompoundStm (s1,s2)), tbl:table) :table=
    interpStm (s2,(interpStm (s1, tbl)))
  | interpStm ((AssignStm (ID:id,e:exp)),tbl) =
    let
        val (r,tbl') = interpExp (e, tbl)
    in
        update (tbl,ID,r)
    end
  | interpStm  ((PrintStm elist),tbl)=
    let
        fun elistF (nil : exp list, tbl)= tbl
          | elistF (h::elist , tbl) =
            let
                val (r,tbl') = interpExp (h,tbl)
            in
                print(Int.toString r);elistF (elist,tbl')
            end
    in
        elistF (elist,tbl)
    end
and interpExp ((IdExp id),tbl:table)=
    ((lookup (tbl, id)),tbl)
  | interpExp ((NumExp num),tbl) = (num,tbl)
  | interpExp (OpExp (e1,bop,e2),tbl) =
    let
        val (v1,tbl') = interpExp (e1,tbl)
        val (v2,tbl'') = interpExp (e2,tbl')
    in
        case bop
         of Plus => (v1+v2,tbl'')
          | Minus  => (v1-v2,tbl'')
          | Times => (v1*v2,tbl'')
          | Div => (v1 div v2,tbl'')
    end
  | interpExp (EseqExq (s1,e1),tbl)=
    interpExp (e1, (interpStm (s1, tbl)))

type key =string;
datatype tree = LEAF | TREE of tree * key * tree;
val empty = LEAF;
fun insert(key,LEAF) = TREE(LEAF,key,LEAF)
  | insert (key,TREE(L,k,r)) =
    if key < k
    then TREE(insert(key,L),k,r)
    else if key > k
    then TREE(L,k,insert(key,r))
    else TREE(L,key,r);

fun member(key,LEAF) = false
  | member (key,TREE(L,k,r)) =
    if key=k
    then true
    else if key < k
    then member(key,L)
    else
        member(key,r);

datatype 'a tree = LEAF | TREE of 'a tree * key * 'a * 'a tree;
fun insert (LEAF:'a tree,key,v: 'a): 'a tree = TREE(LEAF,key,v,LEAF)
  | insert (TREE(L,k,v,R): 'a tree,key,value: 'a):'a tree =
    if k = key
    then TREE(L,k,value,R)
    else if key>k
    then TREE(L,k,v,insert(R,key,value))
    else TREE(insert(L,key,value),k,v,R);
fun lookup (LEAF,key)  = NONE
  | lookup (TREE(L,k,v,R): 'a tree,key) =
    if k=key
    then SOME v
    else if key > k
    then lookup(R,key)
    else lookup(L,key)

