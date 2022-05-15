//
//  main.swift
//  字面量协议和模式匹配案例
//
//  Created by zhangwenyi on 2022/5/15.
//

import Foundation

print("Hello, World!")

extension Int : ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = value ? 1 : 0
    }
}
var num: Int = true
print("WY:",num)//WY: 1

//值绑定模式
let point = (3, 2)
switch point {
case let (x, y):
    print("The point is at (\(x), \(y)).")
}

//元组模式
func test1() {
    let name: String? = "jack"
    let age = 18
    let info: Any = [1, 2]
    switch (name, age, info) {
    case (_?, _ , _ as String):
        print("case")
    default:
        print("default")
    } // default
}
//枚举Case模式
func test2() {
    let age = 2
    // 原来的写法
    if age >= 0 && age <= 9 {
        print("[0, 9]")
    }
    // 枚举Case模式
    if case 0...9 = age {
        print("[0, 9]")
    }
    guard case 0...9 = age else { return }
    print("[0, 9]")
    //等价switch case
    switch age {
    case 0...9: print("[0, 9]")
    default: break
    }
    //for case
    let ages: [Int?] = [2, 3, nil, 5]
    for case nil in ages {
        print("有nil值")
        break
    } // 有nil值
    
    let points = [(1, 0), (2, 1), (3, 0)]
    for (x, y) in points {
        print(x, y)
    }
    for (x, _) in points {
        print(x)
    }
    //带0，必须加case
    for case let (x, 0) in points {
        print(x)
    }
}
//可选模式
func test3() {
    let age: Int? = 42
    if case .some(let x) = age {
        print(x)
    }
    if case let x? = age {
        print(x)
    }
}

//类型转换模式
func test4() {
    let num: Any = 6
    switch num {
    case is Int:
        // 编译器虽然可以判断Int型，依然认为num是Any类型
        print("is Int", num)
        //此时就会直接强转成Int型
        //case let n as Int:
        //    print("as Int", n + 1)
    default:
        break
    }
}

//表达式模式
func test5() {
    let point = (1, 2)
    switch point {
    case (0, 0):
        print("(0, 0) is at the origin.")
        //这里就是表达式模式
    case (-2...2, -2...2):
        print("(\(point.0), \(point.1)) is near the origin.")
    default:
        print("The point is at (\(point.0), \(point.1)).")
    } // (1, 2) is near the  origin.
}

//自定义表达式模式
//func test6() {
//    struct Student {
//        var score = 0, name = ""
//        static func ~= (pattern: Int, value: Student) -> Bool { value.score >= pattern }
//        static func ~= (pattern: ClosedRange<Int>, value: Student) -> Bool { pattern.contains(value.score) }
//        static func ~= (pattern: Range<Int>, value: Student) -> Bool { pattern.contains(value.score) }
//    }
//
//    var stu = Student(score: 75, name: "Jack")
//    switch stu {
//    case 100: print(">= 100")
//    case 90: print(">= 90")
//    case 80..<90: print("[80, 90)")
//    case 60...79: print("[60, 79]")
//    case 0: print(">= 0")
//    default: break
//    } // [60, 79]
//}

//where模式
func test7() {
    var data = (10, "Jack")
    switch data {
    case let (age, _) where age > 10:
        print(data.1, "age>10")
    case let (age, _) where age > 0:
        print(data.1, "age>0")
    default: break
    }
}
