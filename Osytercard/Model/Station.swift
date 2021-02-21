import Foundation

/// A station on the TfL network
struct Station {

    // MARK: Properties

    var name: String

    // MARK: Lifecycle methods

    init(name: String) {
        self.name = name
    }
}
