//
//  Created by Anton Spivak
//

#import "_ObjectiveKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (OC)

/// Returns `YES` if the receiver's class name starts with an underscore (`_`),
/// which is a common convention for private/system framework classes.
- (BOOL)oc_isKindOfSystemClass;

@end

NS_ASSUME_NONNULL_END
