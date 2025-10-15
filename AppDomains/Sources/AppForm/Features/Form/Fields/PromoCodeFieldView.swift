import SwiftUI

struct PromoCodeFieldView: View {
    @Binding var text: String
    let error: String?
    @FocusState.Binding var focusedField: FormFieldType?
    let onValidate: () -> Void
    
    var body: some View {
        FormField(
            label: NSLocalizedString("field_promo", bundle: .module, comment: ""),
            error: error
        ) {
            TextField("", text: $text)
                #if os(iOS)
                .textInputAutocapitalization(.characters)
                .autocorrectionDisabled()
                #endif
                .focused($focusedField, equals: .promo)
                .onChange(of: text) { _, _ in
                    onValidate()
                }
                .id(FormFieldType.promo)
        }
    }
}
