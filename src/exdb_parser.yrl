Nonterminals
query
statement
select_statement
select_list
column_ref
table_expression
from_clause
table_list
table_ref
table
where_clause
search_condition
boolean_term
boolean_factor
alias_clause.

Terminals
tk_select
tk_from
tk_as
tk_where
tk_and
tk_or
tk_in
tk_not
tk_asterisk
tk_comma
tk_dot
tk_lparen
tk_rparen
tk_comparator
tk_string
tk_var
tk_integer.

Rootsymbol query.

query -> statement.

statement -> select_statement : '$1'.

select_statement -> tk_select select_list table_expression. 

select_list -> tk_asterisk : '$1'.
select_list -> column_ref : ['$1'].
select_list -> column_ref tk_comma select_list : ['$1'|'$2'].

column_ref -> tk_var : '$1'.

table_expression -> from_clause.
table_expression -> from_clause where_clause.

from_clause -> tk_from table_list.

table_list -> table_ref tk_comma table_list.
table_list -> table_ref.

table_ref -> table.
table_ref -> table alias_clause.

table -> tk_var.

where_clause -> tk_where search_condition.


