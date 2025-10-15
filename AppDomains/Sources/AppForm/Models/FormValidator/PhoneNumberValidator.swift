import Foundation

struct PhoneNumberValidator: StringValidator {
    func validate(_ value: String) -> String? {
        if value.isEmpty {
            return NSLocalizedString("error_empty", bundle: .module, comment: "")
        }
        return value.allSatisfy(\.isNumber) ? nil :
        NSLocalizedString("error_phone", bundle: .module, comment: "")
    }
}
