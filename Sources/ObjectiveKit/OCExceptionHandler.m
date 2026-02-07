//
//  Created by Anton Spivak
//

#import "OCExceptionHandler.h"
#import "NSException+OC.h"

@implementation OCExceptionHandler

+ (void)perform:(void(NS_NOESCAPE ^)(void))body error:(NSError * __autoreleasing *)error {
    @try {
        body();
    } @catch (NSException *exception) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:OCExceptionErrorDomain code:0 userInfo:@{}];
            if (exception != nil) *error = [exception oc_error];
        }
    } @finally {}
}

@end
