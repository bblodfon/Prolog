% For printing more characters (list elements, etc) in the command prompt we use the current_prolog_flag predicate
% in which we change the flag max_depth (default "depth" is 10).
% This program returns the siteswaps given the number of balls you juggle,
% the Maximum Throw number and the Period of the siteswap (if you know juggling you may know about this!)
% When I wrote this program I didn't knew about Juggling Lab (which is more MORE advanced than mine) 
% or the other juggling simulators out there!
% Run: siteswap(3,5,3,L).

% Sept 2016: I added a predicate that finds permutated juggling patterns that have all numbers up to n.
% Run: permutationSiteswaps(1,5). 
%      permutationSiteswaps(3,7).

:-set_prolog_flag(toplevel_print_options,[quoted(true), portray(true), max_depth(100), spacing(next_argument)]).

siteswap(Balls,MaxThrow,Period,G):- once(findall(P,generate(Balls,MaxThrow,Period,P),L)),length(L,N),kiliomeno_delete(L,LL,N),!,once(ftiakse(LL,GG)),
allakse(GG,G).

% allakse(A,B):- takes the lists of list A and makes them a string of characters as in this: [2,3,4,3] -> '2343'.
allakse([H1|T1],[H2|T2]):- atomic_list_concat(H1,H2), allakse(T1,T2).
allakse([],[]).

% ftiakse(LL,G):- takes the lists (patterns) of the list LL and puts the biggest number of the pattern in front ([0,1,5] thus becomes [5,0,1])
ftiakse([],[]).
ftiakse([H1|T1],[H2|T2]):- (isa(H1) -> H2 = H1, ftiakse(T1,T2) ; max_list(H1,M), pointer(H1,M,Thesi,1), (Thesi =:= 1 -> H2=H1, ftiakse(T1,T2) ;
Thes is Thesi-1, rotate(H1,Thes,H2), ftiakse(T1,T2))).

% pointer(L,M,Thesi,N):- finds the index Thesi of the element with value M of list L (always to be called with N = 1)
pointer([H|T],M,Thesi,N):- (H =:= M -> Thesi = N ; NN is N+1, pointer(T,M,Thesi,NN)).
pointer([],_,_,_).

kiliomeno_delete(LL,LL,N):-N=<0.
kiliomeno_delete(L,LL,N):-N>0,nth1(N,L,Pattern), length(Pattern,Period), M is Period-1, create_lista_kiliomenon(M,Pattern,Kiliomena_Pattern),
(hasnot_kiliomeno(Kiliomena_Pattern) -> NN is N-1, kiliomeno_delete(L,LL,NN) ; NN is N-M, delette(L,Kiliomena_Pattern,NL),
kiliomeno_delete(NL,LL,NN)).

hasnot_kiliomeno([]):-true.
hasnot_kiliomeno([H]):-isa(H).
hasnot_kiliomeno([H,H|_]).

% delette(L,KL,NL):- deletes from L (list of lists) the lists in KL list and gets as a result the NL list (of lists)
delette(L,[H2|T2],L3):- delete(L,H2,L2), delette(L2,T2,L3).
delette(L,[],L).

% isa(L) :- checks if all the elements of list L are the same!
isa([]):-!.
isa([_]):-!.
isa([H,H|T]):-isa(T).

create_lista_kiliomenon(0,_,[]):-!.
create_lista_kiliomenon(M,P,[H|T]):- NM is M-1, rotate(P,M,H), create_lista_kiliomenon(NM,P,T).  

ises([],[]).
ises([H|T1],[H|T2]):- ises(T1,T2).

% rotate(L1,N,L2) :- the list L2 is obtained from the list L1 by rotating the elements of L1 N places to the left.
rotate([],_,[]) :- !.
rotate(L1,N,L2) :- length(L1,NL1), N1 is N mod NL1, split(L1,N1,S1,S2), append(S2,S1,L2).

% split(L,N,L1,L2) :- the list L1 contains the first N elements of the list L, while the list L2 contains the remaining elements.
split(L,0,[],L).
split([X|Xs],N,[X|Ys],Zs) :- N > 0, N1 is N - 1, split(Xs,N1,Ys,Zs).

generate(Balls,MaxThrow,Period,Pattern):-Balls>0,MaxThrow>=0,Period>0,range(List,0,MaxThrow),create(Pattern,Period,List),
mesos_oros(Pattern,Balls,Period),ftiakse_a(L,Period),elegxos(Pattern,L,Period,Period).

% ftiakse_a(L,N) :- make a list L of 'a' with length equal to N.
ftiakse_a([],0):-!.
ftiakse_a([a|T],N):-NN is N-1, ftiakse_a(T,NN).

% elegxos(Pattern,L,P,P) :- checks if Pattern is a valid juggling pattern. This can be done more easily with some algebraic
% checks but I didn't knew that when I first wrote this program!
elegxos(_,_,0,_).
elegxos(Pattern,L,Mikos,Period):- Mikos > 0, New_Mikos is Mikos-1, nth1(Mikos,Pattern,X), MX is Mikos+X, 
bale(MX,Period,L,LL), elegxos(Pattern,LL,New_Mikos,Period).

bale(MX,Period,L,LL):- (MX =< Period -> check(MX,L,LL) ; NewMX is MX-Period, bale(NewMX,Period,L,LL)).

check(MX,L,LL):- nth1(MX,L,X), (X = '*' -> false ; insert(L,LL,MX)).

insert([_|T],['*'|T],1):-!.
insert([H|T1],[H|T2],N):- NN is N-1, insert(T1,T2,NN).

% range(L,Arxi,Telos) :- creates L list as: [Arxi,Arxi+1,...,Telos].
range([Telos],Telos,Telos):-!.
range([Arxi|Tail],Arxi,Telos):- New_Arxi is Arxi+1, range(Tail,New_Arxi,Telos),!.

% create(L,Period,List) :- generates all possible lists L with length equal to Period and elements from the list List.
create([H],1,List):- member(H,List).
create([H|T],Period,List):- member(H,List), K is Period-1, length(T,K), create(T,K,List).							

% this is true only when the so called Average Theorem in juggling is valid:
% mesos_oros([2,3,4],3,3).
mesos_oros(L,Balls,Period):- addme(L,ElementSum), Average is ElementSum / Period, isa(Balls,Average).

addme([X],X):-!.
addme([H|T],A):- addme(T,E),!, A is E+H.

isa(A,B):- A =:= B.

permutationSiteswaps(Smallest,Largest):- Smallest >= 0, Smallest < Largest, range(List,Smallest,Largest), bresSeires(List).

% finds tricks in the form [A,A+1,...N-1,N] and all their permutations (that are indeed juggling sequences)!
% Input must be a list that is in the form: [a,a+1,a+2,...,b], b>a.
bresSeires(X):- check_linear(X), length(X,Len), findall(L,bresSeira(X,L,Len),LL), length(LL,Leni), 
				(Leni == 0 -> false ; kiliomeno_delete(LL,LLL,Leni), allakse(LLL,LA), printList(LA),!).
bresSeira(X,L,Len):- permutation(X,L), ftiakse_a(A,Len), elegxos(L,A,Len,Len).

% check that the given list is in the form: [a,a+1,a+2,...]
check_linear([_]).
check_linear([A,B]):- B is A+1, !.
check_linear([H|T]):- T = [A|_], H is A-1, check_linear(T).

printList([H|T]):- print(H), nl, printList(T).
printList([]).
