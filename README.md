*Note:* This is essentially a reverse-engineered API-compatible OS X (Quartz/Cocoa) variant of the [libgraph64](http://www.math.chalmers.se/Math/Grundutb/CTH/tma881/1213/Assignments/THREADS/graphics.html) graphics library used in the High Performance Computing course given at Chalmers University of Technology. This is therefore basically a verbatim transcription of the desciption of that library, sans the (sort of irrelevant) X library text.

# A small graphics package

## Colours
For simplicity there are only given you eight colours to work with. The colours are numbered from 0 to 7, and they are _black_, _white_, _red_, _green_, _blue_, _cyan_, _magenta_ and _yellow_.

## Coordinates
All the coordinates below are pixel-coordinates. The origin is in the upper
left corner and has coordinates `(0, 0)`. The `y` coordinate increases _downwards_, and `x` behaves as normal (increases _rightwards_).
So, if you create a window of width `w` and height `h`, the upper right corner of the plotting area has coordinates `(w-1, 0)`. The lower left has coordinates `(0, h-1)` and the lower right, `(w-1, h-1)`.

## Prototypes
The prototypes are available in `defs.h`.

### `void OpenWindow(int width, int height)`
Open a window. The size of the window is given by `width` and `height`: `width` is the number of columns and `height` is the number of rows. Call this routine before drawing anything. You cannot open more than one window, so do not make repeated calls to `OpenWindow`.

### `void CloseWindow()`
This should be the last call to the graphics library. It will wait for the user to type the letter `q` in the window. It will then close the window.

### `void FlushWindow()`
Call this routine when to flush the window, making sure that everything has drawn.

### `void DrawLine(int y, int line[])`
Draw a whole line of pixels in row `y`. The array `line` should contain colour values. The length of `line` must be the same as `width` (the width of the window) from `OpenWindow`.

### `void DrawPoint(int x, int y, int color)`
Draw one point at coordinates `(x, y)` with colour `color`.

### `void WaitForButton(int *x, int *y, int *button)`
This routine waits for a mouse click. It returns the position of the click and the button that was used (`1` = left button, `2` = middle button, `3` = right button). Note `*`. This routine can be used to implement a zoom option, for example.

## Sample program

    /* This simple program shows how the graphics library can be used. 
       It will show the available colors in a set of eight bands.
    */

    #include "defs.h"      /* Some typedefs and prototypes.      */
    #define WIDTH  400     /* Useful, since they will be needed  */
    #define HEIGHT 400     /* in several places in the program. */

    int main()
    {
      int   row, col, color, line[WIDTH];    /* Allocate storage for line.   */

      OpenWindow(WIDTH, HEIGHT);             /* The first graphics call.     */

      color = -1;                            /* -1 is an illegal color.
                                                Note color++ below.          */

      for( row = 0; row < HEIGHT; row++ ) {  /* One row at the time.         */
        if ( row % 50 == 0 ) color++;        /* Make colored bands.          */
        for (col = 0; col < WIDTH; col++)    /* For all pixels in the row.   */
          line[col] = color;                 /* Store color in line.         */

        DrawLine(row, line);                 /* Draw line as row number row. */
      }

      FlushWindow();  /* To make sure that everything has been plotted. */
      CloseWindow();  /* Wait for user to type q in window.             */

      return 0;
    }

## Compiling the library

## Using the library

