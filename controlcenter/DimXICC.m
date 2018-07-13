#import "DimXICC.h"
#include <notify.h>

@implementation DimXICC

- (DimXICC*)init {
    self = [super init];

    if (self) {
        NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"pw.ssnull.dimxi"];
        _selected = [prefs boolForKey:@"enabled"];
        [prefs release];
    }
    
    return self;
}

- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

- (UIColor *)selectedColor {
	return [UIColor lightGrayColor];
}

- (BOOL)isSelected {
    return _selected;
}

- (void)setSelected:(BOOL)selected {
	_selected = selected;
    [super refreshState];

    NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"pw.ssnull.dimxi"];
    [prefs setBool:_selected forKey:@"enabled"];
    [prefs synchronize];
    [prefs release];
    
    notify_post("pw.ssnull.dimxi/prefschanged");
}

@end
