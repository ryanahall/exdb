Definitions.
L = [a-zA-Z_]
D = [0-9]
WS = [\s\t\n\r]
C = (<|<=|=|>=|>)

Rules.

select : {token,{tk_select,TokenLine}}.
from   : {token,{tk_from,TokenLine}}.
as     : {token,{tk_as,TokenLine}}.
where  : {token,{tk_where,TokenLine}}.
and    : {token,{tk_and,TokenLine}}.
or     : {token,{tk_or,TokenLine}}.
in     : {token,{tk_in,TokenLine}}.
not    : {token,{tk_not,TokenLine}}.
*      : {token,{tk_asterisk,TokenLine}}.
,      : {token,{tk_comma,TokenLine}}.
.      : {token,{tk_dot,TokenLine}}.
(      : {token,{tk_lparen,TokenLine}}.
)      : {token,{tk_rparen,TokenLine}}.
{C}    : {token,{tk_comparator,TokenLine,list_to_atom(TokenChars)}}.
"{L}+" : S = strip(TokenChars,TokenLen),
         {token,{tk_string,TokenLine,S}}.
'{L}+' : S = strip(TokenChars,TokenLen),
         {token,{tk_string,TokenLine,S}}.
{L}+   : {token,{tk_var,TokenLine,list_to_atom(TokenChars)}}.
{D}+   : {token,{tk_integer,TokenLine,list_to_integer(TokenChars)}}.
{WS}+  : skip_token.


Erlang code.

strip(TokenChars,TokenLen) ->
  lists:sublist(TokenChars, 2, TokenLen - 2).

