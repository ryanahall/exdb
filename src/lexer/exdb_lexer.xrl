Definitions.
L = [a-zA-Z_]
D = [0-9]
WS = [\s\t\n\r]
C = (<|<=|=|>=|>)

Rules.

select : {token,{select,TokenLine,list_to_atom(TokenChars)}}.
from   : {token,{from,TokenLine,list_to_atom(TokenChars)}}.
as     : {token,{as,TokenLine,list_to_atom(TokenChars)}}.
where  : {token,{where,TokenLine,list_to_atom(TokenChars)}}.
and    : {token,{and,TokenLine,list_to_atom(TokenChars)}}.
or     : {token,{or,TokenLine,list_to_atom(TokenChars)}}.
in     : {token,{in,TokenLine,list_to_atom(TokenChars)}}.
not    : {token,{not,TokenLine,list_to_atom(TokenChars)}}.
*      : {token,{wildcard,TokenLine,list_to_atom(TokenChars)}}.
{C}    : {token,{comparator,TokenLine,list_to_atom(TokenChars)}}.
'{L}+' : S = strip(TokenChars,TokenLen),
         {token,{string,TokenLine,S}}.
{L}+   : {token,{var,TokenLine,list_to_atom(TokenChars)}}.
{D}+   : {token,{integer,TokenLine,list_to_integer(TokenChars)}}.
[(),]  : {token,{list_to_atom(TokenChars),TokenLine}}.
{WS}+  : skip_token.


Erlang code.

strip(TokenChars,TokenLen) ->
  lists:sublist(TokenChars, 2, TokenLen - 2).

