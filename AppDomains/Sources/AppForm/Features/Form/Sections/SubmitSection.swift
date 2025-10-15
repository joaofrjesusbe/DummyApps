import SwiftUI

struct SubmitSection: View {
    @ObservedObject var vm: FormViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button("Submeter") {
                vm.submit()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            if let msg = vm.submissionMessage {
                Text(msg).foregroundStyle(.green)
            }
        }
    }
}
