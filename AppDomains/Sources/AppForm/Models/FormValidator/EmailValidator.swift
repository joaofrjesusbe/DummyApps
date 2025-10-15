import Foundation

struct EmailValidator: StringValidator {
    func validate(_ value: String) -> String? {
        if value.trimmingCharacters(in: .whitespaces).isEmpty {
            return NSLocalizedString("error_empty", bundle: .module, comment: "")
        }
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: value) ? nil :
        NSLocalizedString("error_email", bundle: .module, comment: "")
    }
}
