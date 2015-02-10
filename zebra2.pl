% My own solution to "Who owns the zebra and who drinks the pepsi(!) puzzle" 
% Run: zebra(X).

zebra(Houses):- Houses = [house(norwegian,_,_,_,_),house(_,blue,_,_,_),house(_,_,_,milk,_),_,_],
				member(house(englishman,red,_,_,_),Houses),
				member(house(spaniard,_,dog,_,_),Houses),
				member(house(_,green,_,coffee,_),Houses),
				member(house(ukranian,_,_,tea,_),Houses),
				right_of(house(_,ivory,_,_,_),house(_,green,_,_,_),Houses),
				member(house(_,_,snails,_,old_gold),Houses),
				member(house(_,yellow,_,_,kools),Houses),
				next_to(house(_,_,_,_,chesterfields),house(_,_,fox,_,_),Houses),
				next_to(house(_,_,_,_,kools),house(_,_,horse,_,_),Houses) ,
				member(house(_,_,_,orange_juice,lucky_strike),Houses),
				member(house(japanese,_,_,_,parliaments),Houses).
right_of(X,Y,[X,Y|_]).
right_of(X,Y,[_,X,Y|_]).
right_of(X,Y,[_,_,X,Y|_]).
right_of(X,Y,[_,_,_,X,Y]).
next_to(X,Y, Houses ):-right_of(X,Y,Houses).
next_to(X,Y,Houses):-right_of(Y,X,Houses).