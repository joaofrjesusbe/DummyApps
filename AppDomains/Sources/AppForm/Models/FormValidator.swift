import Foundation

struct EmptyValidator: StringValidator {
    func validate(_ value: String) -> String? {
        value.trimmingCharacters(in: .whitespaces).isEmpty ?
        NSLocalizedString("error_empty", bundle: .module, comment: "") : nil
    }
}

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

struct PhoneNumberValidator: StringValidator {
    func validate(_ value: String) -> String? {
        if value.isEmpty {
            return NSLocalizedString("error_empty", bundle: .module, comment: "")
        }
        return value.allSatisfy(\.isNumber) ? nil :
        NSLocalizedString("error_phone", bundle: .module, comment: "")
    }
}

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

class DateValidator {
    func validate(_ date: Date?) -> String? {
        guard let date = date else {
            return NSLocalizedString("error_empty", bundle: .module, comment: "")
        }
        
        let calendar = Calendar.current
        
        // Check if Monday
        let weekday = calendar.component(.weekday, from: date)
        if weekday == 2 { // Sunday = 1, Monday = 2
            return NSLocalizedString("error_date_monday", bundle: .module, comment: "")
        }
        
        // Check if future
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfSelectedDay = calendar.startOfDay(for: date)
        if startOfSelectedDay > startOfToday {
            return NSLocalizedString("error_date_future", bundle: .module, comment: "")
        }
        
        return nil
    }
}
