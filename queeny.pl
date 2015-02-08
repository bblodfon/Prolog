abs(X,Y) :- X >=0, Y is X.
abs(X,Y) :- X < 0, Y is -X.

nocheck([],_).
nocheck([X1/Y1 | R] , X/Y) :- X =\= X1,Y =\=Y1, abs(Y1-Y,G), abs(X1-X,B),G =\= B,nocheck(R,X/Y).

legal([]).
legal([X/Y | R]) :- legal(R), member(X, [1,2,3,4,5,6,7,8]) ,member(Y,[1,2,3,4,5,6,7,8]),nocheck(R,X/Y).

eightqueens(X):- X= [1/_,2/_,3/_,4/_,5/_,6/_,7/_,8/_], legal(X).

e1(X) :- eightqueens(X) , ! .

