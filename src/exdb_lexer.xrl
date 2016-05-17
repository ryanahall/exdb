Definitions.
L = [a-zA-Z_]
D = [0-9]
WS = [\s\t\n\r]
C = (<|<=|=|>=|>)
P = [*,.();]
% Reserved words
ReservedWord = select|from|as|where|and|or|in|not

Rules.

{ReservedWord} : {token,{list_to_atom(TokenChars),TokenLine}}.
{P}            : {token,{list_to_atom(TokenChars),TokenLine}}.
{C}            : {token,{tk_comparator,TokenLine,list_to_atom(TokenChars)}}.
"{L}+"         : S = strip(TokenChars,TokenLen),
                 {token,{tk_string,TokenLine,S}}.
'{L}+'         : S = strip(TokenChars,TokenLen),
                 {token,{tk_string,TokenLine,S}}.
{L}+           : {token,{tk_var,TokenLine,list_to_atom(TokenChars)}}.
{D}+           : {token,{tk_integer,TokenLine,list_to_integer(TokenChars)}}.
{WS}+          : skip_token.


Erlang code.

strip(TokenChars,TokenLen) ->
  lists:sublist(TokenChars, 2, TokenLen - 2).

