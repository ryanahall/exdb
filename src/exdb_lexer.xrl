Definitions.

% Reserved words
SELECT = (S|s)(E|e)(L|l)(E|e)(C|c)(T|t)
FROM = (F|f)(R|r)(O|o)(M|m)
AS = (A|a)(S|s)
WHERE = (W|w)(H|h)(E|e)(R|r)(E|e)
AND = (A|a)(N|n)(D|d)
OR = (O|o)(R|r)
IN = (I|i)(N|n)
NOT = (N|n)(O|o)(T|t)
NULL = (N|n)(U|u)(L|l)(L|l)

% Identifiers
IDENTIFIER = ([a-zA-Z_][a-zA-Z0-9_]*)

% Numbers
INTNUMBER = (\-*[0-9]+)

% Operators
PLUS = (\+)
MINUS = (\-)
ASTERISK = (\*)
SOLIDUS = (/)

% Comparators
LT = (<)
LTE = (<=)
EQ = (=)
GTE = (>=)
GT = (>)
NE = (!=)

% Structure
LPAREN = \(
RPAREN = \)
COMMA = (,)
SEMICOLON = (\;)
DOT = (\.)

% Other
QUOTED = ("([^\"])*")|('([^\'])*')
WHITESPACE = ([\000-\s]*)

Rules.

{SELECT}     : {token, {select, list_to_binary(TokenChars)}}.
{FROM}       : {token, {from, list_to_binary(TokenChars)}}.
{AS}         : {token, {as, list_to_binary(TokenChars)}}.
{WHERE}      : {token, {where, list_to_binary(TokenChars)}}.
{AND}        : {token, {and_, list_to_binary(TokenChars)}}.
{OR}         : {token, {or_, list_to_binary(TokenChars)}}.
{IN}         : {token, {in, list_to_binary(TokenChars)}}.
{NOT}        : {token, {not_, list_to_binary(TokenChars)}}.
{NULL}       : {token, {null, list_to_binary(TokenChars)}}.

{IDENTIFIER} : {token, {identifier, list_to_atom(TokenChars)}}.
{INTUMBER}   : {token, {integer, list_to_integer(TokenChars)}}.
{QUOTED}     : {token, {string, strip(TokenChars, TokenLen)}}.

{PLUS}       : {token, {plus, list_to_binary(TokenChars)}}.
{MINUS}      : {token, {minus, list_to_binary(TokenChars)}}.
{ASTERISK}   : {token, {asterisk, list_to_binary(TokenChars)}}.
{SOLIDUS}    : {token, {solidus, list_to_binary(TokenChars)}}.

{LT}         : {token, {lt, list_to_binary(TokenChars)}}.
{LTE}        : {token, {lte, list_to_binary(TokenChars)}}.
{EQ}         : {token, {eq, list_to_binary(TokenChars)}}.
{GTE}        : {token, {gte, list_to_binary(TokenChars)}}.
{GT}         : {token, {gt, list_to_binary(TokenChars)}}.
{NE}         : {token, {ne, list_to_binary(TokenChars)}}.

{LPAREN}     : {token, {lparen, list_to_binary(TokenChars)}}.
{RPAREN}     : {token, {rparen, list_to_binary(TokenChars)}}.
{COMMA}      : {token, {comma, list_to_binary(TokenChars)}}.
{SEMICOLON}  : {token, {semicolon, list_to_binary(TokenChars)}}.
{DOT}        : {token, {dot, list_to_binary(TokenChars)}}.

{WHITESPACE} : skip_token.

\n           : {end_token, {'$end', TokenLine}}.

Erlang code.

strip(TokenChars,TokenLen) ->
  lists:sublist(TokenChars, 2, TokenLen - 2).

