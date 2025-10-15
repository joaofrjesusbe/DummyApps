import SwiftUI

struct ContactSection: View {
    @ObservedObject var vm: FormViewModel
    @Binding var focused: FormFeatureView.FocusField?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField("Email", text: $vm.model.email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                //.focused($focused, equals: .email)
                .onChange(of: vm.model.email) { _, _ in
                    vm.markTouched(.email)
                }
                .onSubmit { focused = .number }
            
            ErrorText(message: vm.shouldShow(vm.errors.email, for: .email) ? vm.errors.email?.message : nil)
            
            
            TextField("Número (apenas dígitos)", text: Binding(
                get: {
                    vm.model.number
                },
                set: {
                    vm.onChangeNumber($0)
                    vm.markTouched(.number)
                }
            ))
            .keyboardType(.numberPad)
            //.focused($focused, equals: .number)
            .onSubmit { focused = .promotionalCode }
            ErrorText(
                message: vm.shouldShow(vm.errors.number, for: .number) ?
                vm.errors.number?.message : nil
            )
            
            TextField("Código promocional (A–Z e hífens)", text: Binding(
                get: {
                    vm.model.promotionalCode
                },
                set: {
                    vm.onChangePromotionalCode($0)
                    vm.markTouched(.promotionalCode)
                }
            ))
            .textInputAutocapitalization(.characters)
            .autocorrectionDisabled()
            //.focused($focused, equals: .promotionalCode)
            ErrorText(message: vm.shouldShow(vm.errors.promotionalCode, for: .promotionalCode) ? vm.errors.promotionalCode?.message : nil)
        }
    }
}
