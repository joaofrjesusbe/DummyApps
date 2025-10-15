import Foundation

enum AppMode {
    case listAndDetail
    case form

    static func current() -> AppMode {
        let args = ProcessInfo.processInfo.arguments
        return args.contains("--form-only") ? .form : .listAndDetail
    }
}
