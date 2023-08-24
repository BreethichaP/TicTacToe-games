#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char grid[9];

void game_board() {
    printf("\n");
    printf("%c | %c | %c \n", grid[0], grid[1], grid[2]);
    printf("----------\n");
    printf("%c | %c | %c \n", grid[3], grid[4], grid[5]);
    printf("----------\n");
    printf("%c | %c | %c \n", grid[6], grid[7], grid[8]);
    printf("\n");
}

void dashes(char grid[]) {
for(int i = 0; i < 9; i++) {
        if(grid[i] == ' ') {
            grid[i] = '-';
        }
    }
}

int check_winner(char grid[], char player) {
    if((grid[0] == player && grid[4] == player && grid[8] == player) || (grid[2] == player && grid[4] == player && grid[6] == player)) {
        return 1;
    } 
    else if((grid[0] == player && grid[1] == player && grid[2] == player) || (grid[3] == player && grid[4] == player && grid[5] == player) 
           || (grid[6] == player && grid[7] == player && grid[8] == player)) {
                   return 1;
    } 
    else if ((grid[0] == player && grid[3] == player && grid[6] == player) || (grid[1] == player && grid[4] == player && grid[7] == player) 
           || (grid[2] == player && grid[5] == player && grid[8] == player)) {
                   return 1;
           }
           return 0;
}

int main (int argc, char* argv[]) {
    char player = argv[1][0]; 
    int moves[9];
    int count = 0;
    int num;
    char num2;
    //Arg 1
    if(player != 'X' && player != 'O') {
        fprintf(stderr, "Arg 1: must be X or O\n");
        exit (1);
    }

    //Arg 2

    FILE *file;
    file = fopen(argv[2], "r");

    if(file == NULL) {
        fprintf(stderr, "Arg 2: Must be a readable file\n");
        exit (2);
    }
    
    //PUTTING THE NUMBERS IN THE ARRAY
    while(fscanf(file, "%d", &num) == 1) {
        if(num > 0 && num < 10) {
             moves[count] = num;
             count++; //Only incrementing count if num is a valid number
        }
        else {
            fprintf(stderr, "Arg 2: File must contain integers 1-9\n");
            fclose(file);
            exit (3);
        }
    }
    char extra;
    if(fscanf(file, "%c", &extra) != EOF) {
        fprintf(stderr, "Arg 2: File must contain integers 1-9\n");
            fclose(file);
            exit (3);
    }
    fclose(file);

    // NEED TO CHECK UNIQUE NUMBER
    for(int i = 0; i < 9; i++) {
        for(int j = i + 1; j < 9; j++) {
            if(moves[i] == moves[j]) {
                fprintf(stderr, "Arg 2: File must contain integers 1-9\n");
                exit (3);
            }
        }
    }

    
    if(count != 9) {
        fprintf(stderr, "Arg 2: File must contain integers 1-9\n");
        exit (3);
    }
    
   

    //INITIALIZING THE GAME BOARD
    for(int i = 0; i < 9; i++) {
        grid[i] = ' ';   
    }

    //GAMEPLAY 
    int currentmove = 0;
    


    while(currentmove < count) {
        int move = moves[currentmove] - 1;
        if(grid[move] == ' ') {
              grid[move] = player;
        }
        //Switching the players
        if(player == 'X') {
            player = 'O';
        }else{
            player = 'X';
        }

     if(check_winner(grid, grid[move])) {
        dashes(grid);
        if(grid[move] == 'X') {
            printf("\n");
            printf("%c is the winner!\n", grid[move]);
            game_board();
            exit(4);
        } else if(grid[move] == 'O') {
            printf("\n");
            printf("%c is the winner!\n", grid[move]);
            game_board();
            exit (5);
        }
     

        }
        currentmove++;
    }
    if(currentmove == count) {
        printf("\n");
        printf("The game ends in a tie.\n");
        game_board();
        exit(6);
    }
    
     }
