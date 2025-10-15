import SwiftUI

public struct NavigationItem {
    public let icon: String
    public let text: LocalizedStringResource
    
    public init(icon: String, text: LocalizedStringResource) {
        self.icon = icon
        self.text = text
    }
}

@MainActor
public protocol NavigationRepresentable: View {
    
    var navigationItem: NavigationItem { get }
}
