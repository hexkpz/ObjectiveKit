//
//  Created by Anton Spivak
//

@_exported import ObjectiveKit

// MARK: - NSObject Convenience

public extension NSObject {

    /// Returns `true` if the receiver's class name starts with an underscore,
    /// indicating it is likely a private/system framework class.
    var isKindOfSystemClass: Bool { oc_isKindOfSystemClass() }
}

// MARK: - NSException Convenience

public extension NSException {

    /// Converts this Objective-C exception into a Swift `Error` (backed by `NSError`).
    var asError: any Error { oc_error() }
}

// MARK: - Exception Handling

/// Executes the given closure inside an Objective-C `@try`/`@catch` block.
///
/// If the closure triggers an `NSException`, it is caught and re-thrown as a Swift error.
///
/// ```swift
/// try withExceptionHandler {
///     // Objective-C code that may raise an NSException
/// }
/// ```
public func withExceptionHandler(_ body: () -> Void) throws {
    try OCExceptionHandler.perform(body)
}
