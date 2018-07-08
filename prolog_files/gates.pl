% How to read a file into lists: i needed that for an assignment!
% Run:  read_and_just_print_codes('gates1.txt').
/* The first predicate is not so interesting. It just shows you how you can
 * write in Prolog a predicate that contains a loop with *only* side-effects.
 * Use as:
 *   ?- read_and_just_print_codes('gates1.txt').
 */
read_and_just_print_codes(File) :-
    open(File, read, Stream),
    repeat,
    read_line_to_codes(Stream, X),
    ( X \== end_of_file -> writeln(X), fail ; close(Stream), ! ).

/* The second predicate reads the information of an input file and returns
 * it in two arguments: one list with the keys held initially and one list
 * of gate/3 Prolog structures as in the example shown below:
 * 
 *   ?- read_and_return('gates1.txt', Ks, Gs).
 *   Ks = [1],
 *   Gs = [gate([1], 200, []), gate([1], 150, [1, 3]), 
 *         gate([2, 1], 120, []), gate([3], 140, [1, 2])].
 *
 * To read the information of each of the gates, it uses the auxiliary
 * predicate read_gates/3.

read_and_return(File, Ks, Gs) :-
    open(File, read, Stream),
    read_line(Stream, [K, N]),
    ( K > 0 -> read_line(Stream, Ks) ; K =:= 0 -> Ks = [] ),
    read_gates(Stream, N, Gs),
    close(Stream).

read_gates(Stream, N, Gates) :-
    ( N > 0 ->
	Gates = [G|Gs],
        read_line(Stream, [K1, K2, Money | KeyList]),
	length(InKeys, K1),
	append(InKeys, OutKeys, KeyList),
	length(OutKeys, K2), %% just an assertion -- not really needed
	G = gate(InKeys, Money, OutKeys),
        N1 is N - 1,
        read_gates(Stream, N1, Gs)
    ; N =:= 0 ->
	Gates = []
    ).
*/

read_countries(File, N, List) :-
   open(File, read, Stream),
   read_line(Stream, [N]),
   read_line(Stream, List),
   close(Stream).
 
 /* An auxiliary predicate that reads a line and returns the list of
 * integers that the line contains.
 */
% Based on 'read_gates_SWI.pl'
read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    atom_codes(A, Line),
    atomic_list_concat(As, ' ', A),
    maplist(atom_number, As, List).