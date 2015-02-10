dynamoset([],[[]]).
dynamoset(L,LL):- makeListNoLast(L,LS), dynamoset(LS,LLS), ! , 
					last(L,LastElement), addLastEverywhere(LastElement,LLS,LLast), append(LLS,LLast,LL).

makeListNoLast([_],[]):- !.
makeListNoLast([H|T],[H|T2]):- makeListNoLast(T,T2).

addLastEverywhere(Element,[H|T],[H2|T2]):- append(H,[Element],H2), addLastEverywhere(Element,T,T2), !.
addLastEverywhere(_,[],[]).