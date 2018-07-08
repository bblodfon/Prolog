% This is a faulty solution for the same problem as in the provata.pl program!
% It does not produce the Min Cost of the optimization problem for the third case (provata3.txt file)
% Run: provata('provata3.txt',L). You get: L = 23. (the right answer is L=20 -> provata.pl gives this
% answer as a result!

provata(File,MinCost):- read_tasos(File,Stanes,Provata,Source,Dest), create(Stanes,LL), reverse(LL,L), start(L,L,Source,Dest,Provata,LLmin),!,
                        bgale_midenika(LLmin,LM), min_list(LM,MinCost).
start([],_,_,_,_,[]).
start([Stani|More_stanes],L,S,D,Provata,[Min|Rest_mins]):- create(Provata,Lista_provata),
game_begin(Stani,Lista_provata,L,Provata,[],[],S,D,Min,1), start(More_stanes,L,S,D,Provata,Rest_mins).   

bgale_midenika([H|T],LM):- (H =:= 0 -> bgale_midenika(T,LM) ; bgale_midenika(T,L), append([H],L,LM)). 
bgale_midenika([],[]).

game_begin(_,[],_,_,_,_,_,_,0,_).
game_begin(Stani,Lista_provata,L,Provata,Plati,Stanes_visited,S,D,Min,N):- exei_provato(Stani,S,Bool1), length(Lista_provata,Plithos), 
isa(Plithos,Provata,Bool2), (Bool1 =:= 0, Bool2 =:= 1, N =:= 1 -> Min is 0 ; NN is N+1, move(Stani,Cost_move), bres_posa(Stani,S,0,Posa_load), (Posa_load > 0 -> 
load(Stani,Cost_lload), Cost_load = Cost_lload * Posa_load ; Cost_load = 0), addpro(Stani,S,LLL,1), append(Plati,LLL,Nplati), 
bres_posa(Stani,D,0,Posa_unload), (Posa_unload > 0 -> load(Stani,Cost_unlload), Cost_unload = Cost_unlload * Posa_unload ; Cost_unload = 0),
Cost is Cost_move+Cost_load+Cost_unload, make_new_stanes(Stani,Stanes_visited,NStanes_visited), poia_to_unload(Nplati,D,Stani,Poia), 
del(Nplati,Poia,NNplati), del(Lista_provata,Poia,NLista), lasti(NNplati,Sheep), (Sheep > 0 -> nth1(Sheep,D,NStani)
; one_more(L,NStanes_visited,NStani)), game_begin(NStani,NLista,L,Provata,NNplati,NStanes_visited,S,D,NCost,NN), Min is NCost+Cost).


% bres ena stoixeio tis listas L pou na min yparxei sthn NStanes_visited kai epestrepse to!
one_more([H1|_],[H2|_],K):- H1 =\= H2, K is H1.
one_more([H|T1],[H|T2],K):- one_more(T1,T2,K).
one_more(L,[],K):- lasti(L,K).

lasti(L,A):- last(L,A).
lasti([],0).

% diegrapse ola ta stoixeia tis listas Poia apo tin Nplati
del(Nplati,[H|T],NNplati):- delete(Nplati,H,L), del(L,T,NNplati).
del(A,[],A).

% pairneis tin lista me ta provata [H|T] pou exei stin plati tou o Tasos, blepeis poia exoun os Destination tin Stani, kai ta bazeis stin lista Poia
poia_to_unload([H|T],D,Stani,Poia):- nth1(H,D,St), (St =:= Stani -> Poia = [H|T1], poia_to_unload(T,D,Stani,T1) ; poia_to_unload(T,D,Stani,Poia)).
poia_to_unload([],_,_,[]).

make_new_stanes(Stani,[H|T],[Stani,H|T]).
make_new_stanes(Stani,[],[Stani]).

isa(A,B,0):- A =\= B.
isa(A,A,1).

% ipologizei tin lista L me to poia provata prostithentai stin plati tou Tasou!
addpro(Stani,S,L,N):- length(S,R), N =< R, NN is N+1, nth1(N,S,A), ( A =:= Stani -> L=[N|Tail], addpro(Stani,S,Tail,NN) ; addpro(Stani,S,L,NN)).
addpro(_,S,[],N):- length(S,R), N > R.

first([H|_],H).
first([],_).

exei_provato(A,L,B):- (member(A,L) -> B is 1 ; B is 0). 						

% briskei posa S iparxoun stin lista [H|T] (kaleitai me P=0 panta!)
bres_posa(S,[H|T],P,Posa):- (S =:= H -> NPosa is P+1, bres_posa(S,T,NPosa,Posa) ; bres_posa(S,T,P,Posa)).
bres_posa(_,[],Posa,Posa).

move(_,3).
load(_,1).
unload(_,1).
%flute(_,0).
			
create(N,[N|T]):- N>0, NN is N-1, create(NN,T).  
create(0,[]).

read_tasos(File,Stanes,Provata,S,D):-
    open(File,read,Stream), read_line(Stream,[Stanes,Provata]),
    read_more(Provata,S,D,Stream),
    close(Stream).

read_more(Provata,[H1|T1],[H2|T2],Stream):- Provata > 0, read_line(Stream,[H1,H2]), NProvata is Provata-1, read_more(NProvata,T1,T2,Stream).
read_more(0,[],[],_).

/* An auxiliary predicate that reads a line and returns the list of integers that the line contains */
read_line(Stream, List):- read_line_to_codes(Stream, Line), atom_codes(A, Line), atomic_list_concat(As,' ', A), maplist(atom_number, As, List).
