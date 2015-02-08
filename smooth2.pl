check([],_).
check([H|T],A):- A mod H > 0 , check(T,A). 

primes(I,Telos,P,P) :- I > Telos,!.
primes(I,Telos,P,Primes) :- I1 is I+2 ,(check(P,I) -> append(P,[I],K) , primes(I1,Telos,K,Primes) ; primes(I1,Telos,P,Primes)).

add_smooths([],_,_,_,0).
add_smooths([H|T],A,I,J,N):- add_smooths(T,A,I,J,N2),A1 is A*H ,node([H|T],A1,I,J,N1) ,N is N1+N2. 

node(_,A,_,J,0):-A>J,!.
node(P,A,I,J,S) :- A<I , add_smooths(P,A,I,J,S). 
node(P,A,I,J,S) :- A>=I,A=<J , add_smooths(P,A,I,J,S1) ,S is S1+1.

smooth(B,I,J,A):-primes(3,B,[2],L),node(L,1,I,J,A),!.