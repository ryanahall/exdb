default: compile

lexer:
	erl -noshell -eval 'leex:file("src/lexer/exdb_lexer.xrl", [{includefile, "src/lexer/leexinc.hrl"}, {scannerfile, "src/lexer/exdb_lexer.erl"}])' -s erlang halt

test:
	mix test

compile:
	mix compile

clean:
	rm -rf _build

