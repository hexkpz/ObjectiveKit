//
//  Created by Anton Spivak
//

#import "_ObjectiveKit.h"

NS_ASSUME_NONNULL_BEGIN

/// Error domain used when converting Objective-C exceptions to NSError instances.
OC_EXPORT NSErrorDomain const OCExceptionErrorDomain;

@interface NSException (OC)

/// Converts this exception into an NSError with detailed user info.
///
/// The returned error uses `OCExceptionErrorDomain` and includes the exception name,
/// reason, call stack, and original user info in the debug description.
- (NSError *)oc_error;

/// Convenience method to raise an exception with the given name, reason, and user info.
+ (void)oc_raiseExceptionWithName:(NSExceptionName)name
                           reason:(nullable NSString *)reason
                         userInfo:(nullable NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
