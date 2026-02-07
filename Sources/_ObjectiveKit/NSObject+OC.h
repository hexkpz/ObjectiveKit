//
//  Created by Anton Spivak
//

#import "_ObjectiveKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SUI)

/// Returns `YES` if class name starts with `_`
- (BOOL)oc_isKindOfSystemClass;

@end

NS_ASSUME_NONNULL_END
