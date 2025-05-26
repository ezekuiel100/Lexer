package main

import "core:fmt"

input := "let x = (46 * 1)"

token :: struct {
	type:  string,
	value: string,
}

position := 0
char := string(input[position:position + 1])

main :: proc() {
	for position < len(input) {
		token := createToken()

		fmt.println(token)

	}
}


createToken :: proc() -> token {
	tok: token
	skipWhiteSpace()

	switch char {
	case "=":
		tok = token {
			type  = "ASSIGN",
			value = char,
		}
	case "(":
		tok = token {
			type  = "LPAREN",
			value = char,
		}
	case ")":
		tok = token {
			type  = "RPAREN",
			value = char,
		}
	case "{":
		tok = token {
			type  = "LBRACE",
			value = char,
		}
	case "}":
		tok = token {
			type  = "RBRACE",
			value = char,
		}
	case "-":
		tok = token {
			type  = "MINUS",
			value = char,
		}
	case "+":
		tok = token {
			type  = "PLUS",
			value = char,
		}
	case "*":
		tok = token {
			type  = "ASTERISK",
			value = char,
		}
	case "/":
		tok = token {
			type  = "SLASH",
			value = char,
		}
	case:
		if isNumber() {
			start := position

			for isNumber() {
				readChar()
			}

			return token{type = "INTEGER", value = input[start:position]}
		} else {
			tok = token {
				type  = "EOF",
				value = " ",
			}
		}
	}

	readChar()
	return tok
}


readChar :: proc() {
	position += 1

	if position >= len(input) {
		char = " "
	} else {
		char = string(input[position:position + 1])
	}
}

skipWhiteSpace :: proc() {
	for char == " " {
		readChar()
	}
}

isNumber :: proc() -> bool {
	return char[0] >= 48 && char[0] <= 57
}
