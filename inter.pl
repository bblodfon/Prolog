el(not(E), X) :-el(E, V1),(V1 == true -> X = false; X = true).
el(eq(E1, E2), X) :-el(E1, V1),el(E2, V2),(V1 = V2,X = true;X = false).
el(add(E1, E2),X) :-el(E1, V1),el(E2, V2),X is V1 + V2.
el(sub(E1, E2), X) :-el(E1, V1),el(E2, V2),X is V1 - V2.
el(mul(E1, E2), X) :-el(E1, V1),el(E2, V2),X is V1 * V2.
el(div(E1, E2), X) :-el(E1, V1),el(E2, V2),X is V1 / V2.
el(smaller(E1,E2),X) :- el(E1, V1),el(E2, V2),(V1 < V2 -> X = true ; X = false). 
el(and(E1,E2),X) :- el(E1,V1),el(E2,V2),(V1 = V2,V2 == true, X = true; X = false).
/* applicative evaluation order */
el(apply(apply(E1,E2),E3), X) :-el(apply(E1, E2), X1),el(apply(X1, E3), X).
el(apply(lambda(X1, E1), E2), X) :-el(E2, X1),el(E1, X).
el(apply(fix(X, E1), E2), Y) :-fresh_copy(fix(X, E1), fix(XX, EE)),X = fix(XX, EE),el(apply(E1, E2), Y).
el(let(X, E1, E2), Y) :-el(apply(lambda(X,E2), E1), Y).
el(cond(E1,E2,E3),X) :- el(E1,V1) , (V1 == true , el(E2,X) ; el(E3,X) ).
/* reduction is not possible */
el(X, X).

/* fresh copy */
fresh_copy(X, Y) :-fresh_copy1(X, Y, [], _).
fresh_copy1(X, Y, S, S) :-var(X), exist(X, S, Y).
fresh_copy1(X, Y, S, [X, Y|S]) :-var(X).
fresh_copy1(X, X, S, S) :- atom(X).
fresh_copy1(X, X, S, S) :- integer(X).
fresh_copy1([], [], _, _).
fresh_copy1([X|Xs],[Y|Ys], S1, S2) :-fresh_copy1(X, Y, S1, S3),fresh_copy1(Xs, Ys, S3, S2).
fresh_copy1(X, Y, S, S1) :-X =.. T,fresh_copy1(T, Z, S, S1),Y =.. Z.
exist(X,[Z, Y|_], Y) :- X == Z.
exist(X, [_, _|Rest], Y) :-exist(X, Rest, Y).

a(X,State,apply(lambda(_,X),State)) :- integer(X).
a(X,State,apply(lambda(_,Val),State):- atom(X),lookup(X, State, Val).
a(+(A1,A2),State,add(A1_den,A2_den)) :- a(A1, State, A1_den),a(A2, State, A2_den).
a(*(A1,A2),State,mull(A1_den,A2_den)):- a(A1, State, A1_den),a(A2, State, A2_den).
a(-(A1,A2),State,sub(A1_den,A2_den)) :-a(A1, State, A1_den),a(A2, State, A2_den).
lookup(X,[X,Y|_],Y).
lookup(X,[_,_|Rest],Y) :- lookup(X, Rest, Y).
evaluate(Program, State, Integer) :- a(Program, State, Lambda_code),el(Lambda_code,Integer).



