// Part of the libgraph64osx library. See LICENSE.md for licensing details.
void OpenWindow(int width, int height);
void CloseWindow();
void FlushWindow();
void DrawLine(int y, int line[]);
void DrawPoint(int x, int y, int color);
void DrawCircle(int x, int y, int radius, int color);
void WaitForButton(int *x, int *y, int *button);
void DrawRectangle(int x, int y, int width, int height);
void FillRectangle(int x, int y, int width, int height);
void SetColor(int);
void FillArc(int x, int y, int width, int height, int angle1, int angle2);
