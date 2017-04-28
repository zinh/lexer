%token NAME NUMBER
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%
statement: NAME '=' expr
         | expr { printf("= %d\n", $1); }
         ;
expr: expr '+' mulexp { $$ = $1 + $3; }
    | expr '-' mulexp { $$ = $1 - $3; }
    | mulexp
    ;
mulexp: mulexp '*' primary { $$ = $1 * $3; }
      | mulexp '/' primary { $$ = $1 / $3; }
      | primary
      ;
primary: '(' expr ')' { $$ = $2; }
       | '-' primary { $$ = -$2; }
       | NUMBER
       ;
%%
