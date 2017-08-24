#include "system.h"
#include "keypad.h"
#include "screen.h"
#include "paddle.h"

int main(int argc, char const *argv[])
{
    clear_screen();
    // set_color(BLACK, WHITE);
    uint8_t key;
	keypad_init();
    initpaddles();
    while (true){
        key = keypad_getkey();
        switch(key){
        	case 1:    //puts("left"); put_char('\n');break;
        	case 2:    //puts("right"); put_char('\n');break;
        	case 3: movedown(RIGHT_PADDLE); break;    //puts("down"); put_char('\n');break;
        	case 4: moveup(RIGHT_PADDLE); break;    //puts("up"); put_char('\n');break;
        	case 5: moveup(LEFT_PADDLE); break;   //puts("q"); put_char('\n');break;
        	case 6:    //puts("p"); put_char('\n');break;
        	case 7:    //puts("b"); put_char('\n');break;
        	case 8: movedown(LEFT_PADDLE); break;    //puts("space"); put_char('\n');break;
        }
        showpaddles();
        // set_cursor(SCREEN_HEIGHT/2, SCREEN_WIDTH/2);
        // set_color(BRIGHT_WHITE, BLACK);
    }
	return 0;
}
