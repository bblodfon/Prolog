% the classic mergesort algorithm
% Run: mergesort([1,4,2,6,3,9,7,9],L).

mergesort([],[]).
mergesort([A],[A]).
mergesort(L,LL) :- L=[_,_|_], halve(L,X,Y) , mergesort(X,XL) , mergesort(Y,YL) , merge(XL,YL,LL).

halve([],[],[]).
halve([A],[A],[]).
halve([A,B | T],[A|K],[B|O]):-halve(T,K,O).

merge(A,[],A).
merge([],B,B).
merge([H1|T1],[H2|T2],[H1|T]):-H1 =< H2 , merge(T1,[H2|T2],T).
merge([H1|T1],[H2|T2],[H2|T]):-H1 > H2 , merge([H1|T1],T2,T).
