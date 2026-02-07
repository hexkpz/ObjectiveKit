//
//  Created by Anton Spivak
//

#import "_ObjectiveKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCExceptionHandler : NSObject

/// Execute block and receive an error if that has been throwed by ObjectiveC
+ (void)perform:(void(NS_NOESCAPE ^)(void))body error:(NSError * __autoreleasing *)error OC_SWIFT_ERROR;

@end

NS_ASSUME_NONNULL_END
