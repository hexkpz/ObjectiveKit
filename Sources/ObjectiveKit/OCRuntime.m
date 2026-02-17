//
//  Created by Anton Spivak
//

#import "OCRuntime.h"

#import <objc/runtime.h>
#import <objc/message.h>

// MARK: - Instance Method Swizzling

void OCSwizzleInstanceMethodOfClass(Class aClass, SEL original, SEL swizzled) {
    OCSwizzleInstanceMethodOfClasses(aClass, original, aClass, swizzled);
}

void OCSwizzleInstanceMethodOfClasses(Class aClass, SEL aSelector, Class bClass, SEL bSelector) {
    Method originalMethod = class_getInstanceMethod(aClass, aSelector);
    Method swizzledMethod = class_getInstanceMethod(bClass, bSelector);

    // Try to add the swizzled implementation under the original selector.
    // This handles the case where the class inherits (but doesn't override) the method.
    BOOL didAddMethod = class_addMethod(aClass,
                                        aSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        // The original selector was added, so replace the swizzled selector
        // with the original implementation.
        class_replaceMethod(aClass,
                            bSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        // Both methods exist on the class — swap their implementations directly.
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

// MARK: - Class Method Swizzling

void OCSwizzleMethodOfClass(Class aClass, SEL original, SEL swizzled) {
    OCSwizzleMethodOfClasses(aClass, original, aClass, swizzled);
}

void OCSwizzleMethodOfClasses(Class aClass, SEL aSelector, Class bClass, SEL bSelector) {
    Method originalMethod = class_getClassMethod(aClass, aSelector);
    Method swizzledMethod = class_getClassMethod(bClass, bSelector);

    // Class methods live on the metaclass.
    Class metaClass = object_getClass((id)aClass);
    BOOL didAddMethod = class_addMethod(metaClass,
                                        aSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(metaClass,
                            bSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

// MARK: - Reversed String Utilities

/// Helper macro: collects a nil-terminated va_list into an NSMutableArray.
#define va_args_array(array, first)                 \
    NSMutableArray *array = [NSMutableArray new];   \
    va_list ___args;                                \
    va_start(___args, first);                       \
    id ___arg = first;                              \
    while (___arg) {                                \
        [array addObject:___arg];                   \
        ___arg = va_arg(___args, id);               \
    }                                               \
    va_end(___args);                                \

NSString *OCReversedStringWithParts(NSString *firstPart, ...) {
    va_args_array(array, firstPart);
    return OCReversedStringWithPartsArray(array);
}

NSString *OCReversedStringWithPartsArray(NSArray<NSString *> *parts) {
    return [[[parts reverseObjectEnumerator] allObjects] componentsJoinedByString:@""];
}

SEL OCSelectorFromReversedStringParts(NSString *firstPart, ...) {
    va_args_array(array, firstPart);
    return NSSelectorFromString(OCReversedStringWithPartsArray(array));
}

Class OCClassFromReversedStringParts(NSString *firstPart, ...) {
    va_args_array(array, firstPart);
    return NSClassFromString(OCReversedStringWithPartsArray(array));
}
