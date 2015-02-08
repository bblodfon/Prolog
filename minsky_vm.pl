% virtual machine for OISC based on the model for minsky's machine->( [i,j] :: if j=0 then INC(i) else JZD(i,j) )
% made by: John Zobolas
% Comments:
% Den asxolithika toso me to pos pernei tin eisodo to programma alla opos kai na exei exo merika paradeigmata tou pos trexei
% gia na katalabenomaste...me tin Prolog kataferno na exo tin elaxisti dinati lista(osi xreiazetai diladi) me ta periexomena
% twn registers(Registers) (theoro oti o miden-register exei tin timi 42 kai oloi oi alloi tin timi 0)kathos kai tin lista 
% me ta [i,j] instructions -to programma diladi se morfi OISC - pou einai lista listwn 2 stoixeiwn.
% Examples:
% ?- minsky('test.txt',Answer).
% Answer = 43 ;
% false.
% ?- minsky('user',Answer).
% |: [0,0].
% |: end_of_file.
% Answer = 43.
% ?- minsky('user',Answer).
% |: [0,42].
% |: end_of_file.
% Answer = 41.
% ?- minsky('user',Answer).
% |: [3,0].
% |: [3,1].
% |: end_of_file.
% Answer = 42.


minsky(File,Answer):-file_to_list(File,Programm,MAXR),generate_registers(MAXR,Registers),
                     minsky_machine(Programm,Programm,Registers,NRegisters),nth0(0,NRegisters,Answer).

minsky_machine(Pro,[Assign|Rest],Reg,NReg):-get_first(Assign,I),get_sec(Assign,J),nth0(I,Reg,Elem),
                     minsk_help(J,Elem,NewElem,Jump),(Jump == 0 -> wwrite(I,Reg,NR,NewElem),!,minsky_machine(Pro,Rest,NR,NReg) ;
                     length(Pro,L),(J > L -> minsky_machine(Pro,[],Reg,NReg) ; remainer_list(J,Pro,NList),minsky_machine(Pro,NList,Reg,NReg))).					 
minsky_machine(_,[],Reg,Reg).

% epestrepse tin lista pou menei apo to N-osto kai meta stoixeio
remainer_list(1,P,P).
remainer_list(N,[_|T],L):-N > 1,NN is N-1,remainer_list(NN,T,L).

% i leitourgia tis mixanis minsky einai auti ousiastika(opou X h timi tou kataxoriti stin thesi I).
minsk_help(0,X,Y,0):-Y is X+1,!.
minsk_help(J,X,Y,Jump):-J > 0,(X == 0 -> Jump = 1 ; Y is X-1,Jump = 0).

% stin lista [H|T] bale ton arithmo Num stin thesi Thesi kai ftiakse tin lista [H|L](opou oi theseis metroun apo to 0).
wwrite(0,[_|T],[Num|T],Num).
wwrite(Thesi,[H|T],[H|L],Num):-NThesi is Thesi-1,wwrite(NThesi,T,L,Num).

% pare to arxeio File kai ftiakse mia lista me ta terms pou auto periexei kai
% bres kai to megisto i pou xrisimopoiei to programma(ton megalitero kataxoriti diladi gia na 
% exoume eksoikonomisi xorou !)
file_to_list(File,List,MAXR):-see(File),inquire([],R),reverse(R,List),seen,maxi(List,MAXR,-1).
inquire(IN,OUT):-read(Data),(Data == end_of_file -> OUT = IN ; inquire([Data|IN],OUT) ). 
				 
maxi([H|T],I,Max):-get_first(H,X),maximum(X,Max,MMax),maxi(T,I,MMax).
maxi([],I,I).
get_first([A,_],A).
get_sec([_,B],B).
maximum(A,B,C):-(A > B -> C = A ; C = B).

generate_registers(0,[42]):-!.
generate_registers(N,L):-N > 0,gen_zeros(N,LL),!,append([42],LL,L).
gen_zeros(0,[]).
gen_zeros(K,L):-KK is K-1,gen_zeros(KK,LL),!,append(LL,[0],L).