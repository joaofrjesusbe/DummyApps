import SwiftUI

struct ErrorText: View {
    let message: String?
    
    var body: some View {
        // Prevent UI flicker: reserve space and only change visibility without implicit animations.
        Text(message ?? " ")
            .font(.footnote)
            .foregroundStyle(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 18, alignment: .topLeading)
            .opacity(message == nil ? 0 : 1)
            .accessibilityHidden(message == nil)
    }
}
