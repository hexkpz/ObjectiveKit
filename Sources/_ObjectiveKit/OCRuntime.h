//
//  Created by Anton Spivak
//

#import "_ObjectiveKit.h"

NS_ASSUME_NONNULL_BEGIN

OC_EXPORT void OCSwizzleInstanceMethodOfClass(Class aClass, SEL original, SEL swizzled);
OC_EXPORT void OCSwizzleInstanceMethodOfClasses(Class aClass, SEL aSelector, Class bKlass, SEL bSelector);

OC_EXPORT void OCSwizzleMethodOfClass(Class aClass, SEL original, SEL swizzled);
OC_EXPORT void OCSwizzleMethodOfClasses(Class aClass, SEL aSelector, Class bClass, SEL bSelector);

OC_EXPORT NSString *OCReversedStringWithParts(NSString *firstPart, ...) NS_REQUIRES_NIL_TERMINATION;
OC_EXPORT NSString *OCReversedStringWithPartsArray(NSArray<NSString *> *parts);

OC_EXPORT SEL OCSelectorFromReversedStringParts(NSString *firstPart, ...) NS_REQUIRES_NIL_TERMINATION;
OC_EXPORT Class OCClassFromReversedStringParts(NSString *firstPart, ...) NS_REQUIRES_NIL_TERMINATION;

NS_ASSUME_NONNULL_END
