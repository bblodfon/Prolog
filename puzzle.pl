change(e,w).
change(w,e).
move([X,X,Goat,Cabbage] , wolf , [Y,Y,Goat,Cabbage]) :- change(X,Y).
move([X,Wolf,X,Cabbage] , goat , [Y,Wolf,Y,Cabbage]) :- change(X,Y).
move([X,Wolf,Goat,X], cabbage , [Y,Wolf,Goat,Y]) :- change(X,Y).
move([X,Wolf,Goat,Cabbage] , nothing , [Y,Wolf,Goat,Cabbage]):-change(X,Y).

oneeq(X,X,_).
oneeq(X,_,X).
safe([Man,Wolf,Goat,Cabbage]):- oneeq(Man,Goat,Wolf), oneeq(Man,Goat,Cabbage).

solution([e,e,e,e] , []).
solution(Config, [Move|Moves]):- move(Config,Move,NextConfig), print(NextConfig), print('\n'), safe(NextConfig), solution(NextConfig,Moves).
