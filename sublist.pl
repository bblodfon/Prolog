sub([],[]).
sub([H|T],[H|R]):-sub(T,R).
sub(X,[_|R]):-sub(X,R).