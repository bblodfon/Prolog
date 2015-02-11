% This program evaluates the number of B-smooth numbers from I to J.
% The prime_factors precidate is from the 99 prolog problems i think!
% Run: smooth(2,1,40,L).

% prime_factors(N, L) :- L is the list of prime factors of N.
%    (integer,list) (+,?)

prime_factors(N,L) :- N > 0,  prime_factors(N,L,2).

% prime_factors(N,L,K) :- L is the list of prime factors of N. It is 
% known that N does not have any prime factors less than K.

prime_factors(1,[],_) :- !.
prime_factors(N,[F|L],F) :-                           % N is multiple of F
   R is N // F, N =:= R * F, !, prime_factors(R,L,F). % N = R * F + ( mod = 0 )
prime_factors(N,L,F) :- 
   next_factor(N,F,NF), prime_factors(N,L,NF).        % N is not multiple of F

% next_factor(N,F,NF) :- when calculating the prime factors of N
%    and if F does not divide N then NF is the next larger candidate to
%    be a factor of N.

next_factor(_,2,3) :- !.
next_factor(N,F,NF) :- F * F < N, !, NF is F + 2.
next_factor(N,_,N).                                 % F > sqrt(N)

lasti([A],A).
lasti([_|T],N):-lasti(T,N).

bigger(I,N) :- prime_factors(I,L) , lasti(L,N).

sm(_,1,1).                          % 1 is always smooth!!!!
sm(B,I,1) :- bigger(I,L) , L =< B.  % I is B-smooth
sm(B,I,0) :- bigger(I,L) , L > B.   % I is not B-smooth

smooth(B,I,J,N) :- I = J , X = I , sm(B,X,N).
smooth(B,I,J,N) :- I < J , sm(B,I,N1) , Y is I+1 , smooth(B,Y,J,N2) ,!,  N is N1+N2.