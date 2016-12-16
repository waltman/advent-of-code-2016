#include <stdio.h>
#include <stdlib.h>
#include <queue>
#include <set>
#include <string>

using namespace std;

struct maze_info {
        int x;
        int y;
        int step;
};

bool is_wall(int x, int y, int favorite);
int num_bits(int n);
string seen_key(int x, int y);

int main(int argc, char *argv[]) {
        queue<struct maze_info> q;
        set<string> seen;
        struct maze_info mi;

        int max_steps = atoi(argv[1]);
        int favorite = atoi(argv[2]);

        mi = (struct maze_info) {1, 1, 0};
        q.push(mi);
        int n = 0;
        
        while (!q.empty()) {
                n++;
                mi = q.front();
                q.pop();
                if (n % 10 == 0)
                        printf("%d iterations\n", n);

                if (mi.step > max_steps) {
                        printf("You can reach %lu locations in %d steps\n", seen.size(), max_steps);
                        return 0;
                } else if (mi.x < 0 || mi.y < 0) {
                        continue;
                } else if (is_wall(mi.x, mi.y, favorite)) {
                        continue;
                } else {
                        string k = seen_key(mi.x, mi.y);
                        if (seen.find(k) != seen.end()) {
                                continue;
                        } else {
                                seen.insert(k);
                                q.push((struct maze_info) { mi.x-1, mi.y, mi.step+1 });
                                q.push((struct maze_info) { mi.x+1, mi.y, mi.step+1 });
                                q.push((struct maze_info) { mi.x, mi.y-1, mi.step+1 });
                                q.push((struct maze_info) { mi.x, mi.y+1, mi.step+1 });
                        }
                }
        }
        puts("failed");
        return 1;
}

bool is_wall(int x, int y, int favorite) {
        int val = x*x + 3*x + 2*x*y + y + y*y + favorite;
        int count = num_bits(val);
        return count % 2;
}

int num_bits(int n) {
        int count = 0;

        while (n) {
                count += n & 1;
                n >>= 1;
        }

        return count;
}

string seen_key(int x, int y) {
        char s[80];
        sprintf(s, "%d %d", x, y);
        return string(s);
}
