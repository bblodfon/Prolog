% to parakato programma trexei stin swi-prolog(exo tin Version 5.10.0)
% onoma : Ioannis Zompolas , A.M.:03107187
% sto telos tou programmatos exo paradeigmatakia pou deixnoun pos xrisimopoieitai o diermineas pou exo ftiaksei
% alla liga pragmatakia prin : 1)den akolouthisa kai kata gramma tin prostaktiki glossa twn diafaneiwn (ebala as poume
% tis prakseis (+,_,*,/) gia poikilia i den ebala kapia alla) 2)to programma dinetai se morfi listas opou ta stoixeia tis mporei na einai:
% anatheseis(assign),keno(skip),if_statement,akolouthies entolwn (seq)i eidiki for tou Zaxou(!) kai i entoli while(to ti mporoun na periexoun auta mesa einai allo thema)
% 3) gia tin simasiologia tis while den xrisimopoiisa to fix alla o diermineas leitourgei etsi opos ton exo ftiaksei logo tou 4! 4)
% ta Store kai Memory einai listes(idiou mikous) pou periexoun tis metablites tou programmatos.(i seira pou tha tis balo tis metablites stin Store 
% den paizei rolo ->auto pou exei simasia einai an balo Store=[x,y,t] tote na diatiriso tin seira stin Memory = [x,y,t]),an ena programma xrisimopoiei tis metablites
% x,y,w,q tote : Store = Memory = [x,y,w,q] ->gi'auto kai stin arxiki klisi tou kentrikou predicate execute\4 Store = Memory, omos kathos 
% ekteleitai ena programma mporei se mia metabliti na tis anatethei mia timi p.x. x:=1; tote stin thesi tis x stin lista Store tha mpei 
% auti i timi(1) omos i Memory den tha allaksei pote gt an meta argotera exoume tin entoli x:=2; kai i Store einai tis morfis [3,1,y] tote den 
% kseroume pou tha prepei na antikatastisoume to 2 :sto 3 i sto 1 ? exontas omos : Memory=[e,x,y] tote to neo Store ginetai : [3,2,y] 
% 5)i lista Result_store mas dinei tis times pou exoun parei oles oi metablites tou programmatos meta tin ektelesi tou!

execute([Com|Rest],Store,Mem,Result_store):-exe(Com,Store,Mem,Tstore),execute(Rest,Tstore,Mem,Result_store).
execute([],R,_,R).

exe(assign(X,Exp),Store,Mem,Nstore):-member(X,Mem),evaluate(Exp,Store,Mem,A),!,find_element(X,Mem,Thesi),bale_element(A,Store,Thesi,Nstore).
exe(if(B,X,Y),Store,Mem,Nstore):-bool_result(B,Store,Mem,BB),(BB = true -> exe(X,Store,Mem,Nstore) ; exe(Y,Store,Mem,Nstore) ).
exe(for(N,X),Store,Mem,Nstore):-N >= 1,NN is N-1,exe(X,Store,Mem,NNstore),exe(for(NN,X),NNstore,Mem,Nstore).
exe(for(0,_),Store,_,Store).
exe(while(B,X),Store,Mem,Nstore):-bool_result(B,Store,Mem,BB),(BB = true,exe(X,Store,Mem,NNstore),!,exe(while(B,X),NNstore,Mem,Nstore) 
                                  ; exe(skip,Store,Mem,Nstore)).
exe(seq(X,Y),Store,Mem,Nstore):-exe(X,Store,Mem,NNstore),exe(Y,NNstore,Mem,Nstore).								  
exe(skip,Store,_,Store).

evaluate(if(B,N0,N1),S,M,Z):-bool_result(B,S,M,R),(R = true -> evaluate(N0,S,M,Z) ; evaluate(N1,S,M,Z)). 
evaluate(add(X,Y),S,M,Z):-evaluate(X,S,M,XX),evaluate(Y,S,M,YY),Z is XX+YY.
evaluate(sub(X,Y),S,M,Z):-evaluate(X,S,M,XX),evaluate(Y,S,M,YY),Z is XX-YY.
evaluate(mul(X,Y),S,M,Z):-evaluate(X,S,M,XX),evaluate(Y,S,M,YY),Z is XX * YY.
evaluate(div(X,Y),S,M,Z):-evaluate(X,S,M,XX),evaluate(Y,S,M,YY),Z is XX / YY.
evaluate(N,Store,Mem,NN):- ( number(N) -> NN = N ; find_element(N,Mem,Thesi),pare_timi(Store,Thesi,NN) ).

bool_result(true,_,_,true).
bool_result(not(B),S,M,K):-bool_result(B,S,M,BB),(BB = true -> K = false; K = true).
bool_result(and(B0,B1),S,M,K):-bool_result(B0,S,M,BB0),bool_result(B1,S,M,BB1),(BB0 = BB1,BB0 = true -> K = true ; K = false).
bool_result(smaller(N0,N1),S,M,K):-evaluate(N0,S,M,X),evaluate(N1,S,M,Y),(X < Y -> K = true ; K = false).
bool_result(equaln(N0,N1),S,M,K):-evaluate(N0,S,M,X),evaluate(N1,S,M,Y),(X == Y -> K = true ; K = false).
bool_result(equalb(B0,B1),S,M,K):-bool_result(B0,S,M,BB0),bool_result(B1,S,M,BB1),(BB0 = BB1 -> K = true ; K = false).
bool_result(if(B0,B1,B2),S,M,K):-bool_result(B0,S,M,L),(L = true -> bool_result(B1,S,M,K) ; bool_result(B2,S,M,K) ).

pare_timi([H|_],1,H).
pare_timi([_|T],N,X):-N>1,NN is N-1,pare_timi(T,NN,X).
find_element(X,[X|_],1).
find_element(X,[_|T],N):-find_element(X,T,NN),N is NN+1.
bale_element(X,[_|T],1,[X|T]).
bale_element(X,[H|T],N,[H|TT]):-NN is N-1,bale_element(X,T,NN,TT).

% paradeigmata programmatwn pou mporoun na "treksoun": 
% ?- execute([assign(x,10),skip,assign(y,20),skip,assign(z,if(and(not(true),true),add(10,y),mul(x,y)))],[x,y,z],[x,y,z],L).
% diladi einai to programma : (x:=10;skip;y:=20;skip;if(false && true) then z:=10+y; else z:=x*y;)  
% ?- execute([assign(x,1),assign(y,2),assign(z,x),assign(x,y),assign(y,z)],[x,y,z],[x,y,z],L).   swap program:(x:=1;y:=2;swap(x,y);)
% ?- execute([assign(z,x),assign(x,y),assign(y,z)],[x,y,z],[x,y,z],L). ----> L = [y, x, x] ; kai xoris na paroun times oi metablites!!
% ?- execute([assign(x,100),for(100,assign(x,add(x,-1)))],[x],[x],L). (x:=100;for (100) times do{x:=x-1;})
% ?- execute([assign(x,100),while(smaller(0,x),assign(x,sub(x,1)))],[x],[x],Result). ----> Result = [0] ; auto einai to akoloutho
% programma : (x:=100;while(x>0){x:=x-1}) kai bgazei to anamenomeno oti diladi to x exei tin timi 0 sto telos!!!
% na kai ena aplo programma se autin tin glossa pou DEN TERMATIZEI:while(true){skip);
% execute([while(true,skip)],[],[],L). (kai perimeneis kai perimeneis...)
% to paragontiko enos arithmou n(p.x. tou 5) : {n:=5;i:=1;f:=1;while(i<n){i:=i+1;f:=f*i;}return(f)}
% ?- execute([assign(n,5),assign(i,1),assign(f,1),while(smaller(i,n),seq(assign(i,add(i,1)),assign(f,mul(f,i))))],[n,i,f],[n,i,f],Result).
% Result = [5, 5, 120] ; false.  (balte assign(n,500) gia na deite tin dinami tis prolog!!) 
% ?- execute([seq(assign(x,1),seq(assign(y,add(x,1)),assign(z,add(y,1))))],[x,y,z],[x,y,z],L).  L = [1, 2, 3] einai to:{x:=1;y:=x+1;z:=y+1}
% me xrisi sequencies kai mono !!!
% elpizo na egine katanoito to pos leitourgei!!!!!







 





                          
      

              


		 
