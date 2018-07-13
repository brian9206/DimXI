#import <libactivator/libactivator.h>
#import <dlfcn.h>
#import <objc/runtime.h>
#import "substrate.h"
#import "DimController.h"

BOOL enabledBeforeScreenshot = NO;

%hook SpringBoard
- (void)applicationDidFinishLaunching:(UIApplication *)application {
    %orig;
	[DimController sharedInstance]; //Initialize dim controller
}

-(void)takeScreenshotAndEdit:(BOOL)arg1 {
	enabledBeforeScreenshot = [DimController sharedInstance].enabled;
	[[DimController sharedInstance] window].hidden = YES;

	%orig;

	if (enabledBeforeScreenshot) {
		//Give the window a small amount of time to disappear before taking the screenshot
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
			[[DimController sharedInstance] window].hidden = !enabledBeforeScreenshot;
		});
	}
}
%end

//Called when any preference is changed in the settings pane
void prefsChanged() {
	[[DimController sharedInstance] updateFromPreferences];
}

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)prefsChanged, CFSTR("pw.ssnull.dimxi/prefschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	%init;
}
