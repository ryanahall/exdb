Definitions.
L = [a-zA-Z]
D = [0-9]
WS = [\s\t\n\r]
C = (<|<=|=|>=|>)

Rules.

select : {token,{set,TokenLine,list_to_atom(TokenChars)}}.
from   : {token,{set,TokenLine,list_to_atom(TokenChars)}}.
as     : {token,{set,TokenLine,list_to_atom(TokenChars)}}.
where  : {token,{set,TokenLine,list_to_atom(TokenChars)}}.
and    : {token,{set,TokenLine,list_to_atom(TokenChars)}}.
or     : {token,{set,TokenLine,list_to_atom(TokenChars)}}.
in     : {token,{set,TokenLine,list_to_atom(TokenChars)}}.
not    : {token,{set,TokenLine,list_to_atom(TokenChars)}}.
{C}    : {token,{comparator,TokenLine,list_to_atom(TokenChars)}}.
'{L}+' : S = strip(TokenChars,TokenLen),
         {token,{string,TokenLine,S}}.
{L}+   : {token,{var,TokenLine,list_to_atom(TokenChars)}}.
{D}+   : {token,{integer,TokenLine,list_to_integer(TokenChars)}}.
[(),]  : {token,{list_to_atom(TokenChars),TokenLine}}.
{WS}+  : skip_token.


Erlang code.

atom(TokenChars) -> list_to_atom(TokenChars).

strip(TokenChars,TokenLen) ->
  lists:sublist(TokenChars, 2, TokenLen - 2).

