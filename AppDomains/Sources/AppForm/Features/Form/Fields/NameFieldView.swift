import SwiftUI

struct NameFieldView: View {
    @Binding var text: String
    let error: String?
    @FocusState.Binding var focusedField: FormFieldType?
    let onValidate: () -> Void
    
    var body: some View {
        FormField(
            label: NSLocalizedString("field_name", bundle: .module, comment: ""),
            error: error
        ) {
            TextField("", text: $text)
                .textContentType(.name)
                #if os(iOS)
                .textInputAutocapitalization(.words)
                #endif
                .focused($focusedField, equals: .name)
                .onChange(of: text) { _, _ in
                    onValidate()
                }
                .id(FormFieldType.name)
        }
    }
}
