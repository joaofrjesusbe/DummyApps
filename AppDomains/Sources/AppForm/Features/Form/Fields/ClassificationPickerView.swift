import SwiftUI

struct ClassificationPickerView: View {
    @Binding var selection: Classification?
    
    var body: some View {
        Picker(
            NSLocalizedString("field_classification", bundle: .module, comment: ""),
            selection: $selection
        ) {
            Text(NSLocalizedString("select_classification", bundle: .module, comment: ""))
                .tag(nil as Classification?)
            ForEach(Classification.allCases) { classification in
                Text(classification.localizedString)
                    .tag(classification as Classification?)
            }
        }
    }
}
