%Run with: expert.
%It finds the fault of the engine in a B747 aeroplane with regards to the specs
%which were provided
  
expert:-format("MAIN MENU of expert system"),nl,
        format("1)Oil consumption is high"),nl,
        format("2)Oil quantity indicator is malfunctioning"),nl,
        format("3)Oil pressure is abnormal or indicator is malfunctioning"),nl,
		format("4)Oil filter bypass light is illuminated"),nl,
		format("5)Oil temperature is abnormal or indicator is malfunctioning"),nl,
		format("6)Breather temperature is high"),nl,
		format("7)Engine was shutdown in flight"),nl,
		format("8)Unlisted engine oil fault"),nl,
		format("give the number of the problem which occured during the flight"),nl,read(Problem),
		format("give the number of the engine in which the problem occured (0,1,2,3 or 4)"),nl,read(Engine),
		eidos(Problem,Code),format("the code of this problem is: "),format(Code),format(Engine).
		
eidos(1,Code):-format("check other oil system indicators: they are normal or abnormal?"),nl,read(X),
               (X = normal -> Code = code_79_01_BD_0 ; X = abnormal -> Code = code_79_01_BE_0).
eidos(2,Code):-format("the oil indicator shows(choose number):"),nl,format("1)inop reads zero or off scale high"),nl,
               format("2)reads off"),nl,format("3)reads high or low or it fluctuates"),nl,read(X),(X = 1 -> Code = code_79_01_XD_0 ;
               X = 2 -> Code = code_79_01_XE_0 ; X = 3 -> Code = code_79_01_XF_0).
eidos(3,Code):-format("the indicator of the oil pressure is"),nl,format("1)abnormal which means high low or fluctuating"),nl,
               format("2)inop read low with no low press ,light illum, fluctuates"),nl,format("3)light illum with all other indications normal"),
               nl,read(X),(X = 1 -> format("if you change the thrust setting the oil press follows? yes or no?"),nl,read(Y),eidos3(Y,Code) ; 
               X = 2 -> Code = code_79_01_XG_0 ; X = 3 -> Code = code_79_01_XH_0). 
eidos(4,Code):-format("with thrust level reduced light remained illum or extin?"),nl,read(X),(X = illum -> eidos4(illum,Code) ; X = extin ->
               Code = code_79_01_XK_0).
eidos(5,Code):-format("engine oil temp is abnormal(1) or the indicator is malfunctioning(2)?"),nl,format("(choose the number)"),nl,read(X),
               (X = 1 -> format("the temp is lower than the other engines or higher?"),nl,read(Y),eidos5_1(Y,Code); X = 2 -> 
			   format("the indicator is inop(1) or fluctuates(2)?---choose number"),nl,read(Y),eidos5_2(Y,Code)).			   
eidos(6,Code):-format("the temp of the Breather is less than 210 degrees Celcius or higher?"),nl,read(X),eidos6(X,Code).  	
%eidos(7,Code):-
eidos(8,code_79_01_00_0). 
	
eidos3(yes,code_79_01_CE_0).
eidos3(no,code_79_01_CD_0).			   
eidos4(illum,Code):-format("with engine shutdown light remained illum or extin?"),nl,read(R),(R = illum -> Code = code_79_01_XX_0 ; 
                    R = extin -> Code = code_79_01_XJ_0).
eidos5_1(lower,Code):-format("if you retard the thrust level the temp increases to equal others(1)"),nl,
                      format("or it remains low(2)?---choose number"),nl,read(X),
					  (X = 1 -> Code = code_79_01_DD_0 ; X = 2 -> Code = code_79_01_DE_0).
eidos5_1(higher,code_79_01_DF_0).
eidos5_2(1,code_79_01_XL_0).
eidos5_2(2,code_79_01_XM_0).
eidos6(less,Code):-format("all the other oil systems indications are normal or at least one is abnormal?"),nl,read(X),(X = normal ->
                   Code = code_79_01_FD_0 ; X = abnormal -> Code = code_79_01_FE_0).
eidos6(higher,Code):-format("all the other oil systems indications are normal or at least one is abnormal?"),nl,read(X),(X = normal ->
                   Code = code_79_01_FF_0 ; X = abnormal -> Code = code_79_01_FG_0).



		
		