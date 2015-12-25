% gia na ektyponei parapano elements sto "top level" grapse auto:
% current_prolog_flag(top_level_print_options,X). <- allazoume auto to flag...to default einai max_depth(10).
% This program returns the siteswaps given the number of balls you juggle,
% The Maximum Throw number and the Period of the swap (if you know juggling you may know about this!
% When i wrote this program i didn't knew about juggling lab (which is more MORE advanced than mine) 
% or i did know and i chose to ignore it, i can;t really remember now!
% Anyhow, this was an awesome and really fun program!
% Run: siteswap(3,5,3,L).

:-set_prolog_flag(toplevel_print_options,[quoted(true), portray(true), max_depth(100), spacing(next_argument)]).

siteswap(Balls,MaxThrow,Period,G):- once(findall(P,generate(Balls,MaxThrow,Period,P),L)),length(L,N),kiliomeno_delete(L,LL,N),!,once(ftiakse(LL,GG)),
allakse(GG,G).

% allakse(A,B):- pairnei tis listes tis A listas kai tis kanei meso tou atomic_list_concat:- [2,3,4,3] -> '2343'.
allakse([H1|T1],[H2|T2]):- atomic_list_concat(H1,H2), allakse(T1,T2).
allakse([],[]).

% ftiakse(LL,G):-pairnei kathe pattern tis listas LL kai to kiliei oste to megalitero na einai mporsta panta.
ftiakse([],[]).
ftiakse([H1|T1],[H2|T2]):- (isa(H1) -> H2 = H1, ftiakse(T1,T2) ; max_list(H1,M), pointer(H1,M,Thesi,1), (Thesi =:= 1 -> H2=H1, ftiakse(T1,T2) ;
Thes is Thesi-1, rotate(H1,Thes,H2), ftiakse(T1,T2))).

% pointer(L,M,Thesi,N):- briskei tin thesi tou M pou einai to max tis listas L
pointer([H|T],M,Thesi,N):- (H =:= M -> Thesi = N ; NN is N+1, pointer(T,M,Thesi,NN)).
pointer([],_,_,_).

kiliomeno_delete(LL,LL,N):-N=<0.
kiliomeno_delete(L,LL,N):-N>0,nth1(N,L,Pattern), length(Pattern,Period), M is Period-1, create_lista_kiliomenon(M,Pattern,Kiliomena_Pattern),
(hasnot_kiliomeno(Kiliomena_Pattern) -> NN is N-1, kiliomeno_delete(L,LL,NN) ; NN is N-M, delette(L,Kiliomena_Pattern,NL),
kiliomeno_delete(NL,LL,NN)).

hasnot_kiliomeno([]):-true.
hasnot_kiliomeno([H]):-isa(H).
hasnot_kiliomeno([H,H|_]).

% delette(L,KL,NL):- deletes from L (list of lists) the KL lists and gets NL list of lists. 
delette(L,[H2|T2],L3):- delete(L,H2,L2), delette(L2,T2,L3).
delette(L,[],L).

% isa(L) :- ola ta stoixeia tis listas L isa!
isa([]):-!.
isa([_]):-!.
isa([H,H|T]):-isa(T).

create_lista_kiliomenon(0,_,[]):-!.
create_lista_kiliomenon(M,P,[H|T]):- NM is M-1, rotate(P,M,H), create_lista_kiliomenon(NM,P,T).  

ises([],[]).
ises([H|T1],[H|T2]):- ises(T1,T2).

% rotate(L1,N,L2) :- the list L2 is obtained from the list L1 by 
% rotating the elements of L1 N places to the left.
rotate([],_,[]) :- !.
rotate(L1,N,L2) :- length(L1,NL1), N1 is N mod NL1, split(L1,N1,S1,S2), append(S2,S1,L2).

% split(L,N,L1,L2) :- the list L1 contains the first N elements
% of the list L, the list L2 contains the remaining elements.
split(L,0,[],L).
split([X|Xs],N,[X|Ys],Zs) :- N > 0, N1 is N - 1, split(Xs,N1,Ys,Zs).

generate(Balls,MaxThrow,Period,Pattern):-Balls>0,MaxThrow>=0,Period>0,range(List,0,MaxThrow),create(Pattern,Period,List),
mexri(Pattern,MaxThrow),mesos_oros(Pattern,Balls,Period),ftiakse_a(L,Period),elegxos(Pattern,L,Period,Period).

% to ftiakse_a ftiaxnei mia lista me 'a' mikous N!
ftiakse_a([],0):-!.
ftiakse_a([a|T],N):-NN is N-1, ftiakse_a(T,NN).

% to epomeno katigorima elegxei ta collision p.x. to 543 einai mi apodekto pattern!
elegxos(_,_,0,_).
elegxos(Pattern,L,Mikos,Period):- Mikos > 0, New_Mikos is Mikos-1, nth1(Mikos,Pattern,X), MX is Mikos+X, 
bale(MX,Period,L,LL), elegxos(Pattern,LL,New_Mikos,Period).

bale(MX,Period,L,LL):- (MX =< Period -> check(MX,L,LL) ; NewMX is MX-Period, bale(NewMX,Period,L,LL)).

check(MX,L,LL):- nth1(MX,L,X), (X = '*' -> false ; insert(L,LL,MX)).

insert([_|T],['*'|T],1):-!.
insert([H|T1],[H|T2],N):- NN is N-1, insert(T1,T2,NN).

% to katigorima create dimiourgei listes stoixeion me mikos Period (kai kathe stoixeio exei timi < MaxThrow)	
create([H],1,List):- member(H,List).
create([H|T],Period,List):- member(H,List), K is Period-1, length(T,K), create(T,K,List).							

% to rrange bgazei mia lista : L = [N,N-1,N-2,...,2,1].									
rrange([],0).
rrange([N|T],N):- K is N-1, rrange(T,K).

% to range dimiourgei mia lista: [Arxi,Arxi+1,...,Telos].
range([Telos],Telos,Telos):-!.
range([Arxi|Tail],Arxi,Telos):- New_Arxi is Arxi+1, range(Tail,New_Arxi,Telos),!.

% to katigorima mexri elegxei ean mia lista exei ola tis ta stoixeia mikrotera i isa tou N.
% denxreiaztike telika dioti eftixna tin lista apo 0 mexri tin timi MaxThrow...
mexri([],_).
mexri([H|T],N):- H=<N, mexri(T,N).

% to athroisma kathe stoixeiou tis listas L dia tou arithmou tous, einai iso me ton arithmo ton balls sto juggling.
mesos_oros(L,N,P):- addme(L,A), M is A / P, isa(N,M).

addme([X],X):-!.
addme([H|T],A):- addme(T,E),!, A is E+H.

isa(A,B):- A =:= B.

% finds tricks in the form [1,2,3,..,N] and all their permutations! Input is a list that is in the form a,a+1,a+2,...
bresSeires(X):- check_linear(X), length(X,Len), findall(L,bresSeira(X,L,Len),LL), length(LL,Leni), 
				(Leni == 0 -> false ; kiliomeno_delete(LL,LLL,Leni), allakse(LLL,LA), printList(LA),!).
bresSeira(X,L,Len):- permutation(X,L), ftiakse_a(A,Len), elegxos(L,A,Len,Len).

% check that the given list is in the form: a,a+1,a+2,...
check_linear([_]).
check_linear([A,B]):- B is A+1, !.
check_linear([H|T]):- T = [A|_], H is A-1, check_linear(T).

printList([H|T]):- print(H), nl, printList(T).
printList([]).
