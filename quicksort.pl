% the quicksrot algorithm. Run: quicksort([1,3,2,4,3,3,6,5,7,4,78,2],L).

quicksort([], []).
quicksort([HEAD | TAIL], SORTED) :- partition(HEAD, TAIL, LEFT, RIGHT),
   quicksort(LEFT, SORTEDL), quicksort(RIGHT, SORTEDR), append(SORTEDL, [HEAD | SORTEDR], SORTED).

partition(_, [], [], []).
partition(PIVOT, [HEAD | TAIL], [HEAD | LEFT], RIGHT) :- HEAD =< PIVOT, partition(PIVOT, TAIL, LEFT, RIGHT).
partition(PIVOT, [HEAD | TAIL], LEFT, [HEAD | RIGHT]) :- HEAD > PIVOT, partition(PIVOT, TAIL, LEFT, RIGHT).