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
table_name
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

select_statement -> tk_select select_list table_expression : {'$1', '$2', '$3'}.

select_list -> tk_asterisk : '$1'.
select_list -> column_ref : ['$1'].
select_list -> column_ref tk_comma select_list : ['$1'|'$2'].

column_ref -> tk_var : extract_val('$1').

table_expression -> from_clause : {'$1', nil}.
table_expression -> from_clause where_clause : {'$1', '$2'}.

from_clause -> tk_from table_list : '$2'.

table_list -> table_ref : ['$1'].
table_list -> table_ref tk_comma table_list : ['$1'|'$2'].

table_ref -> table_name : {'$1', nil}.
table_ref -> table_name alias_clause : {'$1', '$2'}.

table_name -> tk_var : extract_val('$1'). 

where_clause -> tk_where search_condition : '$2'.

search_condition -> search_condition tk_or search_condition : {'$2', '$1', '$3'}.
search_condition -> search_condition tk_and search_condition : {'$2', '$1', '$3'}.
search_condition -> tk_not search_condition :  {'$1', '$2', nil}.
search_condition -> tk_lparen search_condition tk_rparen : '$2'.
search_condition -> predicate : '$1'.

predicate -> comparison_predicate : '$1'.

comparison_predicate -> column_ref tk_comparator scalar_exp : {'$2', '$1', '$3'}.

alias_clause -> tk_as tk_var : extract_val('$2').

Erlang code.

extract_val(Token) ->
  element(3, Token).

