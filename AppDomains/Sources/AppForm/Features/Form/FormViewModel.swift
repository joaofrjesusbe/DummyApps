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
        // Recompute submit availability when form data changes
        $formData
            .sink { [weak self] _ in self?.recomputeSubmitEnabled() }
            .store(in: &cancellables)
        // Initial compute
        recomputeSubmitEnabled()
    }

    private func recomputeSubmitEnabled() {
        let data = formData
        isSubmitEnabled =
            nameError == nil &&
            emailError == nil &&
            phoneError == nil &&
            promoError == nil &&
            dateError == nil &&
            !data.name.isEmpty &&
            !data.email.isEmpty &&
            !data.phoneNumber.isEmpty &&
            !data.promoCode.isEmpty &&
            data.deliveryDate != nil &&
            data.classification != nil
    }
    
    func validateName() {
        nameError = nameValidator.validate(formData.name)
        recomputeSubmitEnabled()
    }
    
    func validateEmail() {
        emailError = emailValidator.validate(formData.email)
        recomputeSubmitEnabled()
    }
    
    func validatePhone() {
        phoneError = phoneValidator.validate(formData.phoneNumber)
        recomputeSubmitEnabled()
    }
    
    func validatePromoCode() {
        promoError = promoValidator.validate(formData.promoCode)
        recomputeSubmitEnabled()
    }
    
    func validateDate() {
        dateError = dateValidator.validate(formData.deliveryDate)
        recomputeSubmitEnabled()
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
