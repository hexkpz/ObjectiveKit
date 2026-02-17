//
//  Created by Anton Spivak
//

#ifndef _OBJECTIVEKIT_H
#define _OBJECTIVEKIT_H

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// Marks a symbol as exported with C linkage (prevents C++ name mangling).
#ifndef _OC_EXPORT
#ifndef __cplusplus
#define _OC_EXPORT extern
#else
#define _OC_EXPORT extern "C"
#endif // !__cplusplus
#endif // !_OC_EXPORT

// Marks a symbol as exported with default visibility and C linkage.
#ifndef _OC_EXTERN
#ifndef __cplusplus
#define _OC_EXTERN extern __attribute__((visibility ("default")))
#else
#define _OC_EXTERN extern "C" __attribute__((visibility ("default")))
#endif // !__cplusplus
#endif // !_OC_EXTERN

// Annotates Objective-C methods that bridge to Swift as throwing functions.
// Uses `swift_error(nonnull_error)` so that a non-nil NSError* is treated as a thrown error.
#ifndef _OC_SWIFT_ERROR
#if __OBJC__ && __has_attribute(swift_error)
#define _OC_SWIFT_ERROR __attribute__((swift_error(nonnull_error)));
#else
#error "ObjectiveKit requires an Objective-C compiler with swift_error attribute support."
#endif // __OBJC__ && __has_attribute(swift_error)
#endif // !_OC_SWIFT_ERROR

#define OC_EXPORT       _OC_EXPORT
#define OC_EXTERN       _OC_EXTERN
#define OC_SWIFT_ERROR  _OC_SWIFT_ERROR

#endif // !_OBJECTIVEKIT_H
