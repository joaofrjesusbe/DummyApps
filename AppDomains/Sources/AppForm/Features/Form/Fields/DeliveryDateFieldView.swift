import SwiftUI

struct DeliveryDateFieldView: View {
    @Binding var date: Date?
    let error: String?
    let onValidate: () -> Void
    
    var body: some View {
        FormField(
            label: NSLocalizedString("field_date", bundle: .module, comment: ""),
            error: error
        ) {
            DatePicker(
                "",
                selection: Binding(
                    get: { date ?? Date() },
                    set: { date = $0 }
                ),
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .onChange(of: date) { _, _ in
                onValidate()
            }
        }
    }
}
