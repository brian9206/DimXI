#import "DimController.h"
#import <objc/runtime.h>

const CGFloat MAX_ALPHA = 0.8; //So the user can see their screen, even at max darkness

@implementation DimController

+ (DimController*)sharedInstance {
	static dispatch_once_t p = 0;
    __strong static DimController* sharedObject = nil;
    dispatch_once(&p, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

- (id)init {
	if (self = [super init]) {
		prefs = [[NSUserDefaults alloc] initWithSuiteName:@"pw.ssnull.dimxi"];
		[prefs registerDefaults:@{
			@"enabled": @NO,
			@"brightness": [NSNumber numberWithFloat:0.5]
		}];
		[self updateFromPreferences];
	}
	return self;
}

// Used for lazy initialization of the window.
// If the window is loaded too quickly as SpringBoard is launching, it won't appear.
// Also, this fixes a bug causing a respring after using the 9.3.3 jailbreak
- (DimWindow*)window {
	static DimWindow* dimWindow = nil;
	if (!dimWindow) {
		dimWindow = [[DimWindow alloc] init];
	}
	return dimWindow;
}

- (float)alphaForBrightness:(float)b {
	return (1 - b) * MAX_ALPHA; //alpha = 1 means fully opaque (fully dark)
}

- (void)updateFromPreferences {
	[self window].hidden = ![prefs boolForKey:@"enabled"];
	[self window].alpha = [self alphaForBrightness:[prefs floatForKey:@"brightness"]];
}

- (void)setEnabled:(BOOL)e {
	[self window].hidden = !e;
	[prefs setBool:e forKey:@"enabled"];
}

- (BOOL)enabled {
	return ![self window].hidden;
}

@end