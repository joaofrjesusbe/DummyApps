import SwiftUI

struct FormFeatureView: View {
    @StateObject private var vm = FormViewModel()
    @FocusState private var focused: FocusField?
    @State private var showDatePicker = false
    
    enum FocusField: Hashable { case name, email, number, promotionalCode }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Utilizador") {
                    UserSection(vm: vm, focused: $focused)
                }
                Section("Contacto") {
                    ContactSection(vm: vm, focused: $focused)
                }
                Section("Entrega") {
                    DeliverySection(vm: vm, showDatePicker: $showDatePicker)
                }
                Section("Classificação") {
                    RatingSection(vm: vm)
                }
                Section {
                    SubmitSection(vm: vm)
                }
            }
            .navigationTitle("Formulário")
            .onChange(of: vm.model) { _ in vm.validateRuntime() }
            .sheet(isPresented: $showDatePicker) { DatePickerSheet(vm: vm) }
        }
    }
}
