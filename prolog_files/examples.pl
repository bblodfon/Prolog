% some small predicates / functions for exercise

len([],0).
len([_|X],L) :- len(X,A) , L is A+1.

fact(0,1).
fact(N,Result):- PreviousN is N-1, fact(PreviousN,PreviousResult), !, Result is N * PreviousResult. 

binomial(N,1,N):- N >= 1, !.
binomial(N,K,Result):- (K > N ; K < 0), 	Result = 0, !.
binomial(N,K,Result):- (K =:= N ; K =:= 0), Result = 1, !.
binomial(N,K,Result):- K < N, Diafora = N - K, fact(K,KFact), fact(N,NFact), fact(Diafora,DiaforaFact),
                       Result is NFact / (KFact * DiaforaFact).

% computing a^n efficiently
power(_,0,1):-!.
power(A,N,PowerN):- N > 0, HalfN is N/2, floor(HalfN, FHalfN), power(A,FHalfN,PowerHalfN),
                    (even(N) -> PowerN is PowerHalfN * PowerHalfN ; PowerN is A * PowerHalfN * PowerHalfN).

even(N):- (between(0, inf, N); integer(N)), 0 is N mod 2, !.

% Polya's asymptotic formula for Graph Enumeration:
poylaFormula(1,1):-!.					
poylaFormula(N,Result):- N > 1, binomial(N,2,BinomialNto2), power(2,BinomialNto2,Power2BinomialNto2), fact(N,FactN),
                         Result is Power2BinomialNto2 / FactN.

sum([],0).
sum([H|T],A):- sum(T,B), A is H+B.

pith(X,Y,Z):- XX is X*X, YY is Y*Y, ZZ is Z*Z, S is XX+YY, S=ZZ.

gcd(X,Y,GCD):- X =:= Y, GCD is X.
gcd(X,Y,GCD):- X < Y, NY is Y-X, gcd(X,NY,GCD).
gcd(X,Y,GCD):- X > Y, NX is X-Y, gcd(NX,Y,GCD).

abs(X,X):-X>0.
abs(X,-X):-X<0.
abs(X,0):-X =:=0.

my_last([X],X) :- !.
my_last([_|T],Y) :- my_last(T,Y).

element_at(X,[X|_],1).
element_at(X,[_|L],N) :- N > 1 , NN is N-1,element_at(X,L,NN). 

rev([],[]).
rev([H|T],R) :- rev(T,L) , append(L,[H],R).
palindrome(L) :- rev(L,L).

reverse_list(Xs, Ys):- my_reverse(Xs, [], Ys).
my_reverse([], Ys, Ys).
my_reverse([X|Xs], Acc, Ys):- my_reverse(Xs, [X|Acc], Ys).

per([],[]).
per(L,[X|T]):-delete(X,L,LL) , per(LL,T).

delete(X,[X|T],T).
delete(X,[Y|T],[Y|TT]):-delete(X,T,TT).

quicksort([],[]).
quicksort([H|T],L) :- partition(H,T,Min,Max) , quicksort(Min,L1) , quicksort(Max,L2) , append(L1,[H|L2],L).  
partition(_,[],[],[]).
partition(Pivot,[H|T],[H|S],P) :- H =< Pivot , partition(Pivot,T,S,P).
partition(Pivot,[H|T],S,[H|P]) :- H > Pivot , partition(Pivot,T,S,P).

 
inssort(L1,L2) :- insert_sort_intern(L1,[],L2). 
insert_sort_intern([],L,L).
insert_sort_intern([H|T],L1,L) :- insert(L1,H,L2) , insert_sort_int(T,L2,L).

insert([],X,[X]).
insert([H|T],X,[X,H|T]) :- X =< H , !.
insert([H|T],X,[H|T2]) :- insert(T,X,T2).

