#include <stdio.h> // outside comment

void quine() {
    char *s = "#include <stdio.h> // outside comment%1$c%1$cvoid quine() {%1$c    char *s = %2$c%3$s%2$c;%1$c    printf(s, 10, 34, s);%1$c}%1$c%1$cint main() {%1$c    quine(); // inside comment%1$c}%1$c";
    printf(s, 10, 34, s);
}

int main() {
    quine(); // inside comment
}
