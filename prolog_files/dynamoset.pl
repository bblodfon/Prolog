% dynamoset and powerset are two predicates that calculate the powerset of a set!
% The logic is the same in both predicates (using the recursive implementation)
% but the recursion is front->last element of the list for the first implementation 
% and the opposite for the second one.
% Run: dynamoset([1,2,3],L). and: powerset([1,2,3],L). and you will understand.

dynamoset([],[[]]).
dynamoset(L,LL):- makeListNoLast(L,LS), dynamoset(LS,LLS), ! , 
					last(L,LastElement), addLastEverywhere(LastElement,LLS,LLast), append(LLS,LLast,LL).

makeListNoLast([_],[]):- !.
makeListNoLast([H|T],[H|T2]):- makeListNoLast(T,T2).

addLastEverywhere(Element,[H|T],[H2|T2]):- append(H,[Element],H2), addLastEverywhere(Element,T,T2), !.
addLastEverywhere(_,[],[]).

% another way to implement it:

powerset([],[[]]).
powerset([H|T],L):- powerset(T,LL), add_map(H,LL,LLL), append(LL,LLL,L).

add_map(X,[H|T],L):- adder(X,H,HH), add_map(X,T,LL),!, L=[HH|LL].
add_map(_,[],[]).

adder(X,[],[X]).
adder(X,[H|T],[X,H|T]).
