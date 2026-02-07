//
//  Created by Anton Spivak
//

#import "_ObjectiveKit.h"

NS_ASSUME_NONNULL_BEGIN

OC_EXPORT NSErrorDomain const OCExceptionErrorDomain;

@interface NSException (OC)

- (NSError *)oc_error;

@end

NS_ASSUME_NONNULL_END
