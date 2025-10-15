import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Search products…", text: $text)
            .textFieldStyle(.roundedBorder)
            #if os(iOS)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            #endif
            .padding(.horizontal)
    }
}
