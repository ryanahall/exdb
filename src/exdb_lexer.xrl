Definitions.
L = [a-zA-Z_]
D = [0-9]
WS = [\s\t\n\r]
C = (<|<=|=|>=|>)

Rules.

select : {token,{select,TokenLine}}.
from   : {token,{from,TokenLine}}.
as     : {token,{alias,TokenLine}}.
where  : {token,{filter,TokenLine}}.
and    : {token,{intersection,TokenLine}}.
or     : {token,{union,TokenLine}}.
in     : {token,{set,TokenLine}}.
not    : {token,{difference,TokenLine}}.
*      : {token,{wildcard,TokenLine}}.
,      : {token,{comma,TokenLine}}.
(      : {token,{lparen,TokenLine}}.
)      : {token,{rparen,TokenLine}}.
{C}    : {token,{comparator,TokenLine,list_to_atom(TokenChars)}}.
'{L}+' : S = strip(TokenChars,TokenLen),
         {token,{string,TokenLine,S}}.
{L}+   : {token,{var,TokenLine,list_to_atom(TokenChars)}}.
{D}+   : {token,{integer,TokenLine,list_to_integer(TokenChars)}}.
{WS}+  : skip_token.


Erlang code.

atom(TokenChars) -> list_to_atom(TokenChars).

strip(TokenChars,TokenLen) ->
  lists:sublist(TokenChars, 2, TokenLen - 2).

