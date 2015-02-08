provata(File,MinCost):- read_tasos(File,_,Provata,_,_), MinCost is ((Provata+1)*3)+(2*Provata). 

read_tasos(File,Stanes,Provata,S,D):-
    open(File,read,Stream), read_line(Stream,[Stanes,Provata]),
    read_more(Provata,S,D,Stream),
    close(Stream).

read_more(Provata,[H1|T1],[H2|T2],Stream):- Provata > 0, read_line(Stream,[H1,H2]), NProvata is Provata-1, read_more(NProvata,T1,T2,Stream).
read_more(0,[],[],_).

/* An auxiliary predicate that reads a line and returns the list of integers that the line contains */
read_line(Stream, List):- read_line_to_codes(Stream, Line), atom_codes(A, Line), atomic_list_concat(As,' ', A), maplist(atom_number, As, List).
