package main

import "core:testing"

@(test)
my_test :: proc(t: ^testing.T) {
	res := []token {
		token{type = "LET", value = "let"},
		token{type = "IDENT", value = "y"},
		token{type = "ASSIGN", value = "="},
		token{type = "LPAREN", value = "("},
		token{type = "INT", value = "3"},
		token{type = "PLUS", value = "+"},
		token{type = "INT", value = "4"},
		token{type = "RPAREN", value = ")"},
		token{type = "ASTERISK", value = "*"},
		token{type = "INT", value = "2"},
	}

	tok, l := lexer("let y = (3 + 4) * 2")
	defer free(l)
	defer delete(tok)


	for i in 0 ..< len(tok) {
		testing.expect_value(t, tok[i], res[i])
	}


}
