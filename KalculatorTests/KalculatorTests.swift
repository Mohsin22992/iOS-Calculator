//  Created by Adil Saleem on 31/10/2023.
//  Copyright © 2023 Jogendra Singh. All rights reserved.

import XCTest
@testable import Kalculator

final class KalculatorTests: XCTestCase
{
    var calculator: Calculator!
    var viewController: ViewController!
    
override func setUpWithError() throws 
{
   super.setUp()
   calculator = Calculator()
 
   let storyboard = UIStoryboard(name: "Main", bundle: nil)
   viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
   _ = viewController.view
}

    override func tearDownWithError() throws 
{
        calculator = nil
        super.tearDown()
    }

func testInputInvalidDigit()
{
       let invalidDigitButton = UIButton()
        invalidDigitButton.setTitle("Welcome", for: .normal)
         viewController.inputDigit(invalidDigitButton)
         XCTAssertEqual(viewController.resultScreen.text, "invalid")
    }
}
    func testInputDigitPositive()
 {
        let result = try? calculator.inputDigit("7")
        XCTAssertEqual(result, "7")
    }

    func testInputDigitNegative() 
{
        XCTAssertThrowsError(try calculator.inputDigit("2c")) { error in
            XCTAssertEqual(error as? CalculatorError, CalculatorError.invalidDigit)
        }
    }
    func testAppendPositive()
{
        try? calculator.appendDigit("5")
        try? calculator.appendDigit("6")        
        XCTAssertEqual(try? calculator.inputDigit("="), "56")
    }
    
    func testAppendNegative() 
{
        try? calculator.appendDigit("22")
        XCTAssertThrowsError(try calculator.inputDigit("C32")) 
{ error in
            XCTAssertEqual(error as? CalculatorError, CalculatorError.invalidDigit)
        }
    }


    func testClearPostive() 
{
        try? calculator.inputDigit("1")
        calculator.clear()
        XCTAssertEqual(try? calculator.inputDigit("="), "0")
    }

    func testClearNegative() 
{
        calculator.clear()
        XCTAssertNotEqual(try? calculator.inputDigit("="), "")
  }

func testAddtionPositive() 
{
        try? calculator.inputDigit("10")
        try? calculator.performOperation(.add)
        try? calculator.inputDigit("20")
        try? calculator.performOperation(.equals)
        XCTAssertEqual(try? calculator.inputDigit("="), "30")
    }
    
    func testAdditionNegative() {
        try? calculator.inputDigit("15")
        try? calculator.performOperation(.add)
        try? calculator.inputDigit("15")
        try? calculator.performOperation(.equals)
        XCTAssertNotEqual(try? calculator.inputDigit("="), "25")
    }
    
    func testSubtractionPositive() {
        try? calculator.inputDigit("8")
        try? calculator.performOperation(.subtract)
        try? calculator.inputDigit("4")
        try? calculator.performOperation(.equals)
        XCTAssertEqual(try? calculator.inputDigit("="), "4")
    }
    
    func testSubtractionNegative() {
        try? calculator.inputDigit("12")
        try? calculator.performOperation(.subtract)
        try? calculator.inputDigit("11")
        try? calculator.performOperation(.equals)
        XCTAssertNotEqual(try? calculator.inputDigit("="), "2")
    }
    
func testMultiplicationPositive() 
{
        try? calculator.inputDigit("6")
        try? calculator.performOperation(.multiply)
        try? calculator.inputDigit("3")
        try? calculator.performOperation(.equals)
        XCTAssertEqual(try? calculator.inputDigit("="), "18")
    }
    
    func testMultiplicationNegative() 
{
        try? calculator.inputDigit("2")
        try? calculator.performOperation(.multiply)
        try? calculator.inputDigit("2")
        try? calculator.performOperation(.equals)
        XCTAssertNotEqual(try? calculator.inputDigit("="), "5")
    }
    
    func testDivisionPositive() 
{
        try? calculator.inputDigit("9")
        try? calculator.performOperation(.divide)
        try? calculator.inputDigit("3")
        try? calculator.performOperation(.equals)
        XCTAssertEqual(try? calculator.inputDigit("="), "3")
    }
    
    func testDivisionNegative() 
{
        try? calculator.inputDigit("15")
        try? calculator.performOperation(.divide)
        try? calculator.inputDigit("3")
        try? calculator.performOperation(.equals)
        XCTAssertNotEqual(try? calculator.inputDigit("="), "4")
    }
    
    func testDivisionByZero() {
        try? calculator.inputDigit("4")
        try? calculator.performOperation(.divide)
        try? calculator.inputDigit("0")
        XCTAssertThrowsError(try calculator.performOperation(.equals)) { error in
            XCTAssertEqual(error as? CalculatorError, CalculatorError.illegalOperation)
        }
    }
        
    
    func testInputDigit() 
{
        let digitButton = UIButton()
        digitButton.setTitle("30", for: .normal)
         viewController.inputDigit(digitButton)
        
        XCTAssertEqual(viewController.resultScreen.text, "30")
    }
    
    func testClearOfViewController() 
{
        viewController.resultScreen.text = "18"
        viewController.clear(UIButton())
        XCTAssertEqual(viewController.resultScreen.text, "0")
}
