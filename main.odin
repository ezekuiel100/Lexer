#+feature dynamic-literals

package main

import "core:fmt"

token :: struct {
	type:  string,
	value: string,
}

Lexer :: struct {
	input:    string,
	position: int,
	char:     string,
}

keywords := map[string]string {
	"let"    = "LET",
	"func"   = "FUNCTION",
	"true"   = "TRUE",
	"false"  = "FALSE",
	"if"     = "IF",
	"else"   = "ELSE",
	"return" = "RETURN",
}

main :: proc() {
	token := lexer("let x = (46 * 1)")
	fmt.println(token)
}

lexer :: proc(input: string) -> [dynamic]token {
	l := new(Lexer)
	l.input = input
	l.position = 0
	l.char = string(input[l.position:l.position + 1])


	createToken :: proc(l: ^Lexer) -> token {
		tok: token
		skipWhiteSpace(l)

		switch l.char {
		case "=":
			tok = newToken("ASSIGN", l.char)
		case "(":
			tok = newToken("LPAREN", l.char)
		case ")":
			tok = newToken("RPAREN", l.char)
		case "{":
			tok = newToken("LBRACE", l.char)
		case "}":
			tok = newToken("RBRACE", l.char)
		case "-":
			tok = newToken("MINUS", l.char)
		case "+":
			tok = newToken("PLUS", l.char)
		case "*":
			tok = newToken("ASTERISK", l.char)
		case "/":
			tok = newToken("SLASH", l.char)
		case:
			if isNumber(l) {
				start := l.position

				for isNumber(l) {
					readChar(l)
				}

				return newToken("INT", l.input[start:l.position])
			} else if isLetter(l) {
				ident := readIdentifier(l)
				typ := "IDENT"

				if kw, ok := keywords[ident]; ok {
					typ = kw
				}

				return newToken(typ, ident)
			} else {
				tok = newToken("ILLEGAL", l.char)
			}
		}

		readChar(l)
		return tok
	}

	readChar :: proc(l: ^Lexer) {
		l.position += 1

		if l.position >= len(l.input) {
			l.char = " "
		} else {
			l.char = string(l.input[l.position:l.position + 1])
		}
	}

	newToken :: proc(type, value: string) -> token {
		return token{type = type, value = value}
	}


	skipWhiteSpace :: proc(l: ^Lexer) {
		for l.char == " " {
			readChar(l)
		}
	}

	isNumber :: proc(l: ^Lexer) -> bool {
		return l.char[0] >= 48 && l.char[0] <= 57
	}


	isLetter :: proc(l: ^Lexer) -> bool {
		ch := l.char[0]
		return ch >= 'a' && ch <= 'z' || ch >= 'A' && ch <= 'Z' || ch == '_'
	}

	readIdentifier :: proc(l: ^Lexer) -> string {
		start := l.position

		for isLetter(l) {
			readChar(l)
		}

		return l.input[start:l.position]
	}

	tok: [dynamic]token
	for l.position < len(l.input) {
		append(&tok, createToken(l))
	}

	return tok
}
