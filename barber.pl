shaves(barber, X) :- male(X), \+ shaves(X,X).
male(barber).
male(john).
male(akon).
male(eminem).
male(malakas).
