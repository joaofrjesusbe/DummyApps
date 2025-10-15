import SwiftUI

struct RatingSection: View {
    @ObservedObject var vm: FormViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Picker("Classificação", selection: Binding(
                get: { vm.model.classification },
                set: { vm.model.classification = $0; vm.markTouched(.classification) }
            )) {
                Text("Selecione…").tag(Rating?.none)
                ForEach(Rating.allCases) { r in Text(r.rawValue).tag(Rating?.some(r)) }
            }
            .pickerStyle(.menu)
            
            ErrorText(message: vm.shouldShow(vm.errors.classification, for: .classification) ? vm.errors.classification?.message : nil)
        }
    }
}
