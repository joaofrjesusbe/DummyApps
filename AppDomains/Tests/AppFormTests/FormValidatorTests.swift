//
//  FormValidatorTests.swift
//  AppDomains
//
//  Created by Joao Jesus on 15/10/2025.
//


import XCTest


final class FormValidatorTests: XCTestCase {
    let validator = FormValidator()
    
    
    func testEmailValidation() {
        XCTAssertTrue(validator.isValidEmail("user@example.com"))
        XCTAssertFalse(validator.isValidEmail("user@"))
        XCTAssertFalse(validator.isValidEmail("userexample.com"))
    }
    
    
    func testSanitizeDigits() {
        XCTAssertEqual(validator.sanitizeDigits("a1b2c3"), "123")
    }
    
    
    func testSanitizePromoRemovesAccentsAndEnforcesRules() {
        XCTAssertEqual(validator.sanitizePromo("áb-cd"), "AB-CD")
        XCTAssertEqual(validator.sanitizePromo("--ab__cd--"), "AB-CD")
        XCTAssertEqual(validator.sanitizePromo("abcde"), "ABCDE")
    }
    
    
    func testPromoRegexLengthAndCharset() {
        let vm = FormViewModel(validator: validator)
        vm.model.nome = "A"
        vm.model.email = "a@a.com"
        vm.model.numero = "1"
        vm.model.classificacao = .bom
        vm.model.dataEntrega = Date()
        
        
        vm.model.codigoPromocional = "AB" // too short
        vm.validate()
        XCTAssertNotNil(vm.errors.codigo)
        
        
        vm.model.codigoPromocional = "ABCDEFGH" // too long
        vm.validate()
        XCTAssertNotNil(vm.errors.codigo)
        
        
        vm.model.codigoPromocional = "ABC-DEF" // valid
        vm.validate()
        XCTAssertNil(vm.errors.codigo)
    }
    
    
    func testDateRules() {
        let vm = FormViewModel(validator: validator)
        vm.model.nome = "A"
        vm.model.email = "a@a.com"
        vm.model.numero = "1"
        vm.model.codigoPromocional = "ABC"
        vm.model.classificacao = .bom
        
        
        // A Monday in the past (e.g., 2024-12-02)
        var comps = DateComponents(year: 2024, month: 12, day: 2)
        let monday = Calendar.current.date(from: comps)!
        vm.model.dataEntrega = monday
        vm.validate(now: Date(timeIntervalSince1970: 1733100000))
        XCTAssertNotNil(vm.errors.data)
        
        
        // Future date
        let future = Date().addingTimeInterval(60 * 60)
        vm.model.dataEntrega = future
        vm.validate()
        XCTAssertNotNil(vm.errors.data)
    }
}
