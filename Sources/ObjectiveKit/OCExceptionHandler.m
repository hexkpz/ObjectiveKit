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
            // Convert the caught Objective-C exception into an NSError.
            *error = [exception oc_error];
        }
    } @finally {}
}

@end
