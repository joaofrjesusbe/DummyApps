import Foundation

struct EmptyValidator: StringValidator {
    func validate(_ value: String) -> String? {
        value.trimmingCharacters(in: .whitespaces).isEmpty ?
        NSLocalizedString("error_empty", bundle: .module, comment: "") : nil
    }
}
