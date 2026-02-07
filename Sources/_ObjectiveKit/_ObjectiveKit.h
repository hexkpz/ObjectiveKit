//
//  Created by Anton Spivak
//

#ifndef _OBJECTIVEKIT_H
#define _OBJECTIVEKIT_H

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#ifndef _OC_EXPORT
#ifndef __cplusplus
#define _OC_EXPORT extern
#else
#define _OC_EXPORT extern "C"
#endif // !__cplusplus
#endif // !_OC_EXPORT


#ifndef _OC_EXTERN
#ifndef __cplusplus
#define _OC_EXTERN extern __attribute__((visibility ("default")))
#else
#define _OC_EXTERN extern "C" __attribute__((visibility ("default")))
#endif // !__cplusplus
#endif // !_OC_EXTERN

#ifndef _OC_SWIFT_ERROR
#if __OBJC__ && __has_attribute(swift_error)
#define _OC_SWIFT_ERROR __attribute__((swift_error(nonnull_error)));
#else
#abort();
#endif // __OBJC__ && __has_attribute(swift_error)
#endif // !_OC_SWIFT_ERROR

#define OC_EXPORT       _OC_EXPORT
#define OC_EXTERN       _OC_EXTERN
#define OC_SWIFT_ERROR  _OC_SWIFT_ERROR

#endif // !_OBJECTIVEKIT_H
