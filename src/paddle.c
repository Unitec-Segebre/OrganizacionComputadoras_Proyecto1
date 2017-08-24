#include "paddle.h"
#include "screen.h"

#define PADDLE_HEIGHT 4
#define PADDLE_WIDTH 1

uint8_t left_paddle_pos;
uint8_t right_paddle_pos;

void initpaddles(){
    left_paddle_pos = SCREEN_HEIGHT/2-PADDLE_HEIGHT/2;
    right_paddle_pos = left_paddle_pos;
}

void moveup(uint8_t paddle){
    if(paddle==LEFT_PADDLE){
        if(left_paddle_pos-1<0)
            return;
        else
            left_paddle_pos--;
    }else if(paddle==RIGHT_PADDLE){
        if(right_paddle_pos-1<0)
            return;
        else
            right_paddle_pos--;
    }
}

void movedown(uint8_t paddle){
    if(paddle==LEFT_PADDLE){
        if(left_paddle_pos+PADDLE_HEIGHT+1>SCREEN_HEIGHT)
            return;
        else
            left_paddle_pos++;
    }else if(paddle==RIGHT_PADDLE){
        if(right_paddle_pos+PADDLE_HEIGHT+1>SCREEN_HEIGHT)
            return;
        else
            right_paddle_pos++;
    }
}

void showpaddles(){
    set_color(BRIGHT_WHITE, BRIGHT_WHITE);
    for (uint8_t i = 0; i < SCREEN_HEIGHT; i++){
        set_cursor(i, 0);
        if(i >= left_paddle_pos && i<left_paddle_pos+PADDLE_HEIGHT)
            set_color(BRIGHT_WHITE, BRIGHT_WHITE);
        else
            set_color(BLACK, BLACK);
        for(int j = 0; j < PADDLE_WIDTH; j++)
            put_char(' ');

        set_cursor(i, SCREEN_WIDTH-PADDLE_WIDTH);
        if(i >= right_paddle_pos && i<right_paddle_pos+PADDLE_HEIGHT)
            set_color(BRIGHT_WHITE, BRIGHT_WHITE);
        else
            set_color(BLACK, BLACK);
        for(int j = 0; j < PADDLE_WIDTH; j++)
            put_char(' ');
    }
}
