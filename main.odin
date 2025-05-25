package main

import "core:fmt"

input := "let x = (46 * 1)"


token :: struct {
	type:  string,
	value: rune,
}

position := 0
char: rune

main :: proc() {
	for position < len(input) - 1 {
		token := createToken()
		fmt.println(token)
	}
}


createToken :: proc() -> token {
	readChar()

	switch char {
	case '=':
		return token{type = "ASSIGN", value = char}
	case '(':
		return token{type = "LPAREN", value = char}
	case ')':
		return token{type = "RPAREN", value = char}
	case '{':
		return token{type = "LBRACE", value = char}
	case '}':
		return token{type = "RBRACE", value = char}
	case '-':
		return token{type = "MINUS", value = char}
	case '+':
		return token{type = "PLUS", value = char}
	case '*':
		return token{type = "ASTERISK", value = char}
	case '/':
		return token{type = "SLASH", value = char}
	case:
		return token{type = "EOF", value = ' '}
	}

	return token{}
}


readChar :: proc() {
	char = rune(input[position])
	position += 1
}
