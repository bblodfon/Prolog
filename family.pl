parent(kim,holly).
parent(margaret,kim).
parent(margaret,kent).
parent(esther,margaret).
parent(herbert,margaret).
parent(herbert,jean).
sibling(X,Y) :- parent(P,X) , parent(P,Y),\+ (X = Y) .
ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(Z,Y) , ancestor(X,Z).
