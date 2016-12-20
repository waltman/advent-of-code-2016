#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// const unsigned long MAX = 9;
const unsigned long MAX = 4294967295;
const unsigned long MAX_LEN = 100;

int main(int argc, char *argv[]) {
        unsigned char *ip = (unsigned char *) calloc(MAX+1, sizeof(unsigned char));
        if (ip == NULL) {
                perror("calloc");
                exit(1);
        }

        FILE *fp;
        if ((fp = fopen(argv[1], "r")) == NULL) {
                perror(argv[1]);
                exit(1);
        }

        char line[MAX_LEN+1];
        while (fgets(line, MAX_LEN, fp) != NULL) {
                int i;
                unsigned long from = 0;
                for (i = 0; line[i] != '-'; i++)
                        from = from * 10 + line[i] - '0';

                unsigned long to = 0;
                for (i = i+1; line[i] != '\n'; i++)
                        to = to * 10 + line[i] - '0';

                memset(ip+from, 1, to-from+1);
        }

        int first = 0;
        unsigned long cnt = 0;
        for (unsigned long i = 0; i <= MAX; i++) {
                if (!ip[i]) {
                        if (!first) {
                                printf("first = %lu\n", i);
                                first = 1;
                        }
                        cnt++;
                }
        }
        printf("count = %lu\n", cnt);

        return 0;
}
