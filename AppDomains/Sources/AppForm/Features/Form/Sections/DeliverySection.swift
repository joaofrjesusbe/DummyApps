import SwiftUI

struct DeliverySection: View {
    @ObservedObject var vm: FormViewModel
    @Binding var showDatePicker: Bool
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Data de entrega")
                
                Spacer()
                
                Button(
                    action: {
                        showDatePicker = true
                        vm.markTouched(.delivery)
                    }, label: {
                        Text("Selecionar")
                    })
            }
            
            Text(vm.model.delivery.map {
                DateFormatter.ptShort.string(from: $0)
            } ?? "Não selecionada")
            .foregroundStyle(.secondary)
            
            ErrorText(message: vm.shouldShow(vm.errors.delivery, for: .delivery) ? vm.errors.delivery?.message : nil)
        }
    }
}
