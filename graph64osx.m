#include "assert.h"
#import <Foundation/NSAutoreleasePool.h>
#import <AppKit/NSApplication.h>
#import <AppKit/NSWindow.h>
#import "defs.h"

NSAutoreleasePool* G64XPool;
NSWindow* gWindow;
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
  NSAutoreleasePool* G64XPool = [[NSAutoreleasePool alloc] init];
  [NSApplication sharedApplication];
  [NSApp finishLaunching];
  gWindow = [[[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, gWidth, gHeight)
                               styleMask:NSTitledWindowMask|NSClosableWindowMask backing:NSBackingStoreBuffered defer:NO] autorelease];
  [gWindow setTitle:@"Graph64 OS X Window"];
  [gWindow makeKeyAndOrderFront:nil];
  // http://developer.apple.com/library/mac/#documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_context/dq_context.html#//apple_ref/doc/uid/TP30001066-CH203-CJBDCHAC
}

void CloseWindow()
{
  NSNotificationCenter *c = [NSNotificationCenter defaultCenter];
  [c addObserver:[G64XQuitApp alloc] selector:@selector(quitApp:) name:NSWindowWillCloseNotification object:gWindow];
  [NSApp run];
  [G64XPool release];
}

void FlushWindow()
{
  
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
}

void FillArc(int x, int y, int width, int height, int angle1, int angle2)
{
  // Is this assertion correct?
  assert(x >= 0 && x < gWidth && y >= 0 && y < gHeight);
}
