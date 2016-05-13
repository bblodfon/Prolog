:- begin_tests(examples).
consult(examples).

test(len):- len([a,b],2).
test(len):- len([],0).

test(binomial):- binomial(100,1,100).
test(binomial):- binomial(100,0,1).
test(binomial):- binomial(4,22,0).
test(binomial):- binomial(4,-22,0).
test(binomial):- binomial(4,4,1).
test(binomial):- binomial(100,55,61448471214136179596720592960).

:- end_tests(examples).