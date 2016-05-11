Nonterminals
query
statement
select_statement
select_list
select_sublist
value_expression
table_expression
from_clause
table_reference
table_name
where_clause
search_condition
boolean_term
boolean_factor.

Terminals
select_tok
from_tok
as_tok
where_tok
and_tok
or_tok
in_tok
not_tok
wildcard_tok
comma_tok
lparen_tok
rparen_tok
comparator
string
var
integer.

Rootsymbol query.

query -> statement.

statement -> select_statement : '$1'.

select_statement -> select_tok select_list from_tok from_list.
select_statement -> select_tok select_list from_tok from_list where_clause.

select_list -> select_sublist comma_tok select_list : {cons, '$1', '$3'}.
select_list -> select_sublist : {cons, '$1', nil}.
select_list -> wildcard_tok : '$1'.

select_sublist -> column_identifier comma_tok select_sublist : {cons, '$1', '$3'}.
select_sublist -> column_identifier : {cons, '$1', nil}.

