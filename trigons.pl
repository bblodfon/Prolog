triades(L) :- member(X,[0,1,2,3,4,5,6,7,8,9]) , member(Y,[0,1,2,3,4,5,6,7,8,9]) ,
                  member(Z,[0,1,2,3,4,5,6,7,8,9]) , member(A,[0,1,2,3,4,5,6,7,8,9]) ,
                  member(B,[0,1,2,3,4,5,6,7,8,9]) , member(C,[0,1,2,3,4,5,6,7,8,9]) ,
                  member(D,[0,1,2,3,4,5,6,7,8,9]) , member(E,[0,1,2,3,4,5,6,7,8,9]) ,
                  member(F,[0,1,2,3,4,5,6,7,8,9]) , member(H,[0,1,2,3,4,5,6,7,8,9]) ,
                  diaforetika(X,Y,Z,A,B,C,D,E,F,H), add(X,Y,Z,A,B,C,D,E,F,H),
                  L = [[X,Y,Z],[Y,A,B],[Z,B,C],[A,D,E],[B,E,F],[C,F,H]].

diaforetika(X,Y,Z,A,B,C,D,E,F,H) :- X =\= Y,X =\= Z,X =\= A,X =\= B,X =\= C,
X =\= D,X =\= E,X =\= F,X =\= H,Y =\= Z,Y =\= A,Y =\= B,Y =\= C,Y =\= D,
Y =\= E,Y =\= F,Y =\= H,Z =\= A,Z =\= B,Z =\= C,Z =\= D,Z =\= E,Z =\= F,Z =\= H,
A =\= B,A =\= C,A =\= D,A =\= E,A =\= F,A =\= H,B =\= C,B =\= D,B =\= E,B =\= F,
B =\= H,C =\= D,C =\= E,C =\= F,C =\= H,D =\= E,D =\= F,D =\= H,E =\= F,E =\= H,
F =\= H.
add(X,Y,Z,A,B,C,D,E,F,H) :- addi(X,Y,Z,Q1),addi(Y,A,B,Q2),addi(Z,B,C,Q3),
                                              addi(A,D,E,Q4),addi(B,E,F,Q5),addi(C,F,H,Q6),
                                              Q1 == Q2,Q2 == Q3,Q3 == Q4,Q4 == Q5,Q5 == Q6,
                                              write(Q6).
/* write kai print to idio pragma edo!!! */
addi(X,Y,Z,K) :- K is X+Y+Z.

trio(L) :- permutation([0,1,2,3,4,5,6,7,8,9],L) , L=[X,Y,Z,A,B,C,D,E,F,H],
              add(X,Y,Z,A,B,C,D,E,F,H).

