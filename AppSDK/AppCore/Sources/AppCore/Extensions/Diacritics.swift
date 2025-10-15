import Foundation

public extension String {
    
    var foldingDiacriticsLowercased: String {
        self.folding(options: .diacriticInsensitive, locale: .current).lowercased()
    }
}
