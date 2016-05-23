Nonterminals
DataType
ColumnDefList
ColumnDefs
ColumnDef
Operator
Comparator
Query
Statement
SelectStmt
SelectList
SelectElem
CreateTableStmt
ColumnDef
QualifiedName
ColumnLabel
TableExpr
FromClause
TableList
TableElem
TableName
TableLabel.

Terminals
select
create
table
from
as
where
and_
or_
not_
in
null
text
integer
real
blob
identifier
intnumber
string
plus
minus
asterisk
solidus
lt
lte
eq
gte
gt
ne
lparen
rparen
comma
semicolon
dot.

Rootsymbol Query.
Endsymbol '$end'.

Operator -> plus : '$1'.
Operator -> minus : '$1'.
Operator -> asterisk : '$1'.
Operator -> solidus : '$1'.

Comparator -> lt : '$1'.
Comparator -> lte : '$1'.
Comparator -> eq : '$1'.
Comparator -> gte : '$1'.
Comparator -> gt : '$1'.

DataType -> text : '$1'.
DataType -> integer : '$1'.
DataType -> real : '$1'.
DataType -> blob : '$1'.

Query -> Statement : build_ast_node('Query', #{'statement' => '$1'}).

%% TODO: add support for other statement types
Statement -> SelectStmt : '$1'.

%% Create table statement
CreateTableStmt -> create table TableName ColumnDefList :
  build_ast_node('CreateTableStmt', #{'table' => '$3', 'column_defs' => '$4'}).

ColumnDefList -> lparen ColumnDefs rparen : '$2'.
ColumnDefList -> ColumnDefs : '$1'

ColumnDefs -> ColumnDef : ['$1'].
ColumnDefs -> ColumnDef comma ColumnDefs : ['$1'|'$3'].

ColumnDef -> identifier DataType : build_ast_node('ColumnDef', #{'name' => '$1', 'type' => '$2'}).

%% Select statement
SelectStmt -> select SelectList TableExpr:
  build_ast_node('SelectStmt', #{'exprs' => '$2', 'table_expr' => '$3'}).

SelectList -> SelectElem : ['$1'].
SelectList -> SelectElem comma SelectList : ['$1'|'$3'].

SelectElem -> asterisk : build_ast_node('SelectElem', #{'expr' => extract_token('$1')}).
SelectElem -> QualifiedName : build_ast_node('SelectElem', #{'expr' => '$1'}).
SelectElem -> QualifiedName as ColumnLabel : build_ast_node('SelectElem', #{'expr' => '$1', 'as' => '$3'}).

QualifiedName -> identifier : build_ast_node('QualifiedName', #{'column' => extract_val('$1')}).
QualifiedName -> TableLabel dot identifier : build_ast_node('QualifiedName', #{'table' => extract_val('$3'), 'column' => '$1'}).

ColumnLabel -> identifier : extract_val('$1').
ColumnLabel -> string : extract_val('$1').

TableExpr-> FromClause : build_ast_node('TableExpr', #{'from' => '$1'}).

FromClause -> from TableList : build_ast_node('FromClause', #{'exprs' => '$2'}).

TableList -> TableElem : ['$1'].
TableList -> TableElem comma TableList : ['$1'|'$3'].

TableElem -> TableName : build_ast_node('TableElem', #{'expr' => '$1'}).
TableElem -> TableName as TableLabel : build_ast_node('TableElem', #{'expr' => '$1', 'as' => '$3'}).

TableName -> identifier : extract_val('$1').

TableLabel -> identifier : extract_val('$1').
TableLabel -> string : extract_val('$1').

Erlang code.

extract_token({Tok, _}) -> Tok.
extract_val({_, Val}) -> Val.

build_ast_node(Type, Node) -> Node#{kind => Type, loc => #{start => 0}}.

