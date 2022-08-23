//
//  main.swift
//  闭包表达式和闭包
//
//  Created by 张文艺 on 2022/5/13.
//

import Foundation

print("Hello, World!")
func test1() {
    /*
     1、闭包表达式的写法
     */
    //1.1 函数
    func sum(_ v1: Int, _ v2: Int) -> Int {
        v1 + v2
    }
    print("sum\(sum(10, 20))")

    //1.2 闭包表达式
    var fn = {
        (v1: Int,v2: Int) -> Int in
        return v1 + v2
    }

    let result = fn(10,20)

    //1.3 匿名闭包表达式
    {
       (v1: Int,v2: Int) -> Int in
       return v1 + v2
    }(10,20)
}

test1()

/*
 2、闭包表达式的简写
 */
func test2 (){
    //2.1 函数
    func exec(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
        print(fn(v1, v2))
    }
    //2.2 闭包表达式正常格式
    exec(v1: 10, v2: 20, fn: {
    (v1: Int, v2: Int) -> Int in
    return v1 + v2
    })

    //2.3 简写：参数类型
    exec(v1: 10, v2: 20, fn: {
    v1, v2 in return v1 + v2
    })

    //2.4 简写：return
    exec(v1: 10, v2: 20, fn: {
    v1, v2 in v1 + v2
    })

    //2.5 简写：参数
    exec(v1: 10, v2: 20, fn: { $0 + $1 })

    //2.6 简写：只写操作符
    exec(v1: 10, v2: 20, fn: + )
}
test2()

/*
 3、尾随闭包
 */
func test3 () {
    //3.1 函数定义
    func exec1(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
        print(fn(v1, v2))
    })

    //3.2 函数调用时尾随闭包
    exec(v1: 10, v2: 20) { $0 + $1 }
}


/*
 4、数组排序实例
 */
func test4 () {
    //func sort(by areInIncreasingOrder: (Element, Element) -> Bool)
    
    var nums = [11, 2, 18, 6, 5, 68, 45]
    //4.1 sort排序函数中最后一个参数设置闭包表达式
    nums.sort(by: {
        (i1: Int, i2: Int) -> Bool in
        return i1 < i2
    })
    
    //各种简写
    nums.sort(by: { i1, i2 in return i1 < i2 })//正常
    nums.sort(by: { i1, i2 in i1 < i2 })//没有return
    nums.sort(by: { $0 < $1 })//没有参数
    nums.sort(by: <)//只有运算符
    nums.sort() { $0 < $1 }//尾随闭包
    nums.sort { $0 < $1 }//最后一个参数可以不用写()
    print("nums:\(nums)")//nums:[2, 5, 6, 11, 18, 45, 68]
}
test4()

typealias Fn = (Int) -> Int
/*
 1、闭包认识
 */
func test5 () {
    //返回一个函数
    func getFn() -> Fn {
        var num = 0
        //plus函数会捕获num变量
        //plus函数和捕获的num变量形成了闭包
        func plus(_ i: Int) -> Int {
            num += i
            return num
        }
        return plus
    }
    var fn1 = getFn()
    var fn2 = getFn()
    fn1(1) // 1
    fn2(2) // 2
    fn1(3) // 4
    fn2(4) // 6
}
test5()

/*
 3、捕获变量的时机
 */
func test7() {
    func getFn() -> Fn {
        var num = 11
        func plus(_ i: Int) -> Int {
            num += i
            return num
        }
        //捕获的是14，而非11
        num = 14
        return plus
    }
    var fn1 = getFn()
    fn1(1)//15
}

/*
 4、多变量多函数的分析
 */
//func test8() {
//    func getFns() -> (Fn, Fn) {
//        var num1 = 0
//        var num2 = 0
//        func plus(_ i: Int) -> (Int, Int) {
//            num1 += i
//            num2 += i << 1
//            return (num1,num2)
//        }
//        func minus(_ i: Int) -> (Int, Int) {
//            num1 -= i
//            num2 -= i << 1
//            return (num1,num2)
//        }
//        return (plus,minus)
//    }
//    let (p, m) = getFns()
//    p(6)//(6,12)
//    p(5)//(1,2)
//    p(4)//(5,10)
//    p(3)//(2,4)
//}

/*
 5、数组循环闭包分析
 */
func test9() {
    //定义一个数组，元素是函数
    var functions: [() -> Int] = []
    for i in 1...3 {
        functions.append{ i }
    }
    for f in functions {
        print("\(f())")
    }
}
/*
 6、自动闭包
 使用关键字@autoclosure修饰参数
 */
func test10() {
    func getFirstPositive(_ v1: Int, _ v2: @autoclosure () -> Int) -> Int {
        return v1 > 0 ? v1 : v2()
    }
    //下面三条语句等效
    getFirstPositive(10, 20)//自动闭包
    getFirstPositive(10, {20})
    getFirstPositive(10){20}//尾随闭包
}

