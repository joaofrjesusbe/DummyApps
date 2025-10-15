import SwiftUI

struct DatePickerSheet: View {
    @ObservedObject var vm: FormViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker(
                    "Selecione a data",
                    selection: Binding(
                        get: { vm.model.delivery ?? Date() },
                        set: { vm.model.delivery = $0; vm.markTouched(.delivery) }
                    ),
                    in: ...Date(),
                    displayedComponents: [.date]
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding()
                Spacer()
            }
            .toolbar { ToolbarItem(placement: .confirmationAction) { Button("OK") { dismiss() } } }
            .navigationTitle("Data de entrega")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
