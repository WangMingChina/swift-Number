//
//  NumberTests.swift
//  NumberTests
//
//  Created by HY on 2018/2/27.
//  Copyright © 2018年 XY. All rights reserved.
//

import XCTest
@testable import Number

class NumberTests: XCTestCase {
  
    var data = try! JSONSerialization.data(withJSONObject: ["age":NSNull(),"name":123], options: JSONSerialization.WritingOptions.prettyPrinted)
    override func setUp() {
        super.setUp()
  
        do {
            let model = try JSONDecoder().decode(XYModel.self, from: data)
            
            print(model)
        } catch  {
            print(error)
        }
       
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        
    }
    
    func testExample() {
       
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
