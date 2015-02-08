powerset([],[[]]).
powerset([H|T],L):- powerset(T,LL), add_map(H,LL,LLL), append(LL,LLL,L).

add_map(X,[H|T],L):- adder(X,H,HH), add_map(X,T,LL),!, L=[HH|LL].
add_map(_,[],[]).

adder(X,[],[X]).
adder(X,[H|T],[X,H|T]).