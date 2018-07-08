% This predicate finds all the sublists of a list
% Run: sub(L,[1,2,3,4]).

sub([],[]).
sub([H|T],[H|R]):-sub(T,R).
sub(X,[_|R]):-sub(X,R).