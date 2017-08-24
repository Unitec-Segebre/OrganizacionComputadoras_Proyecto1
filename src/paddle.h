#ifndef PADDLE_H
#define PADDLE_H

#include "system.h"

#define LEFT_PADDLE 0
#define RIGHT_PADDLE 1

void initpaddles();
void moveup(uint8_t paddle);
void movedown(uint8_t paddle);
void showpaddles();

#endif //PADDLE_H