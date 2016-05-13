Nonterminals
Query
Statement
SelectStmt
SelectList
SelectElem
QualifiedName
ColumnLabel
TableExpr
FromClause
TableList
TableElem
TableName
TableLabel.

Terminals
tk_select tk_from tk_as tk_where tk_and tk_or tk_in tk_not tk_asterisk
tk_comma tk_dot tk_lparen tk_rparen tk_semicolon tk_comparator tk_string
tk_var tk_integer.

Rootsymbol Query.

Query -> Statement : build_ast_node('Query', #{'statement' => '$1'}).

%% TODO: add support for other statement types
Statement -> SelectStmt : '$1'.

SelectStmt -> tk_select SelectList TableExpr:
  build_ast_node('SelectStmt', #{'exprs' => '$2', 'table_expr' => '$3'}).

SelectList -> SelectElem : ['$1'].
SelectList -> SelectElem tk_comma SelectList : ['$1'|'$3'].

SelectElem -> tk_asterisk : build_ast_node('SelectElem', #{'expr' => extract_token('$1')}).
SelectElem -> QualifiedName : build_ast_node('SelectElem', #{'expr' => '$1'}).
SelectElem -> QualifiedName tk_as ColumnLabel : build_ast_node('SelectElem', #{'expr' => '$1', 'as' => '$3'}).

QualifiedName -> tk_var : build_ast_node('QualifiedName', #{'column' => extract_val('$1')}).
QualifiedName -> TableLabel tk_dot tk_var : build_ast_node('QualifiedName', #{'table' => extract_val('$3'), 'column' => '$1'}).

ColumnLabel -> tk_var : extract_val('$1').
ColumnLabel -> tk_string : extract_val('$1').

TableExpr-> FromClause : build_ast_node('TableExpr', #{'from' => '$1'}).

FromClause -> tk_from TableList : build_ast_node('FromClause', #{'exprs' => '$2'}).

TableList -> TableElem : ['$1'].
TableList -> TableElem tk_comma TableList : ['$1'|'$3'].

TableElem -> TableName : build_ast_node('TableElem', #{'expr' => '$1'}).
TableElem -> TableName tk_as TableLabel : build_ast_node('TableElem', #{'expr' => '$1', 'as' => '$3'}).

TableName -> tk_var : extract_val('$1').

TableLabel -> tk_var : extract_val('$1').
TableLabel -> tk_string : extract_val('$1').

Erlang code.

extract_token({Tok, _}) -> Tok.
extract_val({_, _, Val}) -> Val.

build_ast_node(Type, Node) -> Node#{kind => Type, loc => #{start => 0}}.

