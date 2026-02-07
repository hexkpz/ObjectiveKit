//
//  Created by Anton Spivak
//

import _ObjectiveKit

public extension NSObject {
    var isKindOfSystemClass: Bool { oc_isKindOfSystemClass() }
}

public extension NSException {
    var asError: any Error { oc_error() }
}

public func withExceptionHandler(_ body: () -> Void) throws {
    try OCExceptionHandler.perform(body)
}
