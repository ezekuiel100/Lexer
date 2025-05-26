package main

import "core:fmt"

input := "let x = (46 * 1)"


token :: struct {
	type:  string,
	value: rune,
}

position := 0
char := rune(input[position])

main :: proc() {
	for position < len(input) {
		token := createToken()
		fmt.println(token)

	}
}


createToken :: proc() -> token {
	tok: token

	switch char {
	case '=':
		tok = token {
			type  = "ASSIGN",
			value = char,
		}
	case '(':
		tok = token {
			type  = "LPAREN",
			value = char,
		}
	case ')':
		tok = token {
			type  = "RPAREN",
			value = char,
		}
	case '{':
		tok = token {
			type  = "LBRACE",
			value = char,
		}
	case '}':
		tok = token {
			type  = "RBRACE",
			value = char,
		}
	case '-':
		tok = token {
			type  = "MINUS",
			value = char,
		}
	case '+':
		tok = token {
			type  = "PLUS",
			value = char,
		}
	case '*':
		tok = token {
			type  = "ASTERISK",
			value = char,
		}
	case '/':
		tok = token {
			type  = "SLASH",
			value = char,
		}
	case:
		tok = token {
			type  = "EOF",
			value = ' ',
		}
	}

	readChar()
	return tok
}


readChar :: proc() {
	char = rune(input[position])
	position += 1
}
