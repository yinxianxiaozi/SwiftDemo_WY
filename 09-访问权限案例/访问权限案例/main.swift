//
//  main.swift
//  访问权限案例
//
//  Created by zhangwenyi on 2022/5/15.
//

import Foundation

print("Hello, World!")

/*
 1、成员影响类型
 */
//1.1 元组
//internal struct Dog {}
//fileprivate class Person {}
//
//// (Dog, Person)的访问级别是fileprivate
//fileprivate var data1: (Dog, Person)
////手动设置类型，但此时二者等价，因为私有的范围刚好就是fileprivate
//private var data2: (Dog, Person)

//1.2 泛型
//internal class Car {}
//fileprivate class Dog {}
//public class Person<T1, T2> {}
//
//// Person<Car, Dog>的访问级别是fileprivate
//fileprivate var p = Person<Car, Dog>()

/*
 2、类型影响成员
 */
public class PublicClass {
    public var p1 = 0 // public
    var p2 = 0 // internal
    fileprivate func f1() {} // fileprivate
    private func f2() {} // private
}

class InternalClass { // internal
    var p = 0 // internal
    fileprivate func f1() {} // fileprivate
    private func f2() {} // private
}

//class Test {
//    private class Person {}
//    fileprivate class Student : Person {}
//}
//
//private class Person {}
//fileprivate class Student : Person {}

//age和run()与Dog结构体的作用域范围一样，是当前文件
//private struct Dog {
//    var age: Int = 0
//    func run() {}
//}
//fileprivate struct Person {
//    var dog: Dog = Dog()
//    mutating func walk() {
//        dog.run()
//        dog.age = 1
//    }
//}

/*
 3、getter、setter的访问级别
 */
//fileprivate(set) public var num = 10//全局变量
//class Person {
//    private(set) var age = 0//只将set设置为私有的
//    fileprivate(set) public var weight: Int {//只将set设置为fileprivate的
//        set {}
//        get { 10 }
//    }
//    internal(set) public subscript(index: Int) -> Int {//只将set设置为internal的
//        set {}
//        get { index }
//    }
//}

/*
 4、初始化器的访问级别
 */
//class Person {
//    internal required init() {}//默认的
//}
//class Person2 {
//    fileprivate required init() {}//比默认小
//}
//class Person3 {
//    public required init() {}//比默认大
//}

/*
 5、协议实现的访问级别
 */
//public protocol Runnable {
//    func run()
//}
//
//public class Person : Runnable {
//    func run() {}//默认协议为fileprivate，均小于类和协议的访问级别，不可以
//}

//fileprivate protocol Runnable {
//    func run()
//}
//
//public class Person : Runnable {
//    fileprivate func run() {}//等于协议的访问级别
//}

/*
 6、扩展的访问级别
 */

//public class Person {
//    private func run0() {}
//    private func eat0() {
//        run1()
//    }
//}
//extension Person {
//    private func run1() {}
//    private func eat1() {
//        run0()
//    }
//}
//extension Person {
//    private func eat2() {
//        run1()
//    }
//}

//class Person {
//    public func run() {}
//}
////子类不能大于父类的权限，因为可能要使用父类的成员
//public class Student : Person {
//    override func run() {}
//}

//public class Person {
//    private var age: Int = 0
//}
//public class Student : Person {
//    //父类的age是私有的，无法重写
//    override var age: Int {
//        set {}
//        get {10}
//    }
//}
