% Given Cmax, 'piths' predicate finds all Pythagorean triads (a,b,c) that satisfy:
% c <= Cmax and a^2+b^2=c^2
% Run: piths(100).

piths(Cmax):- findall(Triad,findOneTriad(Cmax,Triad),L), length(L,Triads), 
				format("We have found "), print(Triads), format(" Pythagorean Triads:"), nl, printList(L).

findOneTriad(Cmax,Triad):- make_seq(1,Cmax,ListC), member(C,ListC), make_seq(1,C,ListB), member(B,ListB),
			   make_seq(1,B,ListA), member(A,ListA), pith(A,B,C), Triad = [A,B,C]. 
			   
make_seq(X,Y,[X|T]):- X =< Y, Z is X+1, make_seq(Z,Y,T), !.
make_seq(X,Y,[]):- X > Y.

pith(X,Y,Z) :- XX is X*X, YY is Y*Y, ZZ is Z*Z, S is XX+YY, S=ZZ.

printList([H|T]):- print(H), nl, printList(T).
printList([]).