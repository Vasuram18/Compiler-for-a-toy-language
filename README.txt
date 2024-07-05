
RUN PROGRAMS:
	
	Download and unzip the file 
	There will be 5 files  cucu.l, cucu.y, Sample1.cu, Sample2.cu and README.txt
	Run this commands in terminal
	1. flex cucu.l
        2. bison -d cucu.y
        3. g++ cucu.tab.c lex.yy.c -lfl -o cucu
        4. ./cucu
        
uncomment the line 156 in cucu.l for the error case and 


cucu.l
	contains the lex code
cucu.y
	contains the yacc code

Sample1.cu
    	contains correct syntax
    	
Sample2.cu
        contains syntax error code

It will generate two files:	
1.Lexer.txt

     This file contains the output obtained by the cucu.l file, which are all the tokens in the code.

2.Parser.txt

     This file stores the output obtained by the cucu.y file, which is parsed by the cucu.y file and printed the steps and different types of statements in it.
    

        

