import Foundation

struct PromoCodeValidator: StringValidator {
    func validate(_ value: String) -> String? {
        if value.isEmpty {
            return NSLocalizedString("error_empty", bundle: .module, comment: "")
        }
        // Only ASCII uppercase letters A-Z and hyphen, 3–7 chars, no accents
        let isValidCharset = value.allSatisfy { ch in
            (ch >= "A" && ch <= "Z") || ch == "-"
        }
        guard isValidCharset,
              value.count >= 3,
              value.count <= 7 else {
            return NSLocalizedString("error_promo", bundle: .module, comment: "")
        }
        return nil
    }
}
