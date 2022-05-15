//
//  main.swift
//  扩展案例
//
//  Created by zhangwenyi on 2022/5/15.
//

import Foundation

print("Hello, World!")

//1、增加计算属性
extension Double {
    var km: Double { self * 1_000.0 }
    var m: Double { self }
    var dm: Double { self / 10.0 }
    var cm: Double { self / 100.0 }
    var mm: Double { self / 1_000.0 }
}
var d = 10.0
print(d.km)
print(d.m)
print(d.dm)
print(d.cm)
print(d.mm)

//2、增加下标
extension Array {
    subscript(nullable idx: Int) -> Element? {
        if (startIndex..<endIndex).contains(idx) {
            return self [idx]
        }
        return nil
    }
}
var arr: Array<Int> = [20,10,30]
print(arr[nullable: 3] as Any)

//3、增加协议
class Person {
    var age: Int
    var name: String
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
}
extension Person : Equatable {
    //扩展一个方法
    static func == (left: Person, right: Person) -> Bool {
        left.age == right.age && left.name == right.name
    }
    //只能扩展便捷初始化器
    convenience init() {
        self.init(age: 0, name: "")
    }
}

let p1 = Person.init(age: 10, name: "WY")
let p2 = Person.init(age: 20, name: "WY")
print(p1 == p2)//false

//4、增加初始化器
struct Point {
    var x: Int = 0
    var y: Int = 0
}
extension Point {
    init(_ point: Point) {
        self.init(x: point.x, y: point.y)
    }
}
//扩展初始化器后，并不会覆盖之前的初始化器，没有覆盖，而只是扩展
var p41 = Point()
var p42 = Point(x: 10)
var p43 = Point(y: 20)
var p44 = Point(x: 10, y: 20)
var p45 = Point(p44)

//protocol Runnable {
//    init(age: Int)
//}
//class Person4 {}
//extension Person4 : Runnable {
//    required init(age: Int) {
//        print("required init")
//    }
//}
//var p46 = Person4.init(age: 10)

//5、增加协议声明
protocol TestProtocol {
    func test()
}
class TestClass {
    func test() {
        print("test")
    }
}
extension TestClass : TestProtocol {}
TestClass().test()

/*
 判断奇数案例
两种方案：
 1. 创建isOdd函数，传入遵守BinaryInteger协议的类型，进行比较
 2. 扩展BinaryInteger协议，增加isOdd方法
 */
func isOdd<T: BinaryInteger>(_ i: T) -> Bool {
    i % 2 != 0
}
extension BinaryInteger {
    func isOdd() -> Bool { self % 2 != 0 }
}
print(10.isOdd())//false
print((-3).isOdd())//true

//6、增加协议实现
protocol TestProtocol6 {
    func test1()
}
//增加协议方法实现，增加协议方法
extension TestProtocol6 {
    func test1() {
        print("TestProtocol test1")
    }
    func test2() {
        print("TestProtocol test2")
    }
}
//类中自己再实现一下方法
class TestClass6 : TestProtocol6 {
func test1() { print("TestClass test1") }
func test2() { print("TestClass test2") }
}
var cls = TestClass6()
cls.test1() // TestClass test1
cls.test2() // TestClass test2  隐式遵守协议，会打印类的实现
var cls2: TestProtocol6 = TestClass6()
cls2.test1() // TestClass test1
cls2.test2() // TestProtocol test2 显式遵守协议，会打印默认的实现


//7、增加泛型
//下是一个模拟栈的类
class Stack<E> {
    var elements = [E]()
    func push(_ element: E) {
        elements.append(element)
    }
    func pop() -> E { elements.removeLast() }
    func size() -> Int { elements.count }
}
// 1、扩展中依然可以使用原类型中的泛型类型
extension Stack {
    func top() -> E { elements.last! }
}
// 2、符合条件才扩展（给Stack增加泛型，并添加泛型约束
extension Stack : Equatable where E : Equatable {
    static func == (left: Stack, right: Stack) -> Bool {
        left.elements == right.elements
    }
}
