import Foundation

enum Classification: String, CaseIterable, Identifiable {
    case bad
    case satisfy
    case good
    case veryGood
    case excellent
    
    var id: String { rawValue }
    
    var localizedString: String {
        switch self {
            case .bad: return NSLocalizedString("classification_bad", comment: "")
            case .satisfy: return NSLocalizedString("classification_satisfy", comment: "")
            case .good: return NSLocalizedString("classification_good", comment: "")
            case .veryGood: return NSLocalizedString("classification_very_good", comment: "")
            case .excellent: return NSLocalizedString("classification_excellent", comment: "")
        }
    }
}

struct FormData {
    var name: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var promoCode: String = ""
    var deliveryDate: Date = Date()
    var classification: Classification = .good
}
