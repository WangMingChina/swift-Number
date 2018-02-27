//
//  Number.swift
//  Number
//
//  Created by HY on 2018/2/27.
//  Copyright © 2018年 XY. All rights reserved.
//

import Foundation


struct Number:Codable{
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self.obj = NSNull()
        }else{
            if let obj = try? container.decode(Bool.self) {
                self.obj = obj
            }else if let obj = try? container.decode(Int.self) {
                self.obj = obj
            }else if let obj = try? container.decode(Double.self) {
                self.obj = obj
            }else if let obj = try? container.decode(String.self) {
                self.obj = obj
            }else{
                self.obj = NSNull()
            }
        }
    }
    func encode(to encoder: Encoder) throws {
        var container =  encoder.singleValueContainer()
        switch self.type {
        case .bool:
            try container.encode(self.rawBool)
        case .double:
            try container.encode(self.rawDouble)
        case .int:
            try container.encode(self.rawInt)
        case .null:
            try container.encodeNil()
        case .string:
            try container.encode(self.rawString)
        }
    }
    init(_ obj:Any) {
        self.obj = obj
    }
    private var obj:Any {
        set{
            switch newValue {
            case let int as Int:
                self.type = Type.int
                self.rawInt = int
            case let double as Double:
                self.type = Type.double
                self.rawDouble = double
            case let string as String:
                self.type = Type.string
                self.rawString = string
            case let bool as Bool:
                self.type = Type.bool
                self.rawBool = bool
            default:
                self.type = Type.null
            }
        }
        get{
            switch self.type {
            case .bool:
                return self.rawBool
            case .double:
                return self.rawDouble
            case .int:
                return self.rawInt
            case .string:
                return self.rawString
            default:
                return self.rawNull
            }
        }
    }
    private var type   = `Type`.null
    private var rawInt = 0
    private var rawDouble:Double = 0
    private var rawBool:Bool = false
    private var rawString:String = ""
    private var rawNull:NSNull = NSNull()
    private enum `Type` : Int {
        case string
        case bool
        case int
        case double
        case null
    }
}
extension Number:ExpressibleByBooleanLiteral{
    init(booleanLiteral value: Bool) {
        self.obj = value
    }
    typealias BooleanLiteralType = Bool
    
    var bool:Bool?{
        get {
            switch self.type {
            case .bool:
                return self.rawBool
            default:
                return nil
            }
        }
        set(value){
            if let value = value {
                self.obj = value
            }else{
                self.obj = NSNull()
            }
        }
    }
    
    var boolValue:Bool{
        get {
            switch self.type {
            case .int:
                let int = self.rawInt as NSNumber
                return int.boolValue
            case .bool:
                return self.rawBool
            case .double:
                let double = self.rawDouble as NSNumber
                return double.boolValue
            case .string:
                return ["true", "y", "t", "yes", "1"].contains { self.rawString.caseInsensitiveCompare($0) == .orderedSame }
            case .null:
                return false
            }
        }
        set(value){
            self.obj = value
        }
    }
}


extension Number:ExpressibleByStringLiteral{
    typealias StringLiteralType = String
    
    init(stringLiteral value: String) {
        self.obj = value
    }
    
    var string:String?{
        get {
            switch self.type {
            case .string:
                return self.rawString
            default:
                return nil
            }
        }
        set(value){
            if let value = value {
                self.obj = value
            }else{
                self.obj = NSNull()
            }
        }
    }
    var stringValue:String{
        get {
            switch self.type {
            case .int:
                let int = self.rawInt as NSNumber
                return int.stringValue
            case .bool:
                let bool = self.rawBool as NSNumber
                return bool.stringValue
            case .double:
                let double = self.rawDouble as NSNumber
                return double.stringValue
            case .string:
                return self.rawString
            case .null:
                return ""
            }
        }
        set(value){
            self.obj = value
        }
    }
    
}
extension Number:ExpressibleByIntegerLiteral{
    init(integerLiteral value: Int) {
        self.obj = value
    }
    typealias IntegerLiteralType = Int
    
    var int:Int?{
        get {
            switch self.type {
            case .int:
                return self.rawInt
            default:
                return nil
            }
        }
        set(value){
            if let value = value {
                self.obj = value
            }else{
                self.obj = NSNull()
            }
        }
    }
    var intValue:Int{
        get {
            switch self.type {
            case .int:
                return self.rawInt
            case .bool:
                let bool = self.rawBool as NSNumber
                return bool.intValue
            case .double:
                let double = self.rawDouble as NSNumber
                return double.intValue
            case .string:
                let decimal = NSDecimalNumber(string: self.rawString)
                if decimal == NSDecimalNumber.notANumber {  // indicates parse error
                    return NSDecimalNumber.zero.intValue
                }
                return decimal.intValue
            case .null:
                return 0
            }
        }
        set(value){
            self.obj = value
        }
    }
    
}

extension Number:ExpressibleByFloatLiteral{
    init(floatLiteral value: Double) {
        self.obj = value
    }
    typealias FloatLiteralType = Double
    
    var double:Double?{
        get {
            switch self.type {
            case .double:
                return self.rawDouble
            default:
                return nil
            }
        }
        set(value){
            if let value = value {
                self.obj = value
            }else{
                self.obj = NSNull()
            }
        }
    }
    
    var doubleValue:Double{
        get {
            switch self.type {
            case .int:
                return Double(self.rawInt)
            case .bool:
                let bool = self.rawBool as NSNumber
                return bool.doubleValue
            case .double:
                return self.rawDouble
            case .string:
                let decimal = NSDecimalNumber(string: self.rawString)
                if decimal == NSDecimalNumber.notANumber {
                    return NSDecimalNumber.zero.doubleValue
                }
                return decimal.doubleValue
            case .null:
                return 0
            }
        }
        set(value){
            self.obj = value
        }
    }
}

extension Number:CustomStringConvertible {
    var description: String {
        switch self.type {
        case .int:
            return String(self.intValue)
        case .bool:
            return String(self.boolValue)
        case .string:
            return self.rawString
        case .double:
            return String(self.doubleValue)
        case .null:
            return "null"
        }
    }
}
extension Number:CustomDebugStringConvertible{
    var debugDescription: String{
        switch self.type {
        case .int:
            return String(self.intValue)
        case .bool:
            return String(self.boolValue)
        case .string:
            return self.rawString
        case .double:
            return String(self.doubleValue)
        case .null:
            return "null"
        }
    }
}


