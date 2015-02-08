is_win([x,x,x]).
is_win([b,x,x]).
is_win([x,b,x]).
is_win([x,x,b]).

triple(L,T) :- member(T,L).
triple(L,T) :- transpose(L,LT),member(T,LT).
triple([[A,_,_],[_,B,_],[_,_,C]],[A,B,C]).
triple([[_,_,A],[_,B,_],[C,_,_]],[A,B,C]).

transpose([[A,B,C],[D,E,F],[G,H,I]],[[A,D,G],[B,E,H],[C,F,I]]).

winner(L) :- L=[_,_,_] , triple(L,T) , is_win(T).