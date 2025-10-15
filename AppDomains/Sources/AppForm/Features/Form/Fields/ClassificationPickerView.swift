import SwiftUI

struct ClassificationPickerView: View {
    @Binding var selection: Classification
    
    var body: some View {
        Picker(
            NSLocalizedString("field_classification", comment: ""),
            selection: $selection
        ) {
            ForEach(Classification.allCases) { classification in
                Text(classification.localizedString)
                    .tag(classification)
            }
        }
    }
}
