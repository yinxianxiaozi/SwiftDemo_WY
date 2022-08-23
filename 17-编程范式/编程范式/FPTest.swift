//
//  FPTest.swift
//  编程范式
//
//  Created by 张文艺 on 2022/5/21.
//

import Foundation

//必须定义在全局
/*
 >>>运算符：
 1. 传入两个函数作为参数
 2. 返回一个函数（注意类型）
 3. 函数体是函数1作为函数2的参数进行调用
 */
infix operator >>> : AdditionPrecedence
func >>><A, B, C>(_ f1: @escaping (A) -> B,
_ f2: @escaping (B) -> C) -> (A) -> C { { f2(f1($0)) } }

/*
 ~运算符：柯里化操作
 */
prefix func ~<A, B, C>(_ fn: @escaping (A, B) -> C)
-> (B) -> (A) -> C { { b in { a in fn(a, b) } } }

/*
 0、编程思想的认识
 两个数相加
 */
func test0() {
    /*
     1. 先传入参数v，将其作为一个函数的操作数
     2. 返回一个函数
     3. 该函数需要传入一个值，计算后返回两个值的和
     */
    let num = 1
    func add(_ v: Int) -> (Int) -> Int {
        return {
            $0 + v
        }
    }
    print("test0：",add(3)(num))
}

/*
 1、编程思想的使用
 假设要实现以下功能：  [(num + 3) * 5 - 1] % 10 / 2
 */
func test1() {
    let num = 1//结果为4
    //1、传统写法
    func test11() {
        func add(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
        func sub(_ v1: Int, _ v2: Int) -> Int { v1 - v2 }
        func multiple(_ v1: Int, _ v2: Int) -> Int { v1 * v2 }
        func divide(_ v1: Int, _ v2: Int) -> Int { v1 / v2 }
        func mod(_ v1: Int, _ v2: Int) -> Int { v1 % v2 }
        
        let result = divide(mod(sub(multiple(add(num, 3), 5), 1), 10), 2)
        print("传统写法：",result)
    }
    test11()
      
    //2、合并写法
    func test12() {
        func add(_ v: Int) -> (Int) -> Int { { $0 + v } }
        func sub(_ v: Int) -> (Int) -> Int { { $0 - v } }
        func multiple(_ v: Int) -> (Int) -> Int { { $0 * v } }
        func divide(_ v: Int) -> (Int) -> Int { { $0 / v } }
        func mod(_ v: Int) -> (Int) -> Int { { $0 % v } }
        
        let fn = add(3) >>> multiple(5) >>> sub(1) >>> mod(10) >>> divide(2)
        print("合并后写法：",fn(num))
    }
    test12()
    
    //3、函数柯里化
    func test13() {
        func add(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
        func sub(_ v1: Int, _ v2: Int) -> Int { v1 - v2 }
        func multiple(_ v1: Int, _ v2: Int) -> Int { v1 * v2 }
        func divide(_ v1: Int, _ v2: Int) -> Int { v1 / v2 }
        func mod(_ v1: Int, _ v2: Int) -> Int { v1 % v2 }

        let fn = (~add)(3) >>> (~multiple)(5) >>> (~sub)(1) >>> (~mod)(10) >>> (~divide)(2)
        print("柯里化后写法：",fn(num))
    }
    test13()
}

/*
 2、柯里化
 */
func test2() {
    //1、柯里化的认识：将多参数拆分成单参数多函数
    func test21() {
        func add(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
        print("多参数：",add(10, 20))
        
        func add(_ v: Int) -> (Int) -> Int { { $0 + v } }
        print("柯里化:",add(10)(20))
    }
    
    //2、创建柯里化的通用函数（通过泛型）
    /*
     在柯里化认识的基础上，增加了传递函数参数，此处以两参数的通用柯里化函数为例说明
     1. 首先传入一个函数fn
     2. 将该函数进行一定操作后进行返回。需要返回的值是一个函数(该函数为参数为B，返回值是一个(A) -> C的函数)
     3. 返回的这个函数传入的值是B类型的值，最后返回的是函数的参数为A类型的值
     4. 函数体为是调用fn(a,b)
     5. 因此这个函数将传入进来的函数fn的a+b的过程进行了拆分，分别返回两个函数，每个函数都带有一个参数。
     */
    func test22() {
        func add1(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
        func add2(_ v1: Double, _ v2: Double) -> Double { v1 + v2 }
        func add3(_ v1: Int, _ v2: Int, _ v3: Int) -> Int { v1 + v2 + v3 }
        func add4(_ v1: Double, _ v2: Double, _ v3: Double) -> Double { v1 + v2 + v3 }
        
        
        //两参数的通用柯里化函数
        func currying<A, B, C>(_ fn: @escaping (A, B) -> C)
        -> (B) -> (A) -> C {
        { b in { a in fn(a, b) } }
        }

        //三参数的通用柯里化函数
        func currying<A, B, C, D>(_ fn: @escaping (A, B, C) -> D)
        -> (C) -> (B) -> (A) -> D {
        { c in { b in { a in fn(a, b, c) } } }
        }
        
        let curriedAdd1 = currying(add1)
        print("两参数的通用柯里化函数Int：",curriedAdd1(10)(20))
        let curriedAdd2 = currying(add2)
        print("两参数的通用柯里化函数Double：",curriedAdd2(10.5)(20.5))
        let curriedAdd3 = currying(add3)
        print("三参数的通用柯里化函数Int：",curriedAdd3(10)(20)(30))
        let curriedAdd4 = currying(add4)
        print("三参数的通用柯里化函数Double：",curriedAdd4(10.5)(20.5)(30.5))
    }

    test21()
    test22()
}

/*
 3、函子：像Array、  Optional这样支持map运算的类型，称为函子（ Functor）
 */
func test3() {
    
    /*map认识
     返回一个数组，其中包含将给定闭包映射到序列元素上的结果
     - Parameter transform:一个映射闭包
        1. 这个闭包接收数组元素作为它的参数
        2. 返回一个转换后的值，这个值的类型可以与参数相同，也可以不同
     - Returns:
        返回一个数组，数组元素为转换后数组的元素
    @inlinable public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
     */
    
    /*
     数组：Array<Element>
     public func map<T>(_ transform: (Element) -> T) -> Array<T>
     */
    let arr1 = [1,2,3]
    let arr2 = arr1.map { $0 * 2 }
    print("arr2:",arr2)
    /*
     可选项：Optional<Wrapped>
     public func map<U>(_ transform: (Wrapped) -> U) -> Optional<U>
     */
    let a: Int? = 1
    let b: Int? = a.map { $0 * 3 }
    print("b:",b!)
}

/*
 4、适用函子
 */
//Optional的适用函子条件
func pure<A>(_ value: A) -> A? { value }//易理解
infix operator <*> : AdditionPrecedence
//传入可选项函数(A) -> B ,传入A? ，返回B?
//将A传入函数fn中，拿到的仍然是个可选项
func <*><A, B>(fn: ((A) -> B)?, value: A?) -> B? {
    guard let f = fn, let v = value else { return nil }
    return f(v)
}

//Array的适用函子条件
func pure<A>(_ value: A) -> [A] { [value] }//易理解
//传入数组元素为函数，传入数组元素为A，拿到数组元素为B
//取出fn和value的元素分别进行调用。返回结果放到一个数组中
func <*><A, B>(fn: [(A) -> B], value: [A]) -> [B] {
    var arr: [B] = []
    if fn.count == value.count {
        for i in fn.startIndex..<fn.endIndex {
            arr.append(fn[i](value[i]))
        }
    }
    return arr
}

//调用
func test4() {
    var value: Int? = 10
    var fn: ((Int) -> Int)? = { $0 * 2}
    // Optional(20)
    print(fn <*> value as Any)
    
    
    // [10]
    print(pure(10))
    var arr = [{ $0 * 2}, { $0 + 10 }, { $0 - 5 }] <*> [1, 2, 3]
    // [2, 12, -2]
    print(arr)
}

/*
 5、单子
 */
func pure<A>(_ value: A) -> F<A>
func flatMap<A, B>(_ value: F<A>, _ fn: (A) -> F<B>) -> F<B>
func test5() {

}
