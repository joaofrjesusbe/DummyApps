import SwiftUI

struct PersonalInfoSection: View {
    @ObservedObject var viewModel: FormViewModel
    @FocusState.Binding var focusedField: FormFieldType?
    
    var body: some View {
        Section {
            NameFieldView(
                text: $viewModel.formData.name,
                error: viewModel.nameError,
                focusedField: $focusedField,
                onValidate: viewModel.validateName
            )
            
            EmailFieldView(
                text: $viewModel.formData.email,
                error: viewModel.emailError,
                focusedField: $focusedField,
                onValidate: viewModel.validateEmail
            )
            
            PhoneFieldView(
                text: $viewModel.formData.phoneNumber,
                error: viewModel.phoneError,
                focusedField: $focusedField,
                onValidate: viewModel.validatePhone
            )
            
            PromoCodeFieldView(
                text: $viewModel.formData.promoCode,
                error: viewModel.promoError,
                focusedField: $focusedField,
                onValidate: viewModel.validatePromoCode
            )
        }
    }
}
