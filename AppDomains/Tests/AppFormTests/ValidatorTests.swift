import XCTest
@testable import AppForm

final class ValidatorTests: XCTestCase {
    
    func testEmptyValidator() {
        let validator = EmptyValidator()
        XCTAssertNil(validator.validate("Test"))
        XCTAssertNotNil(validator.validate(""))
        XCTAssertNotNil(validator.validate("   "))
    }
    
    func testEmailValidator() {
        let validator = EmailValidator()
        XCTAssertNil(validator.validate("test@example.com"))
        XCTAssertNil(validator.validate("user.name+tag@example.co.uk"))
        XCTAssertNotNil(validator.validate("invalid"))
        XCTAssertNotNil(validator.validate("@example.com"))
        XCTAssertNotNil(validator.validate("user@"))
        XCTAssertNotNil(validator.validate(""))
    }
    
    func testPhoneNumberValidator() {
        let validator = PhoneNumberValidator()
        XCTAssertNil(validator.validate("1234567890"))
        XCTAssertNil(validator.validate("123"))
        XCTAssertNotNil(validator.validate("123abc"))
        XCTAssertNotNil(validator.validate("12-34"))
        XCTAssertNotNil(validator.validate(""))
    }
    
    func testPromoCodeValidator() {
        let validator = PromoCodeValidator()
        XCTAssertNil(validator.validate("ABC"))
        XCTAssertNil(validator.validate("ABC-DEF"))
        XCTAssertNil(validator.validate("ABCDEFG"))
        XCTAssertNotNil(validator.validate("AB")) // Too short
        XCTAssertNotNil(validator.validate("ABCDEFGH")) // Too long
        XCTAssertNotNil(validator.validate("abc")) // Lowercase
        XCTAssertNotNil(validator.validate("ABC123")) // Numbers
        XCTAssertNotNil(validator.validate("ABÇ")) // Accents
        XCTAssertNotNil(validator.validate(""))
    }
    
    func testDateValidator() {
        let validator = DateValidator()
        let calendar = Calendar.current
        
        // Test nil date
        XCTAssertNotNil(validator.validate(nil))
        
        // Test past date (not Monday)
        let pastDate = calendar.date(byAdding: .day, value: -7, to: Date())!
        let pastWeekday = calendar.component(.weekday, from: pastDate)
        if pastWeekday != 2 {
            XCTAssertNil(validator.validate(pastDate))
        }
        
        // Test future date
        let futureDate = calendar.date(byAdding: .day, value: 1, to: Date())!
        XCTAssertNotNil(validator.validate(futureDate))
        
        // Test Monday
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        while calendar.component(.weekday, from: calendar.date(from: components)!) != 2 {
            components.day! -= 1
        }
        let monday = calendar.date(from: components)!
        XCTAssertNotNil(validator.validate(monday))
    }
}
