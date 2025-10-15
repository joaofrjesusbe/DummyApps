import SwiftUI
import Combine

@MainActor
final class FormViewModel: ObservableObject {
    @Published var model = FormModel()
    @Published var errors = FormErrors()
    @Published var touched = FormTouched()
    @Published var submissionMessage: String? = nil
    @Published var submittedOnce = false
    
    private let validator: FormValidating
    enum FieldKey { case name, email, number, promotionalCode, delivery, classification }
    
    init(validator: FormValidating = FormValidator()) {
        self.validator = validator
    }
    
    var canSubmit: Bool {
        errors.all.isEmpty && !modelEqualsEmptyRequired()
    }
    
    func validateRuntime(now: Date = Date()) {
        // Always compute current errors, but views decide what to show.
        errors = validator.validate(model: model, now: now)
    }
    
    func markTouched(_ field: FieldKey) {
        switch field {
        case .name: touched.name = true
        case .email: touched.email = true
        case .number: touched.number = true
        case .promotionalCode: touched.promotionalCode = true
        case .delivery: touched.delivery = true
        case .classification: touched.classification = true
        }
        validateRuntime()
    }
    
    func onChangeNumber(_ value: String) {
        model.number = validator.sanitizeDigits(value)
    }
    
    func onChangePromotionalCode(_ value: String) {
        model.promotionalCode = validator.sanitizePromo(value)
    }
    
    // Decide if an error should be shown (only after user filled / interacted or after first submit)
    func shouldShow(_ error: FieldError?, for key: FieldKey) -> Bool {
        guard let error = error else { return false }
        let valueIsEmpty: Bool = {
            switch key {
            case .name: return model.name.isEmpty
            case .email: return model.email.isEmpty
            case .number: return model.number.isEmpty
            case .promotionalCode: return model.promotionalCode.isEmpty
            case .delivery: return model.delivery == nil
            case .classification: return model.classification == nil
            }
        }()
        let hasTextOrSelection = !valueIsEmpty
        let touchedField: Bool = {
            switch key {
            case .name: return touched.name
            case .email: return touched.email
            case .number: return touched.number
            case .promotionalCode: return touched.promotionalCode
            case .delivery: return touched.delivery
            case .classification: return touched.classification
            }
        }()
        // Show if: (user has entered something AND it's invalid) OR after first submit (to reveal remaining issues)
        return (touchedField && hasTextOrSelection) || submittedOnce
    }
    
    func visibleErrors() -> [FieldError] {
        var list: [FieldError] = []
        if shouldShow(errors.name, for: .name), let e = errors.name {
            list.append(e)
        }
        if shouldShow(errors.email, for: .email), let e = errors.email {
            list.append(e)
        }
        if shouldShow(errors.number, for: .number), let e = errors.number {
            list.append(e)
        }
        if shouldShow(errors.promotionalCode, for: .promotionalCode), let e = errors.promotionalCode { list.append(e)
        }
        if shouldShow(errors.delivery, for: .delivery), let e = errors.delivery {
            list.append(e)
        }
        if shouldShow(errors.classification, for: .classification), let e = errors.classification { list.append(e) }
        return list
    }
    
    func validate(now: Date = Date()) {
        submittedOnce = true
        validateRuntime(now: now)
        guard visibleErrors().isEmpty else { return }
        submissionMessage = "Formulário enviado com sucesso!"
    }
    
    func submit(now: Date = Date()) {
        validate(now: now)
        guard errors.all.isEmpty else { return }
        // Simulate success
        submissionMessage = "Formulário enviado com sucesso!"
    }
    
    private func modelEqualsEmptyRequired() -> Bool {
        // Helper: if any required field is empty
        model.name.isEmpty ||
        model.email.isEmpty ||
        model.number.isEmpty ||
        model.promotionalCode.isEmpty ||
        model.delivery == nil ||
        model.classification == nil
    }
}
