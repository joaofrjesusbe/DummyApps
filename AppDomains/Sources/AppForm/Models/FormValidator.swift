import Foundation

final class FormValidator: FormValidating {
    
    private let emailRegex: NSRegularExpression = {
        // A pragmatic email regex (not fully RFC5322) suitable for form validation
        // Matches local@domain.tld with common characters
        let pattern = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        return try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
    }()
        
    func isValidEmail(_ email: String) -> Bool {
        let range = NSRange(email.startIndex..<email.endIndex, in: email)
        return emailRegex.firstMatch(in: email, options: [], range: range) != nil
    }
    
    func sanitizeDigits(_ input: String) -> String {
        input.filter { $0.isNumber }
    }
    
    func sanitizePromo(_ input: String) -> String {
        // Remove diacritics, force uppercase, keep only A-Z and hyphen, collapse consecutive hyphens
        let folded = input.folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: .current)
        let upper = folded.uppercased()
        let filtered = upper.filter { ($0 >= "A" && $0 <= "Z") || $0 == "-" }
        // Remove leading/trailing hyphens and collapse multiples
        let collapsed = filtered.replacingOccurrences(of: "-+", with: "-", options: .regularExpression)
            .trimmingCharacters(in: CharacterSet(charactersIn: "-"))
        return collapsed
    }
    
    func validate(model: FormModel, now: Date = Date()) -> FormErrors {
        var errors = FormErrors()
        
        if model.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.name = FieldError(message: "O nome não pode estar vazio.")
        }
        
        if model.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.email = FieldError(message: "O email não pode estar vazio.")
        } else if !isValidEmail(model.email) {
            errors.email = FieldError(message: "Formato de email inválido.")
        }
        
        if model.number.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.number = FieldError(message: "O número não pode estar vazio.")
        } else if !model.number.allSatisfy({ $0.isNumber }) {
            errors.number = FieldError(message: "O número deve conter apenas dígitos.")
        }
        
        let codigo = model.promotionalCode
        if codigo.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors.promotionalCode = FieldError(message: "O código não pode estar vazio.")
        } else {
            let regex = try! NSRegularExpression(pattern: "^[A-Z-]{3,7}$")
            let range = NSRange(codigo.startIndex..<codigo.endIndex, in: codigo)
            let matches = regex.firstMatch(in: codigo, options: [], range: range) != nil
            if !matches {
                errors.promotionalCode = FieldError(message: "O código deve ter 3–7 caracteres, apenas letras maiúsculas e hífens, sem acentos.")
            }
        }
        
        if let date = model.delivery {
            let cal = Calendar.current
            if cal.component(.weekday, from: date) == 2 { // Monday = 2 in Gregorian
                errors.delivery = FieldError(message: "A data não pode ser uma segunda-feira.")
            }
            if date > now {
                errors.delivery = FieldError(message: "A data não pode estar no futuro.")
            }
        } else {
            errors.delivery = FieldError(message: "A data não pode estar vazia.")
        }
    
        if model.classification == nil {
            errors.classification = FieldError(message: "Selecione uma classificação.")
        }
        
        return errors
    }
}
