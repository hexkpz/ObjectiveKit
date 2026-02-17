//
//  Created by Anton Spivak
//

#import "_ObjectiveKit.h"

NS_ASSUME_NONNULL_BEGIN

/// Bridges Objective-C exception handling (`@try`/`@catch`) to Swift's error model.
@interface OCExceptionHandler : NSObject

/// Executes the given block inside an Objective-C `@try`/`@catch`.
///
/// If the block raises an `NSException`, it is caught and converted to an `NSError`
/// via `-[NSException oc_error]`, then returned through the error pointer.
/// In Swift this method is imported as a throwing function.
+ (void)perform:(void(NS_NOESCAPE ^)(void))body error:(NSError * __autoreleasing *)error OC_SWIFT_ERROR;

@end

NS_ASSUME_NONNULL_END
