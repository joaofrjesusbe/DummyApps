import Foundation

protocol FormValidating {
    func validate(model: FormModel, now: Date) -> FormErrors
    func isValidEmail(_ email: String) -> Bool
    func sanitizeDigits(_ input: String) -> String
    func sanitizePromo(_ input: String) -> String
}
