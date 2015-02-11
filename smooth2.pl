% This program calculates the same thing as smooth.pl but
% with an ingenious (yet strange) way! (it was made by a classmate of mine
% and it has stuck in my head ever since)
% Run: smooth(2,1,40,L).

smooth(B,I,J,A):- primes(3,B,[2],L),node(L,1,I,J,A),!.

% primes returns a list (L) with all the primes =< Telos (B).
% Should always be called like this: primes(3,B,[2],L).
primes(I,Telos,P,P) :- I > Telos,!.
primes(I,Telos,P,Primes) :- I1 is I+2 ,(check(P,I) -> append(P,[I],K) , primes(I1,Telos,K,Primes) ; primes(I1,Telos,P,Primes)).
check([],_).
check([H|T],A):- A mod H > 0 , check(T,A). 

% node predicate builds from a list of primes (all<B from primes predicate) all possible combinations
% of numbers from these prime factors and counts the ones that are inside the [I,J] interval.
% e.g. for B=5: primes will return L=[2,3,5] and node will keep only 6 of the combinations:
% 10=2x5,16=2^4,18=2x3^2,12=3x2^2,15=3x5,20=2^2x5, all build with prime factors<B, so B-smooth!
node(_,A,_,J,0):-A>J,!.
node(P,A,I,J,S) :- A<I , add_smooths(P,A,I,J,S). 
node(P,A,I,J,S) :- A>=I,A=<J ,% print(A), nl,
					add_smooths(P,A,I,J,S1) ,S is S1+1.
add_smooths([],_,_,_,0).
add_smooths([H|T],A,I,J,N):- add_smooths(T,A,I,J,N2),A1 is A*H , node([H|T],A1,I,J,N1) ,N is N1+N2.