import SwiftUI

struct PhoneFieldView: View {
    @Binding var text: String
    let error: String?
    @FocusState.Binding var focusedField: FormFieldType?
    let onValidate: () -> Void
    
    var body: some View {
        FormField(
            label: NSLocalizedString("field_phone", comment: ""),
            error: error
        ) {
            TextField("", text: $text)
                .textContentType(.telephoneNumber)
                .keyboardType(.numberPad)
                .focused($focusedField, equals: .phone)
                .onChange(of: text) { _, _ in
                    onValidate()
                }
                .id(FormFieldType.phone)
        }
    }
}
