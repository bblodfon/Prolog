% prime_factors(N, L) :- N is the list of prime factors of N.
%    (integer,list) (+,?)

prime_factors(N,L) :- N > 0,  prime_factors(N,L,2).

% prime_factors(N,L,K) :- L is the list of prime factors of N. It is 
% known that N does not have any prime factors less than K.

prime_factors(1,[],_) :- !.
prime_factors(N,[F|L],F) :-                           % N is multiple of F
   R is N // F, N =:= R * F, !, prime_factors(R,L,F).
prime_factors(N,L,F) :- 
   next_factor(N,F,NF), prime_factors(N,L,NF).        % N is not multiple of F
   

% next_factor(N,F,NF) :- when calculating the prime factors of N
%    and if F does not divide N then NF is the next larger candidate to
%    be a factor of N.

next_factor(_,2,3) :- !.
next_factor(N,F,NF) :- F * F < N, !, NF is F + 2.
next_factor(N,_,N).                                 % F > sqrt(N)


last([A],A).
last([_|T],N):-last(T,N).

bigger(I,N) :- prime_factors(I,L) , last(L,N).

sm(_,1,1).% opoiodipote B kai na paro o ena einai smooth!!!!
sm(B,I,1) :- bigger(I,L) , L =< B.  % einai B-smooth o I
sm(B,I,0) :- bigger(I,L) , L > B.     % den einai B-smooth o I

smooth(B,I,J,N) :- I = J , X = I , sm(B,X,N).
smooth(B,I,J,N) :- I =< J , sm(B,I,N1) , Y is I+1 , smooth(B,Y,J,N2) , N is N1+N2.