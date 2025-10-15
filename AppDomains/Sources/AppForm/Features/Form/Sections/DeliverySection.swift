import SwiftUI

struct DeliverySection: View {
    @ObservedObject var viewModel: FormViewModel
    
    var body: some View {
        Section {
            DeliveryDateFieldView(
                date: $viewModel.formData.deliveryDate,
                error: viewModel.dateError,
                onValidate: viewModel.validateDate
            )
            
            ClassificationPickerView(
                selection: $viewModel.formData.classification
            )
        }
    }
}
