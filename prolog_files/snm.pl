% This was also an assignment for the PL 1 class -> the problem is that i don't even know what it does right now!

%methodos_a(L,L1,A) :- diastrofi_grammis(L,LL,DG) , mikos_stoixeiou(LL,N) , diastrofi_2_n_stili(LL,N,L1,DS) , A is DG+DS.
%THEORO mikos kathe atomou N > =1 allios pistoli->i pio apli lista tha einai tis morfis dld : L = ['1','4',...] !!!!
%methodos_b(L,L2,B) :- diastrofi_1_stilis(L,LL) , diastrofi_grammis(LL,LG,DG) , mikos_stoixeiou(LG,N) , diastrofi_2_n_stili(LG,N,L2,DS) , B is 1+DG+DS.
%diastrofi_1_stilis(L,LL) :- once(pare(L,1,M)) , diastrofi_listas(M,DM) , once(bale(DM,L,1,LL)).

snm(L,Sum,Min,Max) :- methodos(L,L1,A,Count) , allagi(L1,LL) , suma(LL,Sum) , length(LL,Grammes) , mikos_stoixeiou(LL,Stiles) , 
                                      half(Grammes,Stiles,Athroisma,Miso) , (A =< Miso -> Min = A , Max is Athroisma-A ; Max is A+Count , Min is Athroisma-Max).

half(A,B,P,G) :- P is A+B , G is P / 2.

allagi([A],[B]) :- atom_number(A,B). 
allagi([H1|T1],[H2|T2]) :- atom_number(H1,H2) , allagi(T1,T2).

suma([],0).
suma([H|T],B) :- suma(T,A) , B is A+H.

methodos(L,L1,A,Count) :- diastrofi_grammis(L,LL,DG) , mikos_stoixeiou(LL,N) , diastrofi_2_n_stili(LL,N,L1,DS,Count) , A is DG+DS.

diastrofi_2_n_stili(L,1,L,0,0).
diastrofi_2_n_stili(L,N,LL,DS,Count) :- N = 2 , diastrofi_n_stilis(L,2,LL,DS,Count).   
diastrofi_2_n_stili(L,N,LL,DS,Count) :- N > 2, diastrofi_n_stilis(L,N,LG,D1,C1) , NN is N-1 , 
                                                             diastrofi_2_n_stili(LG,NN,LL,D2,C2) , DS is D1+D2 , Count is C1+C2.

diastrofi_grammis([],[],0).
diastrofi_grammis([C],[D],DG) :- mikos_stoixeiou([C],N) , ftiakse(A,N) , ( C @< A -> atom_chars(C,L) ,
                                                   diastrofi_listas(L,LL) , atom_chars(D,LL) , DG = 1 ; DG = 0 , D=C). 
diastrofi_grammis([C1|T1],[C2|T2],DG) :- once(diastrofi_grammis([C1],[C2],N1)) , once(diastrofi_grammis(T1,T2,N2)) , DG is N1+N2.

diastrofi_n_stilis([],_,[],0,0).
diastrofi_n_stilis(L,N,LG,DS,Count) :- once(pare(L,N,M)) , diastrofi_listas(M,DM) , bgale_apostrofous(M,MM) , bgale_apostrofous(DM,DMM) ,
                                                 suma(MM,A) , suma(DMM,DA) , (DA > A ->  once(bale(DM,L,N,LL)) , LG = LL ,DS = 1 ; LG =L , DS = 0) ,
                                                 (DA = A -> Count = 1 ; Count = 0).
   
pare([T1],N,[T2]) :- atom_chars(T1,L) , remove_at(T2,L,N).
pare([H1|T1],N,[H2|T2]) :- pare([H1],N,[H2]) , pare(T1,N,T2).

bale([T1],[T2],N,[T3]) :- atom_chars(T2,L) , insert_at(T1,L,N,LL) , atom_chars(T3,LL).
bale([H1|T1],[H2|T2],N,[H3|T3]) :- bale([H1],[H2],N,[H3]) , bale(T1,T2,N,T3).

insert_at(X,[_|T],1,[X|T]).
insert_at(X,[H|T1],N,[H|T2]) :- N>1 , NN is N-1 ,  insert_at(X,T1,NN,T2).
 
remove_at(X,[X|_],1).
remove_at(X,[_|Xs],K) :- K > 1, K1 is K - 1, remove_at(X,Xs,K1).

bgale_apostrofous([A],[B]) :- atom_number(A,B).
bgale_apostrofous([H1|T1],[H2|T2]) :- atom_number(H1,H2) , bgale_apostrofous(T1,T2). 

diastrofi_listas([A],[B]) :- diastrofi(A,B).
diastrofi_listas([A1|B1],[A2|B2]) :- diastrofi(A1,A2) , once(diastrofi_listas(B1,B2)).
 
mikos_stoixeiou(L,N) :- once(member(X,L)) , atom_chars(X,L1) , length(L1,N).

% N>=1 alios pistoli
ftiakse('5',1). 
ftiakse(L,N) :- K is N-1 , length(L2,K) , gemise(L2,'0') , L1 = ['5'] , append(L1,L2,L3) , atom_chars(L,L3).

gemise([H],'0') :- H = '0'.
gemise([H|T],'0') :- H = '0' , gemise(T,'0').

diastrofi('0','9').
diastrofi('1','8').
diastrofi('2','7').
diastrofi('3','6').
diastrofi('4','5').
diastrofi('5','4').
diastrofi('6','3').
diastrofi('7','2').
diastrofi('8','1').
diastrofi('9','0').