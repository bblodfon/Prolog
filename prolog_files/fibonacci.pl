% The 3 Fibonacci algorithms! fib(X,Y) predicate finds the Xth fibonacci number.
% Run and Compare: 
% time(fib1(30,L)).
% time(fib2(30,L)).
% time(fib3(30,L)).
% to compare the 2nd and the 3rd put X=5000 or something!

fib1(0,0):-!.
fib1(1,1):-!.
fib1(X,Y):- X > 1, T is X-1, L is X-2, fib1(T,TT), fib1(L,LL), Y is TT+LL.


fib2(0,0):-!.
fib2(1,1):-!.
fib2(X,Y):- X > 1, fibb2(X,Y,1,0,2), !.

fibb2(X,Y,Fn_1,Fn_2,I):- I =< X, II is I+1, Fn_11 is Fn_1+Fn_2, fibb2(X,Y,Fn_11,Fn_1,II).  
fibb2(X,Y,Y,_,I):- I>X. 

fib3(0,0):-!.
fib3(1,1):-!.
fib3(X,Y):- X > 1, XX is X/2, ceiling(XX,XXX), NX is XXX-1, fib3(XXX,Y1), fib3(NX,Y2), S is X mod 2, 
            ( S = 1 -> Y is Y1*Y1+Y2*Y2; Y is Y1*Y1+2*Y1*Y2 ).