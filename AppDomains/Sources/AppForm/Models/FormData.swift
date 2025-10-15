import Foundation

// TODO: Remove the Rating presentation from the model
enum Rating: String, CaseIterable, Identifiable {
    case bad = "Mau"
    case satisfy = "Satisfatório"
    case good = "Bom"
    case average = "Muito Bom"
    case excelent = "Excelente"
    var id: String { rawValue }
}

struct FormModel: Equatable {
    var name: String = ""
    var email: String = ""
    var number: String = "" // digits only, is this a phone number?
    var promotionalCode: String = "" // uppercase letters and hyphens only
    var delivery: Date? = nil
    var classification: Rating? = nil
}

struct FieldError: Identifiable, Equatable {
    let id = UUID()
    let message: String
}

struct FormErrors: Equatable {
    var name: FieldError? = nil
    var email: FieldError? = nil
    var number: FieldError? = nil
    var promotionalCode: FieldError? = nil
    var delivery: FieldError? = nil
    var classification: FieldError? = nil
    
    var all: [FieldError] {
        [name, email, number, promotionalCode, delivery, classification].compactMap { $0 }
    }
}

// Tracks if the user interacted with a field (for runtime/dirty validation)
struct FormTouched: Equatable {
    var name = false
    var email = false
    var number = false
    var promotionalCode = false
    var delivery = false
    var classification = false
}
