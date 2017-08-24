#ifndef SCREEN_H
#define SCREEN_H

#define BLACK 0x0
#define BLUE 0x1
#define GREEN 0x2
#define CYAN 0x3
#define RED 0x4
#define MAGENTA 0x5
#define BROWN 0x6
#define WHITE 0x7
#define GRAY 0x8
#define LIGHT_BLUE 0x9
#define LIGHT_GREEN 0xA
#define LIGHT_CYAN 0xB
#define LIGHT_RED 0xC
#define LIGHT_MAGENTA 0xD
#define YELLOW 0xE
#define BRIGHT_WHITE 0xF

#define SCREEN_WIDTH 80
#define SCREEN_HEIGHT 30

#include "system.h"

void set_cursor(uint8_t row, uint8_t column);
void get_cursor(uint8_t *row, uint8_t *column);
void set_color(uint8_t fgcolor, uint8_t bgcolor);
void get_color(uint8_t *fgcolor, uint8_t *bgcolor);
void put_char(uint8_t ch);
void puts(char *str);
void put_decimal(uint32_t n);
void clear_screen();

#endif //SCREEN_H