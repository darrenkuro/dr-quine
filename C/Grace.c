#include <stdio.h>

#define FILE "Grace_kid.c"
#define CODE "#include <stdio.h>%1$c%1$c#define FILE %2$cGrace_kid.c%2$c%1$c#define CODE %2$c%3$s%2$c%1$c#define MAIN(x) int main(void) {fprintf(fopen(x, %2$cw%2$c), CODE, 10, 34, CODE);}%1$c%1$cMAIN(FILE)%1$c/*%1$c    Comment%1$c*/%1$c"
#define MAIN(x) int main(void) {fprintf(fopen(x, "w"), CODE, 10, 34, CODE);}

MAIN(FILE)
/*
    Comment
*/
