import java_cup.runtime.*;
import java.io.IOException;

// Jlex directives
%%

%cup
%public

%class Lexer

%type java_cup.runtime.Symbol

%eofval {
	return new Symbol(sym.EOF);
%eofval}

%eofclose false

%char
%column
%line

%{
	public int getChar() {
		return yychar + 1;
	}
	
	public int getColumn() {
		return yycolumn + 1;
	}

	public int getLine() {
		return yyline + 1;
	}
	
	public String getText() {
		return yytext();
	}
%}

nl = [\n\r]

cc = ([\b\f]|{nl})

ws = {cc}|[\t ]

alpha = [a-zA-Z_"$""#""?""@""~"]

comment = [^\r\n]

nl = [\n\r]|\r\n

alphanum = {alpha}|[0-9]
fnum  = (-[0-9]+\.[0-9]+)|([0-9]+\.[0-9]+)

%%

<YYINITIAL>	{ws}	{/* ignore whitespace */}

/* Arithmetic operators */
<YYINITIAL>	"+"	{return new Symbol(sym.PLUS);}
<YYINITIAL>	"-"	{return new Symbol(sym.MINUS);}
<YYINITIAL>	"*"	{return new Symbol(sym.MUL);}
<YYINITIAL>	"/"	{return new Symbol(sym.DIV);}
<YYINITIAL>	"%"	{return new Symbol(sym.MOD);}

/* Bitwise operators */
<YYINITIAL> 	"&"	{return new Symbol(sym.BITAND);}
<YYINITIAL>	"|"	{return new Symbol(sym.BITOR);}
<YYINITIAL>	"~"	{return new Symbol(sym.BITNOT);}

/* Relational operators */
<YYINITIAL>	"="	{return new Symbol(sym.EQUAL);}
<YYINITIAL>	">"	{return new Symbol(sym.GREATER);}
<YYINITIAL>	"<"	{return new Symbol(sym.LESS);}
<YYINITIAL>	"<="	{return new Symbol(sym.LESSEQ);}
<YYINITIAL>	">="	{return new Symbol(sym.GREATEREQ);}
<YYINITIAL>	"!="	{return new Symbol(sym.NOTEQ);}

/* Logical operators */
<YYINITIAL>	"and"	{return new Symbol(sym.AND);}
<YYINITIAL>	"or"	{return new Symbol(sym.OR);}
<YYINITIAL>	"not"	{return new Symbol(sym.NOT);}

/* List concatenation */
<YYINITIAL>	"@"	{return new Symbol(sym.CONCAT);}

<YYINITIAL>	":="	{return new Symbol(sym.ASSIGN);}

/* Keywords */
<YYINITIAL>	"proc"		{return new Symbol(sym.PROC);}
<YYINITIAL>	"call"		{return new Symbol(sym.CALL);}
<YYINITIAL>	"lazy"		{return new Symbol(sym.LAZY);}
<YYINITIAL>	"let"		{return new Symbol(sym.LET);}
<YYINITIAL>	"def"		{return new Symbol(sym.DEF);}
<YYINITIAL>	"if"		{return new Symbol(sym.IF);}
<YYINITIAL>	"case"		{return new Symbol(sym.CASE);}
<YYINITIAL>	"print"		{return new Symbol(sym.);}
<YYINITIAL>	"println"	{return new Symbol(sym.);}
<YYINITIAL>	"read"	{return new Symbol(sym.);}
<YYINITIAL>	"readint"	{return new Symbol(sym.);}

<YYINITIAL>     "//"    {comment}* {nl} { /* line comment */ }
<YYINITIAL>	"("	{return new Symbol(sym.LPAREN);}
<YYINITIAL>	")"	{return new Symbol(sym.RPAREN);}



