Nonterminals
Query
Statement
SelectStatement
SelectList
SelectElem
QualifiedName
ColumnLabel
TableExpression
FromClause
TableList
TableElem
TableName
TableLabel.

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

Rootsymbol Query.

Query -> Statement : '$1'.

%% TODO: add support for other statement types
Statement -> SelectStatement : '$1'.

SelectStatement -> tk_select SelectList TableExpression : build_ast_node('SelectStatement', #{'select_list' => '$2', 'table_expression' => '$3'}).

SelectList -> SelectElem : ['$1'].
SelectList -> SelectElem tk_comma SelectList : ['$1'|'$3'].

SelectElem -> tk_asterisk : '$1'.
SelectElem -> QualifiedName : {'$1'}.
SelectElem -> QualifiedName tk_as ColumnLabel : {'$1', '$3'}.

QualifiedName -> tk_var : {extract_val('$1')}.
QualifiedName -> TableLabel tk_dot tk_var : {extract_val('$3'), '$1'}.

ColumnLabel -> tk_var : extract_val('$1').
ColumnLabel -> tk_string : extract_val('$1').

TableExpression -> FromClause : '$1'.

FromClause -> tk_from TableList : {'$2'}.

TableList -> TableElem : ['$1'].
TableList -> TableElem tk_comma TableList : ['$1'|'$3'].

TableElem -> TableName : {'$1'}.
TableElem -> TableName tk_as TableLabel : {'$1', '$3'}.

TableName -> tk_var : extract_val('$1').

TableLabel -> tk_var : extract_val('$1').
TableLabel -> tk_string : extract_val('$1').

Erlang code.

extract_token({Tok, _}) -> Tok.
extract_val({_, _, Val}) -> Val.

build_ast_node(Type, Node) -> Node#{kind => Type, loc => #{start => 0}}.

