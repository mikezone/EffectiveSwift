//
//  runtime.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/24.
//  Copyright © 2017年 Mike. All rights reserved.
//

import Foundation

public enum EncodingType: UInt8 {
    case mask       = 0xFF ///< mask of type value
    case unknown    = 0 ///< unknown
    case void       = 1 ///< void
    case bool       = 2 ///< bool
    case int8       = 3 ///< char / BOOL
    case uInt8      = 4 ///< unsigned char
    case int16      = 5 ///< short
    case uInt16     = 6 ///< unsigned short
    case int32      = 7 ///< int
    case uInt32     = 8 ///< unsigned int
    case int64      = 9 ///< long long
    case uInt64     = 10 ///< unsigned long long
    case float      = 11 ///< float
    case double     = 12 ///< double
    case longDouble = 13 ///< long double
    case object     = 14 ///< id
    case `class`    = 15 ///< Class
    case SEL        = 16 ///< SEL
    case block      = 17 ///< block
    case pointer    = 18 ///< void*
    case `struct`   = 19 ///< struct
    case union      = 20 ///< union
    case cString    = 21 ///< char*
    case cArray     = 22 ///< char[10] (for example)
}

public enum Qualifier: UInt8 {
    case unknown    = 0 ///< unknown
    case mask       = 0xFF ///< mask of qualifier
    case const      = 1 ///< const
    case `in`       = 2 ///< in
    case `inout`    = 4 ///< inout
    case `out`      = 8 ///< out
    case bycopy     = 16 ///< bycopy
    case byref      = 32 ///< byref
    case oneway     = 64 ///< oneway
}

public enum PropertyType: UInt8 {
    case unknown    = 0 ///< unknown
    case mask       = 0xFF ///< mask of property
    case readonly   = 1 ///< readonly
    case copy       = 2 ///< copy
    case retain     = 4 ///< retain
    case nonatomic  = 8 ///< nonatomic
    case weak       = 16 ///< weak
    case customGetter   = 32 ///< getter=
    case customSetter   = 64 ///< setter=
    case dynamic        = 128 ///< @dynamic
}

public class ClassInfo {
    public private(set) var cls: AnyClass!
    public private(set) var superCls: AnyClass!
    public private(set) var metaCls: AnyClass!
    public private(set) var isMeta: Bool!
    public private(set) var name: String!
    public private(set) var superClassInfo: ClassInfo!
    
    public private(set) var ivarInfos: [String : ClassIvarInfo]! ///< key: ivar name
    public private(set) var methodInfos: [String : ClassMethodInfo]! ///< key: method name
    public private(set) var propertyInfos: [String : ClassPropertyInfo]! ///< key: property name
    
    private var needUpdate: Bool = false
    private init() {}
    
    public convenience init(_ cls: AnyClass) {
        self.init()
        self.cls = cls
        superCls = class_getSuperclass(cls)
        isMeta = class_isMetaClass(cls)
        if !isMeta {
            metaCls = objc_getMetaClass(class_getName(cls)) as! AnyClass!
        }
        name = NSStringFromClass(cls)
        update()
        
//        superClassInfo = [Self classInfoWithClass:_superCls]/
        superClassInfo = ClassInfo.classInfo(class: superCls)
    }
    
    public class func classInfo(`class`: AnyClass) -> ClassInfo {
        return ClassInfo(`class`)
    }
    
    private func update() {
        var methodCount: UInt32 = 0
        if let methods = class_copyMethodList(cls, &methodCount) {
            methodInfos = [:]
            for i in 0..<methodCount {
                guard let method = methods[Int(i)] else {continue}
                let methodInfo = ClassMethodInfo(method)
                if methodInfo.name != nil {
                    methodInfos[methodInfo.name] = methodInfo
                }
            }
            free(methods)
        }
        var propertyCount: UInt32 = 0
        if let properties = class_copyPropertyList(cls, &propertyCount) {
            propertyInfos = [:]
            for i in 0..<propertyCount {
                guard let property = properties[Int(i)] else {continue}
                let propertyInfo = ClassPropertyInfo(property)
                if propertyInfo.name != nil {
                    propertyInfos[propertyInfo.name] = propertyInfo
                }
            }
            free(properties)
        }
        
        var ivarCount: UInt32 = 0
        if let ivars = class_copyPropertyList(cls, &ivarCount) {
            ivarInfos = [:]
            for i in 0..<ivarCount {
                guard let ivar = ivars[Int(i)] else {continue}
                let ivarInfo = ClassIvarInfo(ivar)
                if ivarInfo.name != nil {
                    ivarInfos[ivarInfo.name] = ivarInfo
                }
            }
            free(ivars)
        }
        needUpdate = false
    }
}

public class ClassMethodInfo {
    public private(set) var method: Method!
    public private(set) var name: String! ///< method name
    public private(set) var sel: Selector! ///< method's selector
    public private(set) var imp: IMP! ///< method's implementation
    public private(set) var typeEncoding: String! ///< method's parameter and return types
    public private(set) var returnTypeEncoding: String! ///< return value's type
    public private(set) var argumentTypeEncodings: [String]? ///< array of arguments' type
    
    private init() {}
    
    public convenience init(_ method: Method) {
        self.init()
        self.method = method
        sel = method_getName(method)
        imp = method_getImplementation(method)
        if let cName = sel_getName(sel) {
            name = String(cString: cName)
        }
        if let typeEncoding = method_getTypeEncoding(method) {
            self.typeEncoding = String(cString: typeEncoding)
        }
        if let returnType = method_copyReturnType(method) {
            self.returnTypeEncoding = String(cString: returnType)
            free(returnType)
        }
        let argumentCount = method_getNumberOfArguments(method)
        if argumentCount > 0 {
            argumentTypeEncodings = []
            for i in 0..<argumentCount {
                if let argumentType = method_copyArgumentType(method, i) {
                    argumentTypeEncodings?.append(String(cString: argumentType))
                }
            }
        }
    }
}

public class ClassIvarInfo {
    public private(set) var ivar: Ivar!
    public private(set) var name: String! ///< Ivar's name
    public private(set) var offset: ptrdiff_t! ///< Ivar's offset
    public private(set) var typeEncoding: String! ///< Ivar's type encoding
    public private(set) var type: EncodingType! ///< Ivar's type
    public private(set) var qualifier: Qualifier! ///< Ivar's reference type
    
    private init() {}
    
    public convenience init(_ ivar: Ivar) {
        self.init()
        self.ivar = ivar
        let cName = ivar_getName(ivar)
        if cName != nil {
            name = String(cString: cName!)
        }
        offset = ivar_getOffset(ivar)
        if let cTypeEncoding = ivar_getTypeEncoding(ivar) {
            self.typeEncoding = String(cString: cTypeEncoding)
            let result = getTypeEncoding(typeEncoding: cTypeEncoding)
            type = result.0
            qualifier = result.1
        }
    }
}

public class ClassPropertyInfo {
    public private(set) var property: objc_property_t!
    public private(set) var name: String! ///< property's name
    public private(set) var typeEncoding: String! ///< property's encoding value
    public private(set) var type: EncodingType! ///< property's type
    public private(set) var qualifier: Qualifier!
    public private(set) var propertyType: PropertyType!
    public private(set) var ivarName: String? ///< property's ivar name
    public private(set) var cls: AnyClass? ///< may be nil
    public private(set) var getter: String? ///< getter (nonnull)
    public private(set) var setter: String? ///< setter (nonnull)
    
    private init() {}
    
    public convenience init(_ property: objc_property_t) {
        self.init()
        self.property = property
        if let cName = property_getName(property) {
            name = String(cString: cName)
        }
        
        var attrCount: UInt32 = 0
        if let attrs = property_copyAttributeList(property, &attrCount) {
            for i in 0..<attrCount {
                let pointer = UnsafeMutablePointer<UInt8>.allocate(capacity: 1)
                let value = attrs[Int(i)].name[0]
                pointer.pointee = UInt8(value)
                let string = String(cString: pointer)
                free(pointer)
                switch string {
                case "T": // Type encoding
                    typeEncoding = String(cString: attrs[Int(i)].value)
                    let result = getTypeEncoding(typeEncoding: attrs[Int(i)].value)
                    type = result.0
                    qualifier = result.1
                    if type == .object {
                        let len = strlen(attrs[Int(i)].value)
                        let name = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(len - 2))
                        memcpy(name, attrs[Int(i)].value + 2, Int(len - 3))
                        cls = NSClassFromString(String(cString: name))
//                        cls = objc_getClass(name)
                    }
                case "V": // Instance variable
                    ivarName = String(cString: attrs[Int(i)].value)
                case "R":
                    propertyType = .readonly
                case "C":
                    propertyType = .copy
                case "&":
                    propertyType = .retain
                case "N":
                    propertyType = .nonatomic
                case "D":
                    propertyType = .dynamic
                case "W":
                    propertyType = .weak
                case "G":
                    propertyType = .customGetter
                    getter = String(cString: attrs[Int(i)].value)
                case "S":
                    propertyType = .customSetter
                    setter = String(cString: attrs[Int(i)].value)
                default:
                    break
                }
//                free(attrs)
            }
        }
    }
}

func getTypeEncoding(typeEncoding: UnsafePointer<Int8>) -> (EncodingType, Qualifier) {
    let len = strlen(typeEncoding)
    guard len > 0 else { return (.unknown, .unknown)}
    
    var qualifier: Qualifier = .unknown
    var prefix = true
    var flag: UInt = 0
    while flag < len && prefix {
        switch String(typeEncoding[Int(flag)]) {
        case "r":
            qualifier = .const
            flag += 1
        case "n":
            qualifier = .in
            flag += 1
        case "N":
            qualifier = .inout
            flag += 1
        case "o":
            qualifier = .out
            flag += 1
        case "O":
            qualifier = .bycopy
            flag += 1
        case "R":
            qualifier = .byref
            flag += 1
        case "V":
            qualifier = .oneway
            flag += 1
        default:
            prefix = false
            break
        }
    }
    
    guard flag < len else { return (.unknown, qualifier)}
    
    var encodingType: EncodingType = .unknown
    switch String(typeEncoding[Int(flag)]) {
    case "v":
        encodingType = .void
    case "B":
        encodingType = .bool
    case "c":
        encodingType = .int8
    case "C":
        encodingType = .uInt8
    case "s":
        encodingType = .int16
    case "S":
        encodingType = .uInt16
    case "i":
        encodingType = .int32
    case "I":
        encodingType = .uInt32
    case "l":
        encodingType = .int32
    case "L":
        encodingType = .uInt32
    case "q":
        encodingType = .int64
    case "Q":
        encodingType = .uInt64
    case "f":
        encodingType = .float
    case "d":
        encodingType = .double
    case "D":
        encodingType = .longDouble
    case "#":
        encodingType = .class
    case ":":
        encodingType = .SEL
    case "*":
        encodingType = .cString
    case "^":
        encodingType = .pointer
    case "[":
        encodingType = .cArray
    case "(":
        encodingType = .union
    case "{":
        encodingType = .struct
    case "@":
        if (len - flag == 2) && String(typeEncoding[Int(flag + 1)]) == "?" {
            encodingType = .block
        } else {
            encodingType = .object
        }
    default:
        break
    }
    return (encodingType, qualifier)
}
