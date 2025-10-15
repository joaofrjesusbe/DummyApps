import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Search products…", text: $text)
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(.horizontal)
    }
}
