[![Build Status](https://travis-ci.org/urdh/libgraph64osx.png)](https://travis-ci.org/urdh/libgraph64osx)

**Note:** This is essentially a reverse-engineered API-compatible OS X (Quartz/Cocoa) variant of the [libgraph64](http://www.math.chalmers.se/Math/Grundutb/CTH/tma881/1213/Assignments/THREADS/graphics.html) graphics library used in the High Performance Computing course given at Chalmers University of Technology. This is therefore basically a verbatim transcription of the desciption of that library, sans the (sort of irrelevant) X library text. Also somewhat relevant is [the license](LICENSE.md).

# A small graphics package
**Changes in behaviour compared to the original library** include `CloseWindow` not waiting for the letter `q`, instead waiting for the user to close the window, and the application not drawing anything (the run loop doesn't run) until `CloseWindow` is called.

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
This should be the last call to the graphics library.

### `void FlushWindow()`
Call this routine when to flush the window, making sure that everything has drawn.

### `void DrawLine(int y, int line[])`
Draw a whole line of pixels in row `y`. The array `line` should contain colour values. The length of `line` must be the same as `width` (the width of the window) from `OpenWindow`.

### `void DrawPoint(int x, int y, int color)`
Draw one point at coordinates `(x, y)` with colour `color`.

### `void WaitForButton(int *x, int *y, int *button)` (not implemented)
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
Compiling the library should be as easy as running `make all`. That will get you a shared library file `libgraph64osx.dylib` to link against.

## Using the library
Include `defs.h` in your C program, use the functions as described above. Compile with the `-lgraph64osx` flag, assuming the compiler knows where to find `libgraph64osx.dylib`.
