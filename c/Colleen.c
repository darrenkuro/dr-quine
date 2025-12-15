#include <stdio.h> // outside comment

void quine() {
    char *s = "#include <stdio.h> // outside comment%c%cvoid quine() {%c    char *s = %c%s%c;%c    printf(s, 10, 10, 10, 34, s, 34, 10, 10, 10, 10, 10, 10, 10);%c}%c%cint main() {%c    quine(); // inside comment%c}%c";
    printf(s, 10, 10, 10, 34, s, 34, 10, 10, 10, 10, 10, 10, 10);
}

int main() {
    quine(); // inside comment
}
