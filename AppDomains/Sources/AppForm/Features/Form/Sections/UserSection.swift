import SwiftUI

struct UserSection: View {
    @ObservedObject var vm: FormViewModel
    @Binding var focused: FormFeatureView.FocusField?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField("Nome do utilizador", text: $vm.model.name)
                .textContentType(.name)
                .textInputAutocapitalization(.words)
                //.focused($focused, equals: .name)
                .onChange(of: vm.model.name) { _, _ in
                    vm.markTouched(.name)
                }
                .onSubmit { focused = .email }
            
            ErrorText(message: vm.shouldShow(vm.errors.name, for: .name) ? vm.errors.name?.message : nil)
        }
    }
}
