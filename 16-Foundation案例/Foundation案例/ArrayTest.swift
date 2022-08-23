//
//  ArrayTest.swift
//  Foundation案例
//
//  Created by zhangwenyi on 2022/5/19.
//

import Foundation

/*
 1、常见操作
 */
func test1(){
    var arr = [1, 2, 3, 4]
    // [2, 4, 6, 8]
    var arr2 = arr.map { $0 * 2 }
    print(arr2)
    // [2, 4]
    var arr3 = arr.filter { $0 % 2 == 0 }
    print(arr3)
    // 10
    var arr4 = arr.reduce(0) { $0 + $1 }
    print(arr4)
    // 10
    var arr5 = arr.reduce(0, +)
    print(arr5)
}

func test2() {
    let arr = [1, 2, 3]
    let result = arr.lazy.map {
    (i: Int) -> Int in
    print("mapping \(i)")
    return i * 2
    }
    print("begin-----")
    print("mapped", result [0])
//    print("mapped", result [1])
    print("mapped", result [2])
    print("end----")
}

//func test3() {
//    var num1: Int? = 10
//    // Optional(Optional(20))
//    var num2 = num1.map { Optional.some($0 * 2) }
//    print(num2)
//    // Optional(20)
//    var num3 = num1.flatMap { Optional.some($0 * 2) }
//    print(num3)
//}

func test3() {
    var arr = [1, 2, 3]
    // [[1], [2, 2], [3, 3, 3]]
    var arr2 = arr.map { Array.init(repeating: $0, count: $0) }
    print(arr2)
    // [1, 2, 2, 3, 3, 3]
    var arr3 = arr.flatMap { Array.init(repeating: $0, count: $0) }
    print(arr3)
}


func test4() {
    var arr = ["123", "test", "jack", "-30"]
    // [Optional(123), nil, nil, Optional(-30)]
    var arr2 = arr.map { Int($0) }
    // [123, -30]
    var arr3 = arr.compactMap { Int($0) }
}

func test5() {
    var num1: Int? = 10
    // Optional(20)
    var num2 = num1.map { $0 * 2 }

    var num3: Int? = nil
    // nil
    var num4 = num3.map { $0 * 2 }
}

func test6() {
    var num1: Int? = 10
    // Optional(Optional(20))
    var num2 = num1.map { Optional.some($0 * 2) }
    // Optional(20)
    var num3 = num1.flatMap { Optional.some($0 * 2) }
}

func test7() {
    var fmt = DateFormatter()
    fmt.dateFormat = "yyyy-MM-dd"
    var str: String? = "2011-09-10"
    // old
    var date1 = str != nil ? fmt.date(from: str!) : nil
    // new
    var date2 = str.flatMap(fmt.date)
}

func test8() {
    struct Person {
    var name: String
    var age: Int
    }
    var items = [
    Person(name: "jack", age: 20),
    Person(name: "rose", age: 21),
    Person(name: "kate", age: 22)
    ]
    // old
    func getPerson1(_ name: String) -> Person? {
    let index = items.firstIndex { $0.name == name }
    return index != nil ? items [index!] : nil
    }
    // new
    func getPerson2(_ name: String) -> Person? {
    return items.firstIndex { $0.name == name }.map { items [$0] }
    }
}

