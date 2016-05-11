Definitions.
L = [a-zA-Z_]
D = [0-9]
WS = [\s\t\n\r]
C = (<|<=|=|>=|>)

Rules.

select : {token,{select_tok,TokenLine}}.
from   : {token,{from_tok,TokenLine}}.
as     : {token,{alias_tok,TokenLine}}.
where  : {token,{filter_tok,TokenLine}}.
and    : {token,{and_tok,TokenLine}}.
or     : {token,{or_tok,TokenLine}}.
in     : {token,{in_tok,TokenLine}}.
not    : {token,{not_tok,TokenLine}}.
*      : {token,{wildcard_tok,TokenLine}}.
,      : {token,{comma_tok,TokenLine}}.
(      : {token,{lparen_tok,TokenLine}}.
)      : {token,{rparen_tok,TokenLine}}.
{C}    : {token,{comparator,TokenLine,list_to_atom(TokenChars)}}.
"{L}+" : S = strip(TokenChars,TokenLen),
         {token,{string,TokenLine,S}}.
'{L}+' : S = strip(TokenChars,TokenLen),
         {token,{string,TokenLine,S}}.
{L}+   : {token,{var,TokenLine,list_to_atom(TokenChars)}}.
{D}+   : {token,{integer,TokenLine,list_to_integer(TokenChars)}}.
{WS}+  : skip_token.


Erlang code.

strip(TokenChars,TokenLen) ->
  lists:sublist(TokenChars, 2, TokenLen - 2).

