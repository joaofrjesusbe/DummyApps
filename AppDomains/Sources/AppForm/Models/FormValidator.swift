
import Foundation

struct FormValidator {

    static func validate(form: FormData) -> [FormError] {
        var errors: [FormError] = []

        if form.name.isFieldEmpty() { errors.append(.empty("Name")) }
        if form.email.isFieldEmpty() { errors.append(.empty("Email")) }
        if form.number.isFieldEmpty() { errors.append(.empty("Number")) }
        if form.promo.isFieldEmpty() { errors.append(.empty("Promo code")) }

        // email regex (simple RFC 5322-ish)
        let emailRegex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}"#
        if !NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: form.email) {
            errors.append(.invalidEmail)
        }

        // number: digits only
        if form.number.range(of: #"^\d+$"#, options: .regularExpression) == nil {
            errors.append(.invalidNumber)
        }

        // promo: 3-7 chars, uppercase letters and hyphens, no accents
        let folded = form.promo.folding(options: .diacriticInsensitive, locale: .current)
        if folded != form.promo { errors.append(.invalidPromo) }
        if form.promo.range(of: #"^[A-Z-]{3,7}$"#, options: .regularExpression) == nil {
            errors.append(.invalidPromo)
        }

        // date: not Monday, not in future
        if let date = form.date {
            let cal = Calendar.current
            if cal.component(.weekday, from: date) == 2 { // 1=Sun, 2=Mon
                errors.append(.invalidDate("Date cannot be a Monday"))
            }
            if date > Date() {
                errors.append(.invalidDate("Date cannot be in the future"))
            }
        } else {
            errors.append(.invalidDate("Please select a date"))
        }

        return errors
    }
}

fileprivate extension String {
    func isFieldEmpty() -> Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
