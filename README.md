# ObjectiveKit

A lightweight Swift package that bridges Objective-C runtime capabilities to Swift, providing safe exception handling, method swizzling, and runtime introspection utilities.

## Requirements

- Swift 6.2+
- Apple platforms (macOS, iOS, tvOS, watchOS, visionOS)

## Installation

### Swift Package Manager

Add ObjectiveKit to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/hexkpz/ObjectiveKit.git", branch: "0.2.0")
]
```

Then add the dependency to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "_ObjectiveKit", package: "ObjectiveKit")
    ]
)
```

> Use the `_ObjectiveKit` product for the full Swift API. The `ObjectiveKit` product exposes only the raw Objective-C interface.

## Usage

### Exception Handling

Catch Objective-C `NSException`s as Swift errors:

```swift
import _ObjectiveKit

do {
    try withExceptionHandler {
        // Objective-C code that may raise an NSException
    }
} catch {
    print("Caught exception: \(error)")
}
```

Convert an `NSException` to a Swift `Error` directly:

```swift
let error = exception.asError
```

### System Class Detection

Check whether an object belongs to a private/system framework class (class name starts with `_`):

```swift
let view: NSObject = ...
if view.isKindOfSystemClass {
    // Private system class
}
```

### Method Swizzling

Swizzle instance methods within a single class:

```swift
OCSwizzleInstanceMethodOfClass(
    MyClass.self,
    #selector(MyClass.originalMethod),
    #selector(MyClass.swizzledMethod)
)
```

Swizzle instance methods across two classes:

```swift
OCSwizzleInstanceMethodOfClasses(
    ClassA.self, #selector(ClassA.method),
    ClassB.self, #selector(ClassB.method)
)
```

Class method equivalents are also available:

```swift
OCSwizzleMethodOfClass(MyClass.self, #selector(MyClass.originalClassMethod), #selector(MyClass.swizzledClassMethod))
OCSwizzleMethodOfClasses(ClassA.self, #selector(ClassA.classMethod), ClassB.self, #selector(ClassB.classMethod))
```

### Reversed String Utilities

Build class names and selectors from string parts concatenated in **reverse order** at runtime. This is useful for referencing private API symbols in a way that avoids static analysis detection — the final name never appears as a single string literal in the binary.

#### Building strings

Parts are joined last-to-first:

```swift
// ["World", "Hello"] → reversed → ["Hello", "World"] → "HelloWorld"
let str = OCReversedStringWithParts("World", "Hello", nil)
// str == "HelloWorld"

// Array-based variant
let str2 = OCReversedStringWithPartsArray(["ller", "Contro", "View"])
// str2 == "ViewController"
```

#### Resolving selectors

```swift
// Goal: obtain @selector(setStatusBarHidden:animated:)
// Split the name into parts and pass them in reverse order:
let sel = OCSelectorFromReversedStringParts(
    "animated:",      // last
    "setStatusBarHidden:",  // first (reversed → becomes first in result)
    nil
)
// sel == @selector(setStatusBarHidden:animated:)
```

#### Resolving classes

```swift
// Goal: obtain the class _UIStatusBarManager
let cls = OCClassFromReversedStringParts(
    "Manager",        // last
    "StatusBar",      // ↑
    "_UI",            // first (reversed → becomes first in result)
    nil
)
// cls == _UIStatusBarManager.class (or nil if not found)
```

#### Combining with swizzling

```swift
// Swizzle a private method resolved at runtime
let privateSel = OCSelectorFromReversedStringParts("Style", "_barTint", nil)
// privateSel == @selector(_barTintStyle)

OCSwizzleInstanceMethodOfClass(
    UINavigationBar.self,
    privateSel,
    #selector(UINavigationBar.myBarTintStyle)
)
```

## API Reference

### Swift API (`_ObjectiveKit`)

| API | Description |
|-----|-------------|
| `withExceptionHandler(_:) throws` | Executes a closure inside `@try`/`@catch`, re-throwing exceptions as Swift errors |
| `NSObject.isKindOfSystemClass: Bool` | Whether the receiver's class name starts with `_` |
| `NSException.asError: Error` | Converts an Objective-C exception to a Swift error |

### Objective-C API (`ObjectiveKit`)

| API | Description |
|-----|-------------|
| `OCExceptionHandler` | Class that bridges `@try`/`@catch` to Swift error handling |
| `NSException.oc_error` | Converts an exception to `NSError` with full debug info |
| `NSException.oc_raiseExceptionWithName:reason:userInfo:` | Convenience method to raise an exception |
| `NSObject.oc_isKindOfSystemClass` | Whether the class name starts with `_` |
| `OCSwizzleInstanceMethodOfClass()` | Swizzle two instance methods within one class |
| `OCSwizzleInstanceMethodOfClasses()` | Swizzle instance methods across two classes |
| `OCSwizzleMethodOfClass()` | Swizzle two class methods within one class |
| `OCSwizzleMethodOfClasses()` | Swizzle class methods across two classes |
| `OCReversedStringWithParts()` | Build a string from nil-terminated parts in reverse order |
| `OCReversedStringWithPartsArray()` | Build a string from an array of parts in reverse order |
| `OCSelectorFromReversedStringParts()` | Build a selector from reversed string parts |
| `OCClassFromReversedStringParts()` | Look up a class from reversed string parts |

## Contact

hexkpz@gmail.com

## License

MIT License. See [LICENSE](LICENSE) for details.
