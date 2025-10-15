import SwiftUI

enum FormFieldType: Hashable {
    case name, email, phone, promo
}

struct FormView: View {
    @StateObject private var viewModel = FormViewModel()
    @FocusState private var focusedField: FormFieldType?
    
    var body: some View {        
        FormContentView(
            viewModel: viewModel,
            focusedField: $focusedField
        )
    }
}
