default: compile

compile:
	erl -noshell -eval 'leex:file("lib/lexer/lexer.xrl")' -s erlang halt
	mix compile

clean:
	rm -rf _build
	rm lib/lexer/lexer.erl


