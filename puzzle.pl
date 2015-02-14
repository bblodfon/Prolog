% The predicate "solution" finds the solution (what else!) to a famous
% children-puzzle in which there are 2 side of a river and a man has to cross
% from the west(w) to the east(e) side using a boat. The problem is that he has
% also to cross 3 other things: a goat, a wolf and a cabbage. Be reminded that the boat
% can only take only one more thing except the man and that if the wolf stays with
% the goat alone, or the goat with the cabbage, the 'stronger' is gonna eat the 'weaker'
% and the crossing fails! While tha game starts at all beings being in the west side
% of the river ([w,w,w,w]), the question is which are the necessary crossings that must
% be done in order for all creatures to reach the east side? ([e,e,e,e])
% Run: solution([w,w,w,w],L,[[w,w,w,w]]).

change(e,w).
change(w,e).
move([X,X,Goat,Cabbage] , wolf , [Y,Y,Goat,Cabbage]) :- change(X,Y).
move([X,Wolf,Goat,X], cabbage , [Y,Wolf,Goat,Y]) :- change(X,Y).
move([X,Wolf,X,Cabbage] , goat , [Y,Wolf,Y,Cabbage]) :- change(X,Y).
move([X,Wolf,Goat,Cabbage] , nothing , [Y,Wolf,Goat,Cabbage]):-change(X,Y). % nothign means that he man returns with the boat alone!

oneeq(X,X,_).
oneeq(X,_,X).
safe([Man,Wolf,Goat,Cabbage]):- oneeq(Man,Goat,Wolf), oneeq(Man,Goat,Cabbage).

solution([e,e,e,e] , [], _).
solution(Config, [Move|Moves], ConfigList):- move(Config,Move,NextConfig), safe(NextConfig), 
				\+ member(NextConfig,ConfigList), append(ConfigList,[NextConfig],NewConfigList), 
				print(NextConfig), print('\n'), solution(NextConfig,Moves,NewConfigList), !.
