//
//  AppDelegate.m
//  Outty
//
//  Created by cheenar gupte on 6/27/16.
//  Copyright © 2016 Cheenar Gupte. All rights reserved.
//

#import "AppDelegate.h"
#import "SSAudioDeviceCenter.h"

@interface AppDelegate ()
{
    NSStatusItem *item;
    NSMenu *menu;
}
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    item = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    item.button.image = [NSImage imageNamed:@"StatusBarButtonImage"];
    
    menu = [[NSMenu alloc] init];
    
    [menu addItem:[[NSMenuItem alloc] initWithTitle:@"Output Devices" action:nil keyEquivalent:@""]];
    [menu addItem:[NSMenuItem separatorItem]];
    
    SSAudioDeviceCenter *_deviceCenter;
    _deviceCenter = [[SSAudioDeviceCenter alloc] init];
    
    NSEnumerator *enumerator = [[_deviceCenter outputDevices] objectEnumerator];
    id deviceItem;
    int a = 1;
    while (deviceItem = [enumerator nextObject]) {
        [menu addItem:[[NSMenuItem alloc] initWithTitle:[deviceItem name] action:@selector(handleOutputSelection:) keyEquivalent:[NSString stringWithFormat:@"%i", a]]];
        a++;
    }
    
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:[[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@"q"]];
    
    item.menu = menu;
}

-(void)handleOutputSelection:(NSMenuItem *)menuItem
{
    SSAudioDeviceCenter *_deviceCenter;
    _deviceCenter = [[SSAudioDeviceCenter alloc] init];
    NSEnumerator *enumerator = [[_deviceCenter outputDevices] objectEnumerator];
    id _item;
    while (_item = [enumerator nextObject]) {
        if ([[_item name] isEqualToString:menuItem.title]) {
            SSAudioDevice* device = _item;
            if( device && [device isKindOfClass: [SSAudioDevice class]] ) {
                [_deviceCenter setSelectedOutputDevice: device];
            }
        }
    }
}

-(void) menuWillOpen:(NSMenu *)menu {
    NSLog(@"debug");
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
