//
//  main.swift
//  闭包表达式和闭包
//
//  Created by 张文艺 on 2022/5/13.
//

import Foundation

print("Hello, World!")

/*
 1、闭包表达式的写法
 */
//函数
func sum(_ v1: Int, _ v2: Int) -> Int {
    v1 + v2
}
print("sum\(sum(10, 20))")

//闭包表达式
var fn = {
    (v1: Int,v2: Int) -> Int in
    return v1 + v2
}
var result = fn(10, 20)

//匿名闭包表达式
{
   (v1: Int,v2: Int) -> Int in
   return v1 + v2
}(10,20)
