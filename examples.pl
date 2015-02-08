% some small predicates / functions for exercise

len([],0).
len([_|X],L) :- len(X,A) , L is A+1.

sum([],0).
sum([H|T],A) :- sum(T,B) , A is H+B.

pith(X,Y,Z) :- XX is X*X, YY is Y*Y, ZZ is Z*Z, S is XX+YY, S=ZZ.

gcd(X,Y,GCD) :- X=:=Y , GCD is X.
gcd(X,Y,GCD) :- X<Y , NY is Y-X , gcd(X,NY,GCD).
gcd(X,Y,GCD) :- X>Y , NX is X-Y , gcd(NX,Y,GCD).

abs(X,X):-X>0.
abs(X,-X):-X<0.
abs(X,0):-X =:=0.

my_last([a],a).
my_last([_|T],Y) :- last(T,Y).

element_at(X,[X|_],1).
element_at(X,[_|L],N) :- N > 1 , NN is N-1,element_at(X,L,NN). 

rev([],[]).
rev([H|T],R) :- rev(T,L) , append(L,[H],R).
palindrome(L) :- rev(L,L).

per([],[]).
per(L,[X|T]):-delete(X,L,LL) , per(LL,T).

delete(X,[X|T],T).
delete(X,[Y|T],[Y|TT]):-delete(X,T,TT).

quicksort([],[]).
quicksort([H|T],L) :- partition(H,T,Min,Max) , quicksort(Min,L1) , quicksort(Max,L2) , append(L1,[H|L2],L).  
partition(Pivot,[],[],[]).
partition(Pivot,[H|T],[H|S],P) :- H =< Pivot , partition(Pivot,T,S,P).
partition(Pivot,[H|T],S,[H|P]) :- H > Pivot , partition(Pivot,T,S,P).

 
inssort(L1,L2) :- insert_sort_intern(L1,[],L2). 
insert_sort_intern([],L,L).
insert_sort_intern([H|T],L1,L) :- insert(L1,H,L2) , insert_sort_int(T,L2,L).

insert([],X,[X]).
insert([H|T],X,[X,H|T]) :- X =< H , !.
insert([H|T],X,[H|T2]) :- insert(T,X,T2).

