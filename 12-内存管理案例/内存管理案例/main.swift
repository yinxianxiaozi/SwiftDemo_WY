//
//  main.swift
//  内存管理案例
//
//  Created by zhangwenyi on 2022/5/15.
//

import Foundation

print("Hello, World!")

/*
 1、弱引用
 */
//protocol Livable : AnyObject {}
//class Person {}
//
//weak var p0: Person?
//weak var p1: AnyObject?
//weak var p2: Livable?
//
//unowned var p10: Person?
//unowned var p11: AnyObject?
//unowned var p12: Livable?

/*
 2、闭包的循环引用
 */
//class Person {
//    var fn: (() -> ())?
//    func run() { print("run") }
//    deinit { print("deinit") }
//}
//func test() {
//    let p = Person()
//    p.fn = {
//        [weak p] in
//        p?.run()
//    }
//}
//test()

//class Person {
//    lazy var fn: (() -> ()) = {
//        [weak self] in
//        self?.run()
//    }
//    func run() { print("run") }
//    deinit { print("deinit") }
//}
//func test() {
//    let p = Person()
//    p.fn()
//}
//test()
//class Person {
//    var age: Int = 0
//    lazy var getAge: Int = {
//        self.age
//    }()
//    deinit { print("deinit") }
//}

/*
 3、逃逸闭包
 */
//import Dispatch
//typealias Fn = () -> ()
//// fn是非逃逸闭包
//func test1(_ fn: Fn) { fn() }
//
//class Person {
//    var fn: Fn
//    // fn是逃逸闭包
//    init(fn: @escaping Fn) {
//        self.fn = fn
//    }
//    func run() {
//        // DispatchQueue.global().async也是一个逃逸闭包
//        // 它用到了实例成员（属性、方法），编译器会强制要求明确写出self
//        DispatchQueue.global().async {
//            self.fn()
//        }
//    }
//}
//func other1(_ fn: Fn) { fn() }
//func other2(_ fn: @escaping Fn) { fn() }
//func test(value: inout Int) -> Fn {
//    other1 { value += 1 }
//
//    // error: 逃逸闭包不能捕获inout参数
//    other2 { value += 1 }
//
//    func plus() { value += 1 }
//    // error: 逃逸闭包不能捕获inout参数
//    return plus
//}
/*
 4、内存访问冲突
 */
// 存在内存访问冲突
// Simultaneous accesses to 0x0, but modification requires exclusive access
//var step = 1
//func increment(_ num: inout Int) { num += step }
//increment(&step)
//
//// 解决内存访问冲突
//var copyOfStep = step
//increment(&copyOfStep)
//step = copyOfStep

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
//var num1 = 42
//var num2 = 30
//balance(&num1, &num2)  // OK
//balance(&num1, &num1) // Error

//var tulpe = (health: 10, energy: 20)
//// Error
//balance(&tulpe.health, &tulpe.energy)
//
struct Player {
    var name: String
    var health: Int
    var energy: Int
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}
//var oscar = Player(name: "Oscar", health: 10, energy: 10)
//var maria = Player(name: "Maria", health: 5, energy: 10)
//oscar.shareHealth(with: &maria)  // OK
//oscar.shareHealth(with: &oscar) // Error
//var holly = Player(name: "Holly", health: 10, energy: 10)
//// Error
//balance(&holly.health, &holly.energy)

// Ok
func test() {
    var tulpe = (health: 10, energy: 20)
    balance(&tulpe.health, &tulpe.energy)
    
    var holly = Player(name: "Holly", health: 10, energy: 10)
    balance(&holly.health, &holly.energy)
}
test()
