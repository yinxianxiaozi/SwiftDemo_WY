//
//  main.swift
//  泛型
//
//  Created by 张文艺 on 2022/5/14.
//

import Foundation

print("Hello, World!")

/*
 1、实现
 */
func test1() {
    //用在函数
    //定义一个交换函数，通过元组交换的，定义T为泛型
    func swapValues<T>(_ a: inout T, _ b: inout T) {
        (a, b) = (b, a)
    }
    //分别交换int、float、struct类型
    //传参时就可以决定类型，所以这里的swapValues后面不需要加<T>
    var i1 = 10
    var i2 = 20
    swapValues(&i1, &i2)
    
    var d1 = 10.0
    var d2 = 20.0
    swapValues(&d1, &d2)
    
    struct Date {
        var year = 0, month = 0, day = 0
    }
    var dd1 = Date(year: 2011, month: 9, day: 10)
    var dd2 = Date(year: 2012, month: 10, day: 11)
    swapValues(&dd1, &dd2)
    print(dd1)
    print(dd2)
    
    //将函数赋给一个变量
    var n1 = 10
    var n2 = 20
    let fn: (inout Int, inout Int) -> () = swapValues
    fn(&n1, &n2)
    print(n1,n2)//20 10
    
    
    //用在类型
    //自定义一个栈，实现简单的出栈入栈,使用elements数组来存储元素
    class Stack<E> {
        var elements = [E]()
        func push(_ element: E) {
            elements.append(element)
        }
        func pop() -> E {
            elements.removeLast()
        }
        func top() -> E {
            elements.last!
        }
        func size() -> Int {
            elements.count
        }
    }
    //这里没有传参，所以需要增加<>类型
    var intStack = Stack<Int>()
    intStack.push(1)
    print(intStack.size())
    intStack.pop()
    print(intStack.size())
    var stringStack = Stack<String>()
    
    //用在枚举
    enum Score<T> {
        case point(T)
        case grade(String)
    }
    //这里虽然使用了grade，没使用point，但是只要创建这个枚举，就应该传入泛型类型
    let score = Score<Int>.grade("A")
}
//test1()

/*
 2、关联类型
 其实就是协议的泛型
 */
//创建一个泛型，定义了一个类型Element，该类型遵守Equatable协议
protocol Stackable {
    associatedtype Element : Equatable
}
//创建一个类，泛型类型必须遵守该协议，并且将该类型赋值给Element
class Stack<E : Equatable> : Stackable {
    typealias Element = E
}

/*
 3、类型约束
 */
//通过where可以增加类型的约束
/*
 约束如下：
 1. S1、S2 都是泛型，
 2. 泛型都遵守协议Stackable
 3. S1和S2的关联类型要相等，这个Element是在类Stack中赋值的，他们要赋值相同
 4. S1的关联类型必须遵守Hashable协议
 */
func equal<S1: Stackable, S2: Stackable>(_ s1: S1, _s2: S2) -> Bool where S1.Element == S2.Element, S1.Element : Hashable {
    return false
}

var stack1 = Stack<Int>()
var stack2 = Stack<Int>()
var stack3 = Stack<String>()
print(equal(stack1, _s2: stack2))
//print(equal(stack1, _s2: stack3))

/*
 4、应用：代码优化
 */
protocol Runnable {
    associatedtype Speed
    var speed: Speed { get }
}
class Person : Runnable {
    var speed: Double { 0.0 }
}
class Car : Runnable {
    var speed: Int { 0 }
}

//这里返回值只要写上Runnable，那么返回的只要是遵守该协议的就都可以
//否则每个类型都写一个方法，代码冗余
//此时无法使用，这是因为协议中有associatedtype关键字就必须使用泛型
//func get(_ type: Int) -> Runnable {
//    if type == 0 {
//        return Person()
//    }
//    return Car()
//}
//var r1 = get(0)
//var r2 = get(1)

/*
 增加泛型
 1、方法中传入泛型，该类型必须遵守Runnable协议
 2、最后返回这个类型
 3、当然在返回的时候就需要判断一下是否遵守该协议
 */
func get<T : Runnable>(_ type: Int) -> T {
    if type == 0 {
        return Person() as! T
    }
    return Car() as! T
}
var r1: Person = get(0)
var r2: Car = get(1)


/*
 5、不透明类型
 */
func get(_ type: Int) -> some Runnable {
    return Person()
}
var r1 = get(0)
var r2 = get(1)
