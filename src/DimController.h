#import "DimWindow.h"

@interface DimController : NSObject {
	NSUserDefaults *prefs;
}

@property (nonatomic) BOOL enabled;

+ (DimController*)sharedInstance;
- (DimWindow*)window;
- (void)updateFromPreferences;

@end