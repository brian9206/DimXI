#import "DimWindow.h"
#import <libactivator/libactivator.h>

@interface DimController : NSObject <LAListener> {
	NSUserDefaults *prefs;
}

@property (nonatomic) BOOL enabled;

+ (DimController*)sharedInstance;
- (DimWindow*)window;
- (void)updateFromPreferences;

@end