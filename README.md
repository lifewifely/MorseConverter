# MorseConvertor

## Introduction

> This project is a converter between Morse code and common letters based on the BASYS 2 FPGA. And I added a simple electronic keyboard as an Easter egg (Need a buzzer).

## Features

### Decoding mode

When the button is not pressed, default mode is decoding mode. The 8-bit DIP switches can control the input of  4-digit Morse code. The corresponding letter will be displayed on the digital tube and the LED will be lighted, too.

### Encoding mode

When btn0 is pressed, it will be encoding mode. The 8-digit DIP switches can control the input of a single letter. The corresponding Morse code will be displayed on the digital tube and the LED will be lighted.

### Electronic keyboard

The lower 7 bits of DIP switches can control the scale. While pressing the btn3, 2, 1, you can select the different pitches.

## Instructions

| DIP Switches |   01    |   11    | default |
| :----------: | :-----: | :-----: | :-----: |
|  **Input**   | dit (·) | dat (-) |  null   |

| DIP Switches | Letter | DIP Switches | Letter | DIP Switches | Letter |
| :----------: | :----: | :----------: | :----: | :----------: | :----: |
|  0 100 0000  |   a    |  0 110 1111  |   j    |  1 000 0010  |   s    |
|  0 010 0000  |   b    |  0 111 0111  |   k    |  1 000 0001  |   t    |
|  0 001 0000  |   c    |  0 111 1011  |   l    |  1 011 1111  |   u    |
|  0 000 1000  |   d    |  0 111 1101  |   m    |  1 101 1111  |   v    |
|  0 000 0100  |   e    |  0 111 1110  |   n    |  1 110 1111  |   w    |
|  0 000 0010  |   f    |  1 100 0000  |   o    |  1 111 1011  |   x    |
|  0 000 0001  |   g    |  1 010 0000  |   p    |  1 111 1101  |   y    |
|  0 011 1111  |   h    |  1 001 0000  |   q    |  1 111 1110  |   z    |
|  0 101 1111  |   i    |  1 000 0100  |   r    |   default    |  null  |

