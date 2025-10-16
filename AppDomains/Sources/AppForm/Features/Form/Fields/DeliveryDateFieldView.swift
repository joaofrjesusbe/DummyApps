import SwiftUI

// Note: Refactor this to use a graphical picker but adding an overlay to deal with empty date
struct DeliveryDateFieldView: View {
    @Binding var date: Date?
    let error: String?
    let onValidate: () -> Void

    @State private var showingPicker = false
    @State private var tempDate: Date = Date()

    var body: some View {
        FormField(
            label: NSLocalizedString("field_date", bundle: .module, comment: ""),
            error: error
        ) {
            HStack {
                Text(
                    date.map {
                        DateFormatter.localizedString(from: $0, dateStyle: .medium, timeStyle: .none)
                    } ?? ""
                )
                .foregroundColor(date == nil ? .secondary : .primary)
                Spacer()
                Button(action: {
                    tempDate = date ?? Date()
                    showingPicker = true
                }) {
                    Text(date == nil ?
                         NSLocalizedString("choose", bundle: .module, comment: "") :
                            NSLocalizedString("change", bundle: .module, comment: "")
                    )
                }
            }
        }
        .sheet(isPresented: $showingPicker) {
            NavigationStack {
                VStack {
                    DatePicker(
                        "",
                        selection: $tempDate,
                        in: ...Date(),
                        displayedComponents: .date
                    )
                    #if os(iOS)
                    .datePickerStyle(.wheel)
                    #endif
                    .labelsHidden()
                    .padding()
                    Spacer()
                }
                .navigationTitle(Text(NSLocalizedString("field_date", bundle: .module, comment: "")))
                #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                #endif
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(NSLocalizedString("cancel", bundle: .module, comment: "")) {
                            showingPicker = false
                        }
                    }
                    ToolbarItem(placement: .destructiveAction) {
                        if date != nil {
                            Button(NSLocalizedString("clear", bundle: .module, comment: "")) {
                                date = nil
                                onValidate()
                                showingPicker = false
                            }
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(NSLocalizedString("ok", bundle: .module, comment: "")) {
                            date = tempDate
                            onValidate()
                            showingPicker = false
                        }
                    }
                }
            }
        }
    }
}
