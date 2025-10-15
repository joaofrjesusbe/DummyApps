import SwiftUI

public struct ValidatedFormView: View {
    @State private var data = FormData()
    @State private var errors: [FormError] = []
    @FocusState private var focusedField: Field?
    
    enum Field { case name, email, number, promo }

    public init() {        
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Group {
                    TextField("Name", text: $data.name).textContentType(.name).submitLabel(.next).focused($focusedField, equals: .name)
                    TextField("Email", text: $data.email).textContentType(.emailAddress).keyboardType(.emailAddress).submitLabel(.next).focused($focusedField, equals: .email)
                    TextField("Number (digits only)", text: $data.number).keyboardType(.numberPad).focused($focusedField, equals: .number)
                    TextField("Promo (A-Z and hyphens, 3–7)", text: $data.promo).textInputAutocapitalization(.characters).autocorrectionDisabled().focused($focusedField, equals: .promo)
                }
                .textFieldStyle(.roundedBorder)

                DatePicker("Delivery date", selection: $data.date.unwrap(or: Date()), displayedComponents: .date)
                    .datePickerStyle(.compact)

                Picker("Classification", selection: $data.rating) {
                    ForEach(FormRating.allCases, id: \.self) { rating in
                        Text(rating.textDescription).tag(rating.rawValue)
                    }
                }
                .pickerStyle(.menu)

                Button(action: validate) {
                    Text("Submit").frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

                if !errors.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(errors.indices, id: \.self) { i in
                            Text("• " + (errors[i].errorDescription ?? "Invalid"))
                                .foregroundStyle(.red)
                        }
                    }
                    .padding(.top, 4)
                    .accessibilityElement(children: .combine)
                }
            }
            .padding()
        }
        .navigationTitle("Formulário")
        .onTapGesture { hideKeyboard() }
    }

    private func validate() {
        errors = FormValidator.validate(form: data)
        if errors.isEmpty {
            // For demo purposes, show a success alert
            // In a real app, you'd submit this to a backend
#if canImport(UIKit)
            let alert = UIAlertController(title: "Success", message: "Form is valid!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            UIApplication.shared.connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .first?.rootViewController?.present(alert, animated: true)
#endif
        }
    }
}

extension View {
    func hideKeyboard() {
#if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
#endif
    }
}

extension Binding {
    /// Returns a non-optional Binding by providing a default value when the source is nil.
    /// The setter writes back to the optional, allowing `nil` if the provided transform chooses to.
    func unwrap<T>(or defaultValue: @autoclosure @escaping () -> T) -> Binding<T> where Value == T? {
        Binding<T>(
            get: { self.wrappedValue ?? defaultValue() },
            set: { self.wrappedValue = $0 }
        )
    }
}
