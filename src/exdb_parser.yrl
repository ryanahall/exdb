Nonterminals
query
statement
select_statement
select_list
select_elem
qualified_name
column_label
table_expression
from_clause
table_list
table_elem
table_name
table_label.

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
tk_semicolon
tk_comparator
tk_string
tk_var
tk_integer.

Rootsymbol query.

query -> statement : '$1'.

%% TODO: add support for other statement types
statement -> select_statement : '$1'.

select_statement -> tk_select select_list table_expression : {'$1', '$2', '$3'}.

select_list -> select_elem : ['$1'].
select_list -> select_elem tk_comma select_list : ['$1'|'$3'].

select_elem -> tk_asterisk : '$1'.
select_elem -> qualified_name : {'$1'}.
select_elem -> qualified_name tk_as column_label : {'$1', '$3'}.

qualified_name -> tk_var : {extract_val('$1')}.
qualified_name -> table_label tk_dot tk_var : {extract_val('$3'), '$1'}.

column_label -> tk_var : extract_val('$1').
column_label -> tk_string : extract_val('$1').

table_expression -> from_clause : '$1'.

from_clause -> tk_from table_list : {'$2'}.

table_list -> table_elem : ['$1'].
table_list -> table_elem tk_comma table_list : ['$1'|'$3'].

table_elem -> table_name : {'$1'}.
table_elem -> table_name tk_as table_label : {'$1', '$3'}.

table_name -> tk_var : extract_val('$1').

table_label -> tk_var : extract_val('$1').
table_label -> tk_string : extract_val('$1').

Erlang code.

extract_token({Tok, _}) -> Tok.

extract_val({_, _, Val}) -> Val.

