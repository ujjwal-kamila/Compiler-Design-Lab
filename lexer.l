%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%option noyywrap

/* Definitions */
KEYWORD     "int"|"float"|"char"|"if"|"else"|"while"|"return"|"for"|"switch"|"case"|"break"
IDENTIFIER  [a-zA-Z_][a-zA-Z0-9_]*
NUMBER      [0-9]+
OPERATOR    "="|"+"|"-"|"*"|"/"
STRING      \"[^\"]*\"

%%

{KEYWORD}     { printf("keyword: %s\n", yytext); }
{IDENTIFIER}  { printf("identifier: %s\n", yytext); }
{NUMBER}      { printf("number: %s\n", yytext); }
{OPERATOR}    { printf("operator: %s\n", yytext); }
{STRING}      { printf("string: %s\n", yytext); }
[ \t\n]+      ; /* Ignore whitespace */
.             { printf("symbol: %s\n", yytext); }

%%

int main(int argc, char *argv[]) {
    FILE *inputFile;

    if (argc > 1) {
        inputFile = fopen(argv[1], "r");
        if (!inputFile) {
            perror("Error opening file");
            return 1;
        }
        yyin = inputFile;
    } else {
        printf("Enter C code (CTRL+D to stop):\n");
    }

    yylex();

    if (argc > 1) {
        fclose(inputFile);
    }

    return 0;
}
