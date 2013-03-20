#include "assert.h"
#import <Foundation/NSAutoreleasePool.h>
#import <AppKit/NSGraphicsContext.h>
#import <AppKit/NSApplication.h>
#import <AppKit/NSWindow.h>
#import "defs.h"

NSAutoreleasePool* gPool;
NSWindow* gWindow;
CGContextRef gContext;
int gWidth, gHeight;

@interface G64XQuitApp : NSObject {}
  - (void)quitApp:(NSNotification*)notification;
@end
@implementation G64XQuitApp
  - (void)quitApp:(NSNotification*)notification
  {
    [NSApp terminate:self];
  }
@end

void OpenWindow(int width, int height)
{
  assert(width > 0 && height > 0);
  gWidth = width; gHeight = height;
  NSAutoreleasePool* gPool = [[NSAutoreleasePool alloc] init];
  [NSApplication sharedApplication];
  [NSApp finishLaunching];
  gWindow = [[[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, gWidth, gHeight)
                               styleMask:NSTitledWindowMask|NSClosableWindowMask backing:NSBackingStoreBuffered defer:NO] autorelease];
  [gWindow setTitle:@"Graph64 OS X Window"];
  [gWindow makeKeyAndOrderFront:nil];
  gContext = [[NSGraphicsContext graphicsContextWithWindow:gWindow] graphicsPort];
}

void CloseWindow()
{
  NSNotificationCenter *c = [NSNotificationCenter defaultCenter];
  [c addObserver:[G64XQuitApp alloc] selector:@selector(quitApp:) name:NSWindowWillCloseNotification object:gWindow];
  [NSApp run];
  [gPool release];
}

void FlushWindow()
{
  assert(gContext != nil);
  CGContextFlush(gContext);
}

void DrawLine(int y, int line[])
{
  assert(y >= 0 && y < gHeight);
}

//getcolor?

void DrawPoint(int x, int y, int color)
{
  assert(x >= 0 && x < gWidth && y >= 0 && y < gHeight);
}

void DrawCircle(int x, int y, int radius, int color)
{
  // Is this assertion correct?
  assert(x >= 0 && x < gWidth && y >= 0 && y < gHeight);
}

void WaitForButton(int *x, int *y, int *button)
{
  
}

void DrawRectangle(int x, int y, int width, int height)
{
  // Is this assertion correct?
  assert(x >= 0 && x < gWidth && y >= 0 && y < gHeight);
}

void FillRectangle(int x, int y, int width, int height)
{
  // Is this assertion correct?
  assert(x >= 0 && x < gWidth && y >= 0 && y < gHeight);
}

void SetColor(int color)
{
  assert(color >= 0 && color <= 7);
  switch(color) {
    case 0: // Black
      CGContextSetRGBFillColor(gContext, 0, 0, 0, 1);
      break;
    case 1: // White
      CGContextSetRGBFillColor(gContext, 1, 1, 1, 1);
      break;
    case 2: // Red
      CGContextSetRGBFillColor(gContext, 1, 0, 0, 1);
      break;
    case 3: // Green
      CGContextSetRGBFillColor(gContext, 0, 1, 0, 1);
      break;
    case 4: // Blue
      CGContextSetRGBFillColor(gContext, 0, 0, 1, 1);
      break;
    case 5: // Cyan
      CGContextSetRGBFillColor(gContext, 0, 1, 1, 1);
      break;
    case 6: // Magenta
      CGContextSetRGBFillColor(gContext, 1, 0, 1, 1);
      break;
    case 7: // Yellow
      CGContextSetRGBFillColor(gContext, 1, 1, 0, 1);
      break;
    default:
      break;
  }
}

void FillArc(int x, int y, int width, int height, int angle1, int angle2)
{
  // Is this assertion correct?
  assert(x >= 0 && x < gWidth && y >= 0 && y < gHeight);
}
