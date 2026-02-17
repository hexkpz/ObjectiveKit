//
//  Created by Anton Spivak
//

#import "NSException+OC.h"

NSErrorDomain const OCExceptionErrorDomain = @"OCExceptionErrorDomain";

@implementation NSException (OC)

- (NSError *)oc_error
{
    // Collect exception details into a debug info dictionary.
    // Use a distinct name to avoid shadowing the NSException `userInfo` property.
    NSMutableDictionary *exceptionInfo = [NSMutableDictionary dictionary];

    [exceptionInfo setValue:self.name forKey:@"OCExceptionName"];
    [exceptionInfo setValue:(self.reason ?: @"") forKey:@"OCExceptionReason"];
    [exceptionInfo setValue:self.callStackReturnAddresses forKey:@"OCExceptionCallStackReturnAddresses"];
    [exceptionInfo setValue:self.callStackSymbols forKey:@"OCExceptionCallStackSymbols"];
    [exceptionInfo setValue:(self.userInfo ?: @{}) forKey:@"OCExceptionUserInfo"];

    return [NSError errorWithDomain:OCExceptionErrorDomain
                               code:0
                           userInfo:@{
        NSUnderlyingErrorKey : self,
        NSDebugDescriptionErrorKey : [exceptionInfo copy],
        NSLocalizedFailureReasonErrorKey : self.reason ?: @""
    }];
}

+ (void)oc_raiseExceptionWithName:(NSExceptionName)name
                           reason:(nullable NSString *)reason
                         userInfo:(nullable NSDictionary *)userInfo
{
    [[NSException exceptionWithName:name
                             reason:reason
                           userInfo:userInfo] raise];
}

@end
