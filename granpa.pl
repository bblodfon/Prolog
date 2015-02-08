male(afigitis). 
male(daddy).
female(xira).
female(kori).
parent(daddy,afigitis).
parent(xira,kori). 
parent(afigitis,moro_1).
parent(daddy,moro_2).
family(afigitis,xira).
family(daddy,kori).

parent(X,Y) :- family(X,Z), parent(Z,Y). % an o X pantreutei tin Z kai i Z eixe os paidi to Y , tote o X ginetai patrios tou paidiou!(ara parent)
parent(X,Y) :- family(Z,X), parent(Z,Y). % an o Z pantreutei tin X kai o Z eixe os paidi to Y , tote i X ginetai mitria tou paidiou!(ara parent)
father(X,Y) :- parent(X,Y), male(X). % pateras tou Y einai o X otan einai arsenikos tou goneas!
grandfather(X,Y) :- father(X,Z), parent(Z,Y).  % X(pappous) -> Z(pateras) -> Y(paidi) 

%an kanoume tin eksis erotisi stin swi-prolog:
% ?-grandfather(afigitis,afigitis).   
% tote tha paroume true os apantisi pragma pou simainei oti o afigitis einai pappous tou eautou tou!!!
