import SwiftUI
import Combine

@MainActor
class FormViewModel: ObservableObject {
    @Published var formData = FormData()
    @Published var nameError: String?
    @Published var emailError: String?
    @Published var phoneError: String?
    @Published var promoError: String?
    @Published var dateError: String?
    @Published var isSubmitEnabled = false
    
    private let nameValidator = EmptyValidator()
    private let emailValidator = EmailValidator()
    private let phoneValidator = PhoneNumberValidator()
    private let promoValidator = PromoCodeValidator()
    private let dateValidator = DateValidator()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupValidation()
    }
    
    private func setupValidation() {
        // Combine all field validations to enable/disable submit button
        Publishers.CombineLatest3(
            Publishers.CombineLatest4(
                $nameError,
                $emailError,
                $phoneError,
                $promoError
            ),
            $dateError,
            $formData
        )
        .map { firstFour, dateErr, data in
            let (nameErr, emailErr, phoneErr, promoErr) = firstFour
            
            return nameErr == nil &&
            emailErr == nil &&
            phoneErr == nil &&
            promoErr == nil &&
            dateErr == nil &&
            !data.name.isEmpty &&
            !data.email.isEmpty &&
            !data.phoneNumber.isEmpty &&
            !data.promoCode.isEmpty &&
            data.deliveryDate != nil &&
            data.classification != nil
        }
        .assign(to: &$isSubmitEnabled)
    }
    
    func validateName() {
        nameError = nameValidator.validate(formData.name)
    }
    
    func validateEmail() {
        emailError = emailValidator.validate(formData.email)
    }
    
    func validatePhone() {
        phoneError = phoneValidator.validate(formData.phoneNumber)
    }
    
    func validatePromoCode() {
        promoError = promoValidator.validate(formData.promoCode)
    }
    
    func validateDate() {
        dateError = dateValidator.validate(formData.deliveryDate)
    }
    
    func submit() {
        guard let deliveryDate = formData.deliveryDate,
              let classification = formData.classification else {
            return
        }
        
        print("Form submitted successfully!")
        print("Name: \(formData.name)")
        print("Email: \(formData.email)")
        print("Phone: \(formData.phoneNumber)")
        print("Promo: \(formData.promoCode)")
        print("Date: \(deliveryDate)")
        print("Classification: \(classification.localizedString)")
    }
}
