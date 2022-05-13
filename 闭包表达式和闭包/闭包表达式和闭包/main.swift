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

    ////1.2 闭包表达式
//    var fn = {
//        (v1: Int,v2: Int) -> Int in
//        return v1 + v2
//    }
//
//    let result = fn(10,20)
//
//    //1.3 匿名闭包表达式
//    {
//       (v1: Int,v2: Int) -> Int in
//       return v1 + v2
//    }(10,20)
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




