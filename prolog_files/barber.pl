% try: shaves(barber,john).
% and to get Russel's Paradox: shaves(barber,barber)

shaves(barber, X) :- male(X), \+ shaves(X,X).
male(barber).
male(john).
male(akon).
male(eminem).
