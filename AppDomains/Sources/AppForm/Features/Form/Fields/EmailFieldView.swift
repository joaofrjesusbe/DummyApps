import SwiftUI

struct EmailFieldView: View {
    @Binding var text: String
    let error: String?
    var focusedField: FocusState<FormFieldType?>.Binding
    let onValidate: () -> Void
    
    var body: some View {
        FormField(
            label: NSLocalizedString("field_email", bundle: .module, comment: ""),
            error: error
        ) {
            TextField("", text: $text)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .focused(focusedField, equals: .email)
                .onChange(of: text) { _, _ in
                    onValidate()
                }
                .id(FormFieldType.email)
        }
    }
}
