#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main() {
    int i = 5, ret = 1, fd = -1;
    if (--i < 0) return (ret);

    char *fname = NULL, *cmd = NULL;
    char *code = "#include <stdlib.h>%1$c#include <stdio.h>%1$c#include <fcntl.h>%1$c#include <unistd.h>%1$c%1$cint main() {%1$c    int i = %2$d, ret = 1, fd = -1;%1$c    if (--i < 0) return (ret);%1$c%1$c    char *fname = NULL, *cmd = NULL;%1$c    char *code = %3$c%4$s%3$c;%1$c    char *code_cmd = %3$c%5$s%3$c;%1$c    char *code_fname = %3$c%6$s%3$c;%1$c    if (asprintf(&cmd, code_cmd, i) == -1) goto cleanup;%1$c    if (asprintf(&fname, code_fname, i) == -1) goto cleanup;%1$c%1$c    fd = open(fname, O_WRONLY | O_CREAT | O_TRUNC, 0644);%1$c    if (fd < 0) goto cleanup;%1$c    dprintf(fd, code, 10, i, 34, code, code_cmd, code_fname);%1$c    system(cmd);%1$c    ret = 0;%1$c%1$ccleanup:%1$c    free(fname), free(cmd);%1$c    if (fd >= 0) close(fd);%1$c    return ret;%1$c}%1$c";
    char *code_cmd = "cc -Wall -Werror -Wextra Sully_%1$d.c -o Sully_%1$d; ./Sully_%1$d";
    char *code_fname = "Sully_%d.c";
    if (asprintf(&cmd, code_cmd, i) == -1) goto cleanup;
    if (asprintf(&fname, code_fname, i) == -1) goto cleanup;

    fd = open(fname, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd < 0) goto cleanup;
    dprintf(fd, code, 10, i, 34, code, code_cmd, code_fname);
    system(cmd);
    ret = 0;

cleanup:
    free(fname), free(cmd);
    if (fd >= 0) close(fd);
    return ret;
}
