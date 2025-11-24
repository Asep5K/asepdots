#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>

#define MAX_LINE_LEN 256
#define MAX_MSGS 100

void print_to_console(const char* msg, const char* status) {
    printf("{\"text\": \"%s\", \"tooltip\": \"%s\", \"alt\": \"%s\", \"class\": \"%s\"}\n", 
            msg, msg, status, status);
    fflush(stdout);
}

void typing(const char* msg, float type_speed, int pause_sec) {
    int len = strlen(msg);
    char buffer[MAX_LINE_LEN];

    for (int i = 0; i <= len; i++) {
        strncpy(buffer, msg, i);
        buffer[i] = '\0';
        print_to_console(buffer, "write");
        
        if (i == len) {
            sleep(pause_sec);
        } else {
            usleep((int)(type_speed * 1000000));
        }
    }

    for (int i = len - 1; i >= 0; i--) {
        strncpy(buffer, msg, i);
        buffer[i] = '\0';
        print_to_console(buffer, "delete");
        usleep((int)(type_speed * 1000000));
    }
}

void shuffle(char** array, int n) {
    if (n > 1) {
        for (int i = 0; i < n - 1; i++) {
            int j = i + rand() / (RAND_MAX / (n - i) + 1);
            char* t = array[j];
            array[j] = array[i];
            array[i] = t;
        }
    }
}

int main() {
    char* messages[MAX_MSGS];
    int msg_count = 0;
    char path[256];
    snprintf(path, sizeof(path), "%s/.config/waybar/scripts/messages", getenv("HOME"));
    FILE* file = fopen(path, "r");
    
    if (!file) {
        typing("Failed to load messages.", 0.1, 2);
        return 1;
    }

    char line[MAX_LINE_LEN];
    while (fgets(line, sizeof(line), file) && msg_count < MAX_MSGS) {
        line[strcspn(line, "\n")] = 0; // Hapus newline
        if (strlen(line) > 0 && line[0] != '!') {
            messages[msg_count] = strdup(line);
            msg_count++;
        }
    }
    fclose(file);

    srand(time(NULL));
    shuffle(messages, msg_count);

    while (1) {
        for (int i = 0; i < msg_count; i++) {
            typing(messages[i], 0.3, 3);
        }
    }
}