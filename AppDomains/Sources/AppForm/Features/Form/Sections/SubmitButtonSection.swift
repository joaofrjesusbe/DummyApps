import SwiftUI

struct SubmitButtonSection: View {
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Section {
            Button(action: action) {
                HStack {
                    Spacer()
                    Text(NSLocalizedString("submit_button", comment: ""))
                        .fontWeight(.semibold)
                    Spacer()
                }
            }
            .disabled(!isEnabled)
        }
    }
}
