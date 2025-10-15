import SwiftUI

struct FormContentView: View {
    @ObservedObject var viewModel: FormViewModel
    @FocusState.Binding var focusedField: FormFieldType?
    
    var body: some View {
        ScrollViewReader { proxy in
            Form {
                PersonalInfoSection(
                    viewModel: viewModel,
                    focusedField: $focusedField
                )
                
                DeliverySection(viewModel: viewModel)
                
                SubmitButtonSection(
                    isEnabled: viewModel.isSubmitEnabled,
                    action: viewModel.submit
                )
            }
            .navigationTitle(NSLocalizedString("form_title", bundle: .module, comment: ""))
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: focusedField) { _, field in
                if let field = field {
                    withAnimation {
                        proxy.scrollTo(field, anchor: .center)
                    }
                }
            }
        }
    }
}
