#include "system.h"
#include "screen.h"

#define ROW_SIZE SCREEN_WIDTH

uint8_t cursor_row;
uint8_t cursor_column;
uint8_t cursor_fgcolor;
uint8_t cursor_bgcolor;

void move_cursor();
void divide(uint32_t divident, uint32_t divisor, uint32_t *quotient, uint32_t *remainder);

void set_cursor(uint8_t row, uint8_t column){
	if(row >= 0 && row < SCREEN_HEIGHT && column >= 0 && column < SCREEN_WIDTH){
		cursor_row = row;
		cursor_column = column;
	}else{
		//Print error
	}
}

void get_cursor(uint8_t *row, uint8_t *column){
	*row = cursor_row;
	*column = cursor_column;
}

void set_color(uint8_t fgcolor, uint8_t bgcolor){
	if(fgcolor >= 0 && fgcolor < 16 && bgcolor >= 0 && bgcolor < 16){
		cursor_fgcolor = fgcolor;
		cursor_bgcolor = bgcolor;
	}else{
		//Print error
	}
}

void get_color(uint8_t *fgcolor, uint8_t *bgcolor){
	*fgcolor = cursor_fgcolor;
	*bgcolor = cursor_bgcolor;
}

void put_char(uint8_t ch){
	vga_ptr_t vga = VGA_START_ADDR;
	if(ch != '\n'){
		vga[cursor_row*ROW_SIZE+cursor_column] = ((uint16_t)cursor_bgcolor<<12) | (((uint16_t)cursor_fgcolor<<8)&0x0F00) | ((uint16_t)ch);
		move_cursor();
	}else{
		if(++cursor_row==SCREEN_HEIGHT)
			cursor_row = 0;
		cursor_column = 0;
	}
}

void puts(char *str){
	for(char *i = str; *i != '\0'; i++)
		put_char(*i);
}

void put_decimal(uint32_t n){
	uint32_t quotient = n;
	uint32_t remainder;
	char numbers[10];
	int n_len = 0;
	do{
		divide(quotient, 10, &quotient, &remainder);
		numbers[n_len++] = remainder+'0';
	}while(quotient != 0);

	while(n_len--> 0)
		put_char(numbers[n_len]);
}

void clear_screen(){
	vga_ptr_t vga;
	for(vga = VGA_START_ADDR; vga < VGA_END_ADDR; vga++)
		*vga = ((uint16_t)cursor_bgcolor<<12) | (((uint16_t)cursor_fgcolor<<8)&0x0F00) | ((uint16_t)' ');
	cursor_column = 0;
	cursor_row = 0;
}

void move_cursor(){
	if(++cursor_column==SCREEN_WIDTH){
		if(++cursor_row==SCREEN_HEIGHT){
			cursor_column = 0;
			cursor_row = 0;
		}
	}
}

void divide(uint32_t divident, uint32_t divisor, uint32_t *quotient, uint32_t *remainder){
	*quotient = 0;
	while(divident>=divisor){
		divident-=divisor;
		*quotient+=1;
	}
	*remainder = divident;
}
