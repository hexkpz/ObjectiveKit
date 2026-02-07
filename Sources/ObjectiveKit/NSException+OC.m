//
//  Created by Anton Spivak
//

#import "NSException+OC.h"

NSErrorDomain const OCExceptionErrorDomain = @"OCExceptionErrorDomain";

@implementation NSException (NSError)

- (NSError *)oc_error
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    
    [userInfo setValue:self.name forKey:@"OCExceptionName"];
    [userInfo setValue:(self.reason ?: @"") forKey:@"OCExceptionReason"];
    [userInfo setValue:self.callStackReturnAddresses forKey:@"OCExceptionCallStackReturnAddresses"];
    [userInfo setValue:self.callStackSymbols forKey:@"OCExceptionCallStackSymbols"];
    [userInfo setValue:(self.userInfo ?: @{}) forKey:@"OCExceptionUserInfo"];
    
    return [NSError errorWithDomain:OCExceptionErrorDomain
                               code:0
                           userInfo:@{
        NSUnderlyingErrorKey : self,
        NSDebugDescriptionErrorKey : [userInfo copy],
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
