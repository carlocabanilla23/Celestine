program         -> statement_list

statement_list  -> statement
                 | statement statement_list

statement       -> assignment_statement
                 | if_statement
                 | while_statement
                 | print_statement

assignment_statement -> identifier '=' expression ';'

if_statement   -> 'if' '(' condition ')' '{' statement_list '}' 
										['else' '{' statement_list '}']

while_statement -> 'while' '(' condition ')' '{' statement_list '}'

print_statement -> 'print' '(' expression ')' ';'

condition       -> expression comparison_operator expression

expression      -> term
                 | expression '+' term
                 | expression '-' term

term            -> factor
                 | term '*' factor
                 | term '/' factor

factor          -> identifier
                 | number
                 | '(' expression ')'

identifier      -> letter [letter | digit | '_']*

number          -> digit+
comparison_operator -> '==' | '!=' | '<' | '<=' | '>' | '>='
letter          -> 'a' | 'b' | ... | 'z' | 'A' | 'B' | ... | 'Z'
digit           -> '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'