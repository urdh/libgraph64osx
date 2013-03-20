// Part of the libgraph64osx library. See LICENSE.md for licensing details.
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
  gPool = [[NSAutoreleasePool alloc] init];
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
  for(int x=0; x < gWidth; x++)
  {
    DrawPoint(x, y, line[x]);
  }
}

void DrawPoint(int x, int y, int color)
{
  assert(gContext != nil);
  assert(x >= 0 && x < gWidth && y >= 0 && y < gHeight);
  SetColor(color);
  CGContextFillRect(gContext, CGRectMake(x,y,1,1));
}

void DrawCircle(int x, int y, int radius, int color)
{
  // Is this assertion correct?
  assert(x >= 0 && x < gWidth && y >= 0 && y < gHeight);
  CGContextBeginPath(gContext);
  CGContextAddArc(gContext, x, y, radius, 0, 2*M_PI, 1);
  CGContextClosePath(gContext);
  CGContextSetLineWidth(gContext, 1.0f);
  CGContextStrokePath(gContext);
}

void WaitForButton(int *x, int *y, int *button)
{
  assert(false && "Not yet implemented!");
}

void DrawRectangle(int x, int y, int width, int height)
{
  assert(x >= 0 && x < gWidth && y >= 0 && y < gHeight);
  assert(x + width < gWidth && y + height < gHeight);
  CGContextStrokeRectWithWidth(gContext, CGRectMake(x,y,width,height), 1.0f);
}

void FillRectangle(int x, int y, int width, int height)
{
  assert(x >= 0 && x < gWidth && y >= 0 && y < gHeight);
  assert(x + width < gWidth && y + height < gHeight);
  CGContextFillRect(gContext, CGRectMake(x,y,width,height));
}

void SetColor(int color)
{
  assert(gContext != nil);
  assert(color >= 0 && color <= 7);
  CGColorRef cgColor;
  switch(color) {
    case 0: // Black
      cgColor = CGColorCreateGenericRGB(0, 0, 0, 1);
      break;
    case 1: // White
      cgColor = CGColorCreateGenericRGB(1, 1, 1, 1);
      break;
    case 2: // Red
      cgColor = CGColorCreateGenericRGB(1, 0, 0, 1);
      break;
    case 3: // Green
      cgColor = CGColorCreateGenericRGB(0, 1, 0, 1);
      break;
    case 4: // Blue
      cgColor = CGColorCreateGenericRGB(0, 0, 1, 1);
      break;
    case 5: // Cyan
      cgColor = CGColorCreateGenericRGB(0, 1, 1, 1);
      break;
    case 6: // Magenta
      cgColor = CGColorCreateGenericRGB(1, 0, 1, 1);
      break;
    case 7: // Yellow
      cgColor = CGColorCreateGenericRGB(1, 1, 0, 1);
      break;
    default:
      cgColor = CGColorCreateGenericRGB(0, 0, 0, 0);
      break;
  }
  CGContextSetFillColorWithColor(gContext, cgColor);
  CGContextSetStrokeColorWithColor(gContext, cgColor);
}

void FillArc(int x, int y, int width, int height, int angle1, int angle2)
{
  // Is this assertion correct?
  assert(x >= 0 && x < gWidth && y >= 0 && y < gHeight);
  assert(false && "Not yet implemented!");
}
