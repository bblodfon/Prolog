provata(File,MinCost):- read_tasos(File,Stanes,Provata,Source,Dest), lleutheia(Stanes,Lstanes), eutheia(Provata,Lprovata),
start(Lstanes,[Lprovata],Source,Dest,Stanes,Lmiki), min_list(Lmiki,Min_mikos), MinCost is (Provata*2)+(Min_mikos*3).

% ftiaxnei to tree_search ksekinontas apo kathe Stani.
start([Riza|Rest],LEE,S,D,Stanes,[Mikos|T]):- search_tree([Riza],LEE,[[]],S,D,Stanes,Mikos), start(Rest,LEE,S,D,Stanes,T).
start([],_,_,_,_,[]).

% ftaixnei to tree siga siga kanei load unload se kathe diadromi, kanei pruning, kai sto telos bgazei 
% to mikos tou mikroterou monopatiou pou eftase proto se [] lista LEE, 
% dld o Tasos afise ola ta probata kai teliose tin douleia tou!
search_tree(Level,LEE,LPlati,S,D,Stanes,Mikos):- work_level(Level,LEE,LNEE,LPlati,NLPlati,S,D), check_empty(LNEE,Check),
(Check =:= 1 -> bres_miki(LNEE,K), nth1(Thesi,K,0), nth1(Thesi,Level,Kombos), length(Kombos,Mikos) ;
 adeiasma(LNEE,EE,NLPlati,NP,Level,NLevel), expand_tree(NLevel,L,EE,E,NP,P,Stanes), search_tree(L,E,P,S,D,Stanes,Mikos)).

% kanoume kata platos 'work' sto dentro.
work_level([HKombos|TKombos],[HE|TE],[HNEE|TNEE],[HPlati|TPlati],[HNPlati|TNPlati],S,D):-
   work(HKombos,HE,HNEE,HPlati,HNPlati,S,D), work_level(TKombos,TE,TNEE,TPlati,TNPlati,S,D).
work_level([],[],[],[],[],_,_).

% i work douleuei apokleistika me kathe enan kombo ksexorista kai tou kanei unload+load!!!
% work([1,3],[1,2,3,4],NEE,[1,2],NPlati,[1,1,2,3],[2,3,1,2]).
% NEE = [1, 3, 4],
% NPlati = [1, 4].
work(Kombos,E,NEE,Plati,NPlati,S,D):- last(Kombos,Stani), unload(Plati,D,Stani,Poia), reverse(Poia,P),
append(NNPlati,P,Plati), deli(E,Poia,NEE), ksana(Kombos,Bool), load(NNPlati,S,Stani,NPlati,1,Bool).

% Bool = 1 an to last tis L ksanaemfanizetai, eidallos Bool = 0.
ksana(L,Bool):- last(L,Last), check_ksana(L,Last,Bool).

% elegxei an iparcei to teleuteo xtoixeio mias listas kapou allou mesa tis, dld:
% check_ksana([1,1,3],3,L) -> L = 0.
% check_ksana([3,1,3],3,L) -> L = 1.
check_ksana([_],_,0):-!.
check_ksana([H|T],Last,Bool):- (H =\= Last -> check_ksana(T,Last,Bool) ; Bool = 1).

% diegrapse ola ta stoixeia tis listas [H|T] apo tin lista E.
deli(E,[H|T],NEE):- delete(E,H,L), deli(L,T,NEE).
deli(E,[],E).

% ftiaxnei tin nea plati tou Tasou me probata pou exoun os Source([H|T]) tin Stani.(panta:Thesi=1)
% AN I TELEUTEA PARAMETROS EINAI 0 SIMAINEI OTI PROTI FORA SINANTAO TIN STANI AUTI OPOTE KANO LOAD
% ALLIOS MENEI I PLATI TOU TASOU OS EXEI (1).
% p.x.:  load([],[1,1,2,3],1,NPL,1,0) -> NPL = [1, 2]. 
load(Plati,[H|T],Stani,NPlati,Thesi,0):- NThesi is Thesi+1, (H =:= Stani -> append(Plati,[Thesi],NNPlati),
load(NNPlati,T,Stani,NPlati,NThesi,0) ; load(Plati,T,Stani,NPlati,NThesi,0)).
load(P,[],_,P,_,0).
load(P,_,_,P,_,1).

% unload([1,2,3,4],[2,3,1,2],1,P) -> P = [] kai: unload([1,2,3],[2,3,1,2],1,P) -> P = [3].
% unload([1,2],[2,3,1,2],3,P) -> P = [2].
unload(Plati,D,Stani,Poia):- last(Plati,Provato), nth1(Provato,D,DStani), append(L,[Provato],Plati),
(Stani =:= DStani -> Poia = [Provato|T], unload(L,D,Stani,T) ; unload([],D,Stani,Poia)). 
unload([],_,_,[]).

% elegxei an iparxei keni lista mesa stis listes:
check_empty([H|T],Check):- (H = [] -> Check = 1 ; check_empty(T,Check)).
check_empty([],0).

% pairnei tin lista me ta probata pou exoun minei apo ta arxika - se na bathos dentrou - mazi
% me tin lista apo Plates tou Tasou kai ta antoistoixa tree_nodes (os listes) 
% kai paragei ta nea pou tha sinexisoun!
% adeiasma([[1,2,3,4],[1,2,3],[2,3,4]],LL,[[],[1,2],[2,3]],NP,[[1,2],[1,3],[1,4]],NT).
% LL = [[1, 2, 3], [2, 3, 4]],
% NP = [[1, 2], [2, 3]],
% NT = [[1, 3], [1, 4]]
adeiasma(L,LL,LPlati,NLPlati,Oldtree,Newtree):- min_lista(L,Thesi), del(L,Thesi,LL), del(LPlati,Thesi,NLPlati),
 del(Oldtree,Thesi,Newtree).

% ftiaxnei lista me ta stoixeia pou einai stis theseis [H|T]. 
del(L,[H|T],LL):- nth1(H,L,A), LL=[A|Tail], del(L,T,Tail).
del(_,[],[]).

% epistrefei ton pinaka me tis theseis ton elaxiston se mikos liston tis listas apo listes L!
%  min_lista([[1,2],[3,4],[1,2,3,4],[2,3]],L) -> L = [1, 2, 4].
min_lista(L,Thesi):- bres_miki(L,LL), min_list(LL,Min), length(LL,MM), bres_min_theseis(LL,Min,Thesi,MM,1).

% briskei tis theseis ton elaxiston [H|T] dld ton timon = Min.
% bres_min_theseis([1,2,1,4,6,5,1,3,4],1:to elaxisto pou emfanizetai stin lista,T,9:mikos_listas,1:panta) => T = [1, 3, 7].
bres_min_theseis([H|T],Min,Thesi,Mikos,Th):- Mikos>=Th, NTh is Th+1, (H =:= Min -> Thesi = [Th|Tail], bres_min_theseis(T,Min,Tail,Mikos,NTh)
 ; bres_min_theseis(T,Min,Thesi,Mikos,NTh)).
bres_min_theseis([],_,[],Mikos,Th):- Mikos < Th.

% briskei ta miki ton liston : bres_miki([[],[1,2,3],[2],[4,4,4,4,4]],K).
% K = [0, 3, 1, 5].
bres_miki([H|T],[A|B]):- length(H,A), bres_miki(T,B).
bres_miki([],[]).

% ftiaxnei tous kombous tou tree enos epomenou "bathmou" maz ime tis listes liston tis platis tou Tasou
% kai ton probaton pou exoun meinei(E).
% expand_tree([[1,2],[1,3]],L,[[1,2,3,4],[1,3,4]],K,[[],[1]],P,3).
% L = [[1, 2, 3], [1, 2, 1], [1, 3, 2], [1, 3, 1]],
% K = [[1, 2, 3, 4], [1, 2, 3, 4], [1, 3, 4], [1, 3, 4]],
% P = [[], [], [1], [1]] ;
expand_tree([HNLevel|TNLevel],L,[HEE|TEE],E,[HNP|TNP],P,Stanes):- filla(HNLevel,K,Stanes), length(K,Len), 
   make(Len,HEE,NEE), make(Len,HNP,NNP), expand_tree(TNLevel,LL,TEE,LEE,TNP,LP,Stanes), append(K,LL,L), 
   append(NEE,LEE,E), append(NNP,LP,P).
expand_tree([],[],[],[],[],[],_).
   
make(Len,K,[K|T]):- Len > 0, L is Len-1, make(L,K,T).
make(0,_,[]).

% ftiaxnei tous kombous tou tree enos epomenou "bathmou"
% p.x.  tree([[1]],L,3) -> L = [[1, 3], [1, 2]] ;
% tree([H|T],LL,N):- filla(H,HH,N), tree(T,LLL,N), append(HH,LLL,LL).
% tree([],[],_). 

% ftiaxnei ta filla enos kombou L enos dentrou me N-1 filla ana kombo, dld
% o kombos [1,2,3,2] me N=4 exei gia paidia: [1,2,3,2,1],[1,2,3,2,3],[1,2,3,2,4]
filla(L,LL,N):- N>0, last(L,A), NN is N-1,(A =\= N -> LL=[H|T], append(L,[N],H), filla(L,T,NN) ; filla(L,LL,NN)).  
filla(_,[],0).

% ftiaxnei anapoda mia lista, dld [5,4,3,2,1] gia N=5.
create(N,[N|T]):- N>0, NN is N-1, create(NN,T).  
create(0,[]).

% kanei oti kai i create alla me listes liston!
llcreate(N,[[N]|T]):- N>0, NN is N-1, llcreate(NN,T).
llcreate(0,[]).

% kanei oti kai i eutheia(N,L) alla me listes liston!
lleutheia(N,L):- llcreate(N,LL), reverse(LL,L).

% ftiaxnei kanonika mia lista, dld [1,2,3] gia N=3.
eutheia(N,L):- create(N,LL), reverse(LL,L).

read_tasos(File,Stanes,Provata,S,D):-
    open(File,read,Stream), read_line(Stream,[Stanes,Provata]),
    read_more(Provata,S,D,Stream),
    close(Stream).

read_more(Provata,[H1|T1],[H2|T2],Stream):- Provata > 0, read_line(Stream,[H1,H2]), NProvata is Provata-1, read_more(NProvata,T1,T2,Stream).
read_more(0,[],[],_).

/* An auxiliary predicate that reads a line and returns the list of integers that the line contains */
read_line(Stream, List):- read_line_to_codes(Stream, Line), atom_codes(A, Line), atomic_list_concat(As,' ', A), maplist(atom_number, As, List).