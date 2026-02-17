//
//  Created by Anton Spivak
//

#import "_ObjectiveKit.h"

NS_ASSUME_NONNULL_BEGIN

// MARK: - Method Swizzling

/// Swizzles two instance methods within the same class.
OC_EXPORT void OCSwizzleInstanceMethodOfClass(Class aClass, SEL original, SEL swizzled);

/// Swizzles an instance method of `aClass` with an instance method of `bClass`.
OC_EXPORT void OCSwizzleInstanceMethodOfClasses(Class aClass, SEL aSelector, Class bClass, SEL bSelector);

/// Swizzles two class methods within the same class.
OC_EXPORT void OCSwizzleMethodOfClass(Class aClass, SEL original, SEL swizzled);

/// Swizzles a class method of `aClass` with a class method of `bClass`.
OC_EXPORT void OCSwizzleMethodOfClasses(Class aClass, SEL aSelector, Class bClass, SEL bSelector);

// MARK: - Reversed String Utilities

/// Builds a string by concatenating the given parts in reverse order.
///
/// Useful for constructing class or selector names at runtime in a way that avoids
/// static analysis detection (e.g., private API usage).
/// The argument list must be nil-terminated.
OC_EXPORT NSString *OCReversedStringWithParts(NSString *firstPart, ...) NS_REQUIRES_NIL_TERMINATION;

/// Builds a string by concatenating the elements of `parts` in reverse order.
OC_EXPORT NSString *OCReversedStringWithPartsArray(NSArray<NSString *> *parts);

/// Builds a selector from nil-terminated string parts concatenated in reverse order.
OC_EXPORT SEL OCSelectorFromReversedStringParts(NSString *firstPart, ...) NS_REQUIRES_NIL_TERMINATION;

/// Looks up a class whose name is built from nil-terminated string parts concatenated in reverse order.
OC_EXPORT Class _Nullable OCClassFromReversedStringParts(NSString *firstPart, ...) NS_REQUIRES_NIL_TERMINATION;

NS_ASSUME_NONNULL_END
