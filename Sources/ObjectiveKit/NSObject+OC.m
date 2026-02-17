//
//  Created by Anton Spivak
//

#import "NSObject+OC.h"

@implementation NSObject (OC)

- (BOOL)oc_isKindOfSystemClass {
    return [NSStringFromClass([self class]) hasPrefix:@"_"];
}

@end
