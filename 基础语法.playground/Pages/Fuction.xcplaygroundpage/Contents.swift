//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

//不带参数
func pi() -> Double {
    return 3.1415
}

pi()

//带参数
/// 求和【概述】
///
/// 将两个整数相加【更详细的描述】
/// - Parameters:
///   - v1: v1 第一个整数
///   - v2: v2 第二个证书
/// - Returns: 2个整数的和
///
/// - Note : 传入2个证书即可【批注】
func sum(v1: Int,v2: Int) -> Int {
    v1 + v2
}

sum(v1: 10, v2: 20)


func calculate(v1: Int,v2: Int) -> (sum: Int,diffence: Int,average: Int) {
    let sum = v1+v2
    return(sum,v1-v2,sum>>1)
}

let result = calculate(v1: 20, v2: 10)
result.sum
result.diffence
result.average
result.0
result.1
result.2

func check(name: String = "nobody", age: Int,job: String = "none") -> () {
    print("name=\(name),age=\(age),job=\(job)")
}
check(age: 18)
check(name: "wy", age: 18, job: "iOS")
check(age: 18,job: "iOS")

//inout的使用
func swapValues(_ v1: inout Int, _ v2: inout Int) -> Void {
    let tmp = v1
    v1 = v2
    v2 = tmp
}

var num1 = 10
var num2 = 20
swapValues(&num1, &num2)//传入地址（其实就是指针，虽然Swift中没有指针变量的概念）

//数据类型为：()->() 或者()->Void
func test(){
    print("lalala")
}
//数据类型为：(Int,String) -> (Int,Double)
func test2(a: Int,b: String) -> (Int,Double) {
    return(7,7.0)
}

//（Int,Int) -> Int
func sum2(a:Int,b:Int) -> Int {
    a+b
}

//1、通过函数的数据类型定义一个函数变量
var fn: (Int,Int) -> Int;
//2、赋值一个函数
fn = sum2(a:b:)
//3、调用
fn(2,3)

//加法
func sum3(v1: Int, v2: Int) -> Int {
    v1+v2
}

//减法
func difference(v1: Int,v2: Int) -> Int {
    v1-v2
}

//通过传入的函数和对变量进行对应的加减操作
//(Int, Int) -> Int 是mathFn参数的数据类型
func printResult(_ mathFn: (Int, Int) -> Int , _ a: Int, _ b:Int) {
    print("Result: \(mathFn(a,b))")
}

printResult(sum, 20, 10)
printResult(difference, 20, 10)

//+1
func next(_ input: Int) -> Int {
    input + 1
}

//-1
func previous(_ input: Int) -> Int {
    input - 1
}

//通过传入的Bool值判断返回哪个函数
// (Int) -> Int是返回值类型，是个函数类型，因此返回函数
// 因为返回的是函数所以只写名称，不需要带参数
func forward(_ forward: Bool) -> (Int) -> Int {
    forward ? next : previous
}
forward(true)(3)//4
forward(false)(4)//2

////永远不会被内联，即使开启编译期优化
//@inline(never) func test() {
//    print("test")
//}
//
////开启编译期优化后，即使代码很长，也会被内联，当然也不是所有的都会内联，如果是递归调用函数，动态绑定函数就不会
//@inline(__always) func test() {
//    print("test")
//}
