/* 
Tyler Spring
1/23/23
Project 1
This is the scanner.l file. Here the reserved words, tokens, main method, and first line method are.
*/

%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap
	//comment2 and id are modified.
ws		[ \t\r]+
comment		\-\-.*\n
comment2 	\\\\.*\n
line		[\n]
id		[_A-Za-z][A-Za-z0-9]*
digit		[0-9]
int		{digit}+
punc		[\(\),:;]
%%

{ws}		{ ECHO; }
{comment2}	{ ECHO; nextLine();}
{comment}	{ ECHO; nextLine();}
{line}		{ ECHO; nextLine();}
	/*Relop, addop, mulopp, expop, remop operators*/
"="		{ ECHO; return(RELOP); }
"/="		{ ECHO; return(RELOP); }
">"		{ ECHO; return(RELOP); }
">="		{ ECHO; return(RELOP); }
"<="		{ ECHO; return(RELOP); }
"<"		{ ECHO; return(RELOP); }
"+"		{ ECHO; return(ADDOP); }
"-"		{ ECHO; return(ADDOP); }
"*"		{ ECHO; return(MULOP); }
"/"		{ ECHO; return(MULOP); }
"**"		{ ECHO; return(EXPOP); }
rem		{ ECHO; return(REMOP); }
	/*Arrow*/
"=>"		{ ECHO; return(ARROW); }
or		{ ECHO; return(OROP);  }
not 		{ ECHO; return(NOTOP); }
    /* Here are the reserved words*/
case		{ ECHO; return(CASE);  }
else 		{ ECHO; return(ELSE);  }
endcase		{ ECHO; return(ENDCASE); }
endif		{ ECHO; return(ENDIF);  }
if		{ ECHO; return(IF);  }
others 		{ ECHO; return(OTHERS) ;}
real 		{ ECHO; return(REAL)  ;}
then		{ ECHO; return(THEN) ;}
when 		{ ECHO; return(WHEN) ;}
	/*real literals and bool literals*/
45685.654E+456 { ECHO; return(REAL_LITERAL);}
true		{ ECHO; return(BOOL_LITERAL);}
false		{ ECHO; return(BOOL_LITERAL);}
begin		{ ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
end		{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
reduce		{ ECHO; return REDUCE; }
returns		{ ECHO; return(RETURNS); }
and		{ ECHO; return(ANDOP); }
{id}		{ ECHO; return(IDENTIFIER);}
{int}		{ ECHO; return(INT_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }
%%
//Main method. Contains first line.
int main()
{
	firstLine();
	
	FILE *file = fopen("lexemes.txt", "wa"); 
	int token = yylex();
	while (token)
	{
		fprintf(file, "%d %s\n", token, yytext);
		token = yylex();
	}
	lastLine();
	fclose(file);
	return 0;
}
