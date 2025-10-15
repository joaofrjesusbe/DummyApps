import Foundation

struct FormData {
    var name: String = ""
    var email: String = ""
    var number: String = ""
    var promo: String = ""
    var date: Date? = nil
    var rating: FormRating = .excelent
}

enum FormRating: Int, CaseIterable {
    case bad = 0
    case satisfy
    case good
    case veryGood
    case excelent
    
    var textDescription: String {
        switch self {
        case .bad: "Mau"
        case .satisfy: "Satisfatório"
        case .good: "Bom"
        case .veryGood: "Muito Bom"
        case .excelent: "Excelente"
        }
    }    
}

enum FormError: LocalizedError {
    case empty(String)
    case invalidEmail
    case invalidNumber
    case invalidPromo
    case invalidDate(String)

    var errorDescription: String? {
        switch self {
        case .empty(let f): return "\(f) can't be empty"
        case .invalidEmail: return "Invalid email"
        case .invalidNumber: return "Number must contain only digits"
        case .invalidPromo: return "Promo code must be 3–7 chars, uppercase letters and hyphens only, no accents"
        case .invalidDate(let r): return r
        }
    }
}
