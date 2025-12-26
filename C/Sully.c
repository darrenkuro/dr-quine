#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

int main() {
    char fname[64], cmd[128];
    int i = 5;
    const char *base = strrchr(__FILE__, '/');
    const char *myname = base ? base + 1 : __FILE__;
    if (strchr(myname, '_')) --i;
    if (i < 0) return (1);

    char *code = "#include <stdlib.h>%1$c#include <stdio.h>%1$c#include <fcntl.h>%1$c#include <unistd.h>%1$c#include <string.h>%1$c%1$cint main() {%1$c    char fname[64], cmd[128];%1$c    int i = %2$d;%1$c    const char *base = strrchr(__FILE__, '/');%1$c    const char *myname = base ? base + 1 : __FILE__;%1$c    if (strchr(myname, '_')) --i;%1$c    if (i < 0) return (0);%1$c%1$c    char *code = %3$c%4$s%3$c;%1$c    snprintf(fname, sizeof fname, %3$cSully_%%d.c%3$c, i);%1$c    int fd = open(fname, O_WRONLY | O_CREAT | O_TRUNC, 0644);%1$c    if (fd < 0) return (1);%1$c%1$c    snprintf(cmd, sizeof cmd, %3$ccc -Wall -Werror -Wextra Sully_%%1$d.c -o Sully_%%1$d; ./Sully_%%1$d%3$c, i);%1$c    dprintf(fd, code, 10, i, 34, code);%1$c    system(cmd);%1$c    return (close(fd), 0);%1$c}%1$c";
    snprintf(fname, sizeof fname, "Sully_%d.c", i);
    int fd = open(fname, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd < 0) return (1);

    snprintf(cmd, sizeof cmd, "cc -Wall -Werror -Wextra Sully_%1$d.c -o Sully_%1$d; ./Sully_%1$d", i);
    dprintf(fd, code, 10, i, 34, code);
    system(cmd);
    return (close(fd), 0);
}
