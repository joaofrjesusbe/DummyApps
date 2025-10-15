import Foundation

struct EmptyValidator: StringValidator {
    func validate(_ value: String) -> String? {
        value.trimmingCharacters(in: .whitespaces).isEmpty ?
        NSLocalizedString("error_empty", comment: "") : nil
    }
}

struct EmailValidator: StringValidator {
    func validate(_ value: String) -> String? {
        if value.trimmingCharacters(in: .whitespaces).isEmpty {
            return NSLocalizedString("error_empty", comment: "")
        }
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: value) ? nil :
        NSLocalizedString("error_email", comment: "")
    }
}

struct PhoneNumberValidator: StringValidator {
    func validate(_ value: String) -> String? {
        if value.isEmpty {
            return NSLocalizedString("error_empty", comment: "")
        }
        return value.allSatisfy(\.isNumber) ? nil :
        NSLocalizedString("error_phone", comment: "")
    }
}

struct PromoCodeValidator: StringValidator {
    func validate(_ value: String) -> String? {
        if value.isEmpty {
            return NSLocalizedString("error_empty", comment: "")
        }
        let allowedCharacters = CharacterSet.uppercaseLetters.union(CharacterSet(charactersIn: "-"))
        let valueCharSet = CharacterSet(charactersIn: value)
        
        guard allowedCharacters.isSuperset(of: valueCharSet),
              value.count >= 3,
              value.count <= 7,
              value.unicodeScalars.allSatisfy({ $0.value < 128 || CharacterSet.uppercaseLetters.contains($0) }) else {
            return NSLocalizedString("error_promo", comment: "")
        }
        return nil
    }
}

struct DateValidator {
    func validate(_ date: Date) -> String? {
        let calendar = Calendar.current
        
        // Check if Monday
        let weekday = calendar.component(.weekday, from: date)
        if weekday == 2 { // Sunday = 1, Monday = 2
            return NSLocalizedString("error_date_monday", comment: "")
        }
        
        // Check if future
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfSelectedDay = calendar.startOfDay(for: date)
        if startOfSelectedDay > startOfToday {
            return NSLocalizedString("error_date_future", comment: "")
        }
        
        return nil
    }
}
