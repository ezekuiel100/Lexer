package main

import "core:fmt"

input :: "let x = 46"


token :: struct {
	type:  string,
	value: rune,
}


main :: proc() {
	token := createToken(rune(input[0]))
	fmt.println(token)
}


createToken :: proc(ch: rune) -> token {

	switch ch {
	case '=':
		return token{type = "ASSIGN", value = ch}
	case '(':
		return token{type = "LPAREN", value = ch}
	case ')':
		return token{type = "RPAREN", value = ch}
	case '{':
		return token{type = "LBRACE", value = ch}
	case '}':
		return token{type = "RBRACE", value = ch}
	case '-':
		return token{type = "MINUS", value = ch}
	case '+':
		return token{type = "PLUS", value = ch}
	case '*':
		return token{type = "ASTERISK", value = ch}
	case '/':
		return token{type = "SLASH", value = ch}
	case:
		return token{type = "EOF", value = ' '}
	}

	return token{}
}
