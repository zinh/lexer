%{
  double vbltable[26];
%}

%union {
  double dval;
  int vblno;
};

%token <vblno> NAME
%token <dval> NUMBER
%nonassoc UMINUS

%type <dval> expr,mulexp,primary
%%
statement_list: statement '\n'
              | statement_list statement '\n'
              ;
statement: NAME '=' expr { vbltable[$1] = $3; }
         | expr { printf("= %g\n", $1); }
         ;
expr: expr '+' mulexp { $$ = $1 + $3; }
    | expr '-' mulexp { $$ = $1 - $3; }
    | mulexp
    ;
mulexp: mulexp '*' primary { $$ = $1 * $3; }
      | mulexp '/' primary 
        { if ($3 == 0.0) 
            yyerror("divide by zero");
          else
            $$ = $1 / $3;
        }
      | primary
      ;
primary: '(' expr ')' { $$ = $2; }
       | '-' primary { $$ = -$2; }
       | NUMBER
       | NAME { $$ = vbltable[$1]; }
       ;
%%
