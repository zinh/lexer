%token NAME NUMBER
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%
statement: NAME '=' expression
         | expression { printf("= %d\n", $1); }
         ;
expression: expression '+' NUMBER { $$ = $1 + $3; }
          | expression '-' NUMBER { $$ = $1 - $3; }
          | expression '*' NUMBER { $$ = $1 * $3; }
          | expression '/' NUMBER
          { 
          if ($3 == 0)
            yyerror("Division by zero");
          else
            $$ = $1 / $3; 
          }
          | '-' expression %prec UMINUS { $$ = -$2; }
          | '(' expression ')' { $$ = $2; }
          | NUMBER { $$ = $1; }
          ;
%%
