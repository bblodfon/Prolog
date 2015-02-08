countries(File,Remaining,Expelled):- read_countries(File,N,List), quicksort(List,L),!, bres(L,N,Remaining,0,0,1,1,Expelled,0,1).

% to Remaining einai to neo N pou prokiptei apo tin lista L eno to Expelled einai to neo R.
bres(L,N,Remaining,P1,P2,F1,F2,Expelled,R,1):- absorb(L,2,N,F1,P1,NF1,NP1), reject(L,0,N,F2,P2,NF2,NP2),
count(L,LL,N,NN,NP1,NP2,NNP1,NNP2,NF1,NNF1,NF2,NNF2,R,NR,1,NF), bres(LL,NN,Remaining,NNP1,NNP2,NNF1,NNF2,Expelled,NR,NF).
bres(_,Remaining,Remaining,_,_,_,_,Expelled,Expelled,0).

% na kalestei me I=2 kai F1(1,0),P1 dedomena...
absorb(L,I,N,1,P1,NF1,NP1):- I=<N, NN is N-1, /*print('i='), print(I), print(' '),*/ nth0(NN,L,A), X is A/2, YY is X+0.5, floor(YY,Y), NNN is N-I, nth0(NNN,L,B),
(Y>B -> NNF1 is 0, NNP1 is N-I+1, II is I+1, absorb(L,II,N,NNF1,NNP1,NF1,NP1); II is I+1, absorb(L,II,N,1,P1,NF1,NP1)).
absorb(_,I,N,1,P1,NF1,P1):- I>N, NF1 is 1.
absorb(_,_,_,0,P1,0,P1).

% na kalestei me J=0 kai F2(1,0),P2 dedomena...
reject(L,J,N,1,P2,NF2,NP2):- J<N, JJ is J+1, /* print('j='), print(JJ), print(' '),*/ ( N == 1 -> last(L,A) ; N == JJ -> last(L,A) ; nth0(JJ,L,A) ),
 X is A/2, YY is X+0.5, floor(YY,Y), nth0(0,L,B),(Y>B -> NNF2 is 0, NNP2 is N-JJ, reject(L,JJ,N,NNF2,NNP2,NF2,NP2); reject(L,JJ,N,1,P2,NF2,NP2)).
reject(_,J,N,1,P2,NF2,P2):- J>=N, NF2 is 1 .
reject(_,_,_,0,P2,0,P2).

%count(L,LL,N,NN,P1,P2,NP1,NP2,F1,NF1,F2,NF2,R,NR,F,NF)

count(L,L,N,N,0,P2,0,P2,F1,F1,F2,F2,R,R,_,0):-!.
count(L,L,N,N,P1,0,P1,0,F1,F1,F2,F2,R,R,_,0):-!.
count(L,LL,N,NN,P1,P2,NP1,NP2,F1,NF1,F2,NF2,R,NR,F,F):- P1 =\= 0, P2 =\= 0, (P2<P1 -> NN is N-1, NR is R+1, NF1 is 1,
NP1 is 0, NP2 is P2-1, LL = L, NF2 = F2 ; NN is N-1, NF2 is 1, NP2 is 0, NP1 is P1-1, NR = R, NF1 = F1, smalling(L,LL))
/* , print('P1='), print(NP1), print(' '),print('P2='), print(NP2), print(' ')*/.

%gia tin periptosi [1,5,11] pou ftanei se 2 stoixeia i lista...
%make([_,B],[B,B]).

% creates a sorter list by shifting-left-1
smalling([_],[]):-!.
smalling([_|T],L):- nth1(1,T,A), L=[A|TT], smalling(T,TT).

% taksinomisi se auksousa seira kai i quicksort kai i mergesort. I proti fenetai pio "dinati-grigori" sinithos...
quicksort([],[]).
quicksort([H|T],S) :- partition(H,T,L,R), quicksort(L,SL), quicksort(R,SR), append(SL,[H|SR],S).   

partition(_,[],[],[]).
partition(P,[H|T],[H|L],R):- H=<P,partition(P,T,L,R).
partition(P,[H|T],L,[H|R]):- H>P, partition(P,T,L,R).
/*
mergesort([],[]).
mergesort([A],[A]).
mergesort(L,LL) :- L=[_,_|_],halve(L,X,Y) , mergesort(X,XL) , mergesort(Y,YL) , merge(XL,YL,LL).

halve([],[],[]).
halve([A],[A],[]).
halve([A,B | T],[A|K],[B|O]):-halve(T,K,O).

merge(A,[],A).
merge([],B,B).
merge([H1|T1],[H2|T2],[H1|T]):-H1 =< H2 , merge(T1,[H2|T2],T).
merge([H1|T1],[H2|T2],[H2|T]):-H1 > H2 , merge([H1|T1],T2,T).
*/
% diabasma arxeiou
read_countries(File,N,List):- open(File,read,Stream), read_line(Stream, [N]), read_line(Stream, List), close(Stream).   
read_line(Stream, List):- read_line_to_codes(Stream, Line), atom_codes(A, Line), atomic_list_concat(As,' ', A), maplist(atom_number,As,List).
