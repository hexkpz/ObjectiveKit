//
//  Created by Anton Spivak
//

#import "NSObject+OC.h"

@import ObjectiveC.runtime;

@implementation NSObject (SUI)

- (BOOL)oc_isKindOfSystemClass {
    return [NSStringFromClass([self class]) hasPrefix:@"_"];
}

@end
