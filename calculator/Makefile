CC=gcc
output=calc

.PHONY: clean all

all: $(output)

lex.yy.c: lex.l
	lex lex.l

y.tab.c: parser.y
	yacc -d parser.y

$(output): lex.yy.c y.tab.c
	$(CC) -o $(output) lex.yy.c y.tab.c -ly -ll

clean:
	rm -f *.c
	rm -f *.h
	rm -f $(output)
