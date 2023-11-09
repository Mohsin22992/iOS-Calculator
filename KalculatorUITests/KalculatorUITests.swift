//  Created by Adil Saleem on 31/10/2023.
//  Copyright © 2023 Jogendra Singh. All rights reserved.

import XCTest

final class KalculatorUITests: XCTestCase 
{

    let app = XCUIApplication()
    
    override func setUpWithError() throws 
{
        super.setUp()
        app.launch()
	continueAfterFailure = false
}

    override func tearDownWithError() throws 
{
        
        super.tearDown()
    }
    
    func testButtonsExist() throws
{
    
      for i in 0...9 
{
            XCTAssertNotNil(app.buttons["\(i)"], "Button for \(i) not wokring.")
        }
        
        let operators = ["+", "-", "*", "/", "="]
        for operatorSymbol in operators {
            XCTAssertNotNil(app.buttons[operatorSymbol], "Button for '\(operatorSymbol)' is not working.")
        }
        
    }
    
    func testOutputDisplay() {
  
        app.buttons["1"].tap()
        app.buttons["/"].tap()
        app.buttons["1"].tap()
        app.buttons["="].tap()

  
        let resultLabel = app.staticTexts["result"]
   
        XCTAssertEqual(resultLabel.label, "1", "Result is not displayed as expected")
    
        app.buttons["+"].tap()
        app.buttons["1"].tap()
        app.buttons["="].tap()

        let errorLabel = app.staticTexts["result"]
        XCTAssertEqual(errorLabel.label, "invalid", "Result is not displayed as expected")
    
    }
    
    func testClearButton() 
{
        app.buttons["1"].tap()
        app.buttons["C"].tap()

        let result = app.staticTexts["result"]
        XCTAssertEqual(result.label, "0")
    }
    
}