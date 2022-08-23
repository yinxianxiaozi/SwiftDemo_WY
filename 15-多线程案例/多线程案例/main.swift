//
//  main.swift
//  多线程案例
//
//  Created by zhangwenyi on 2022/5/19.
//

import Foundation

print("Hello, World!")


public typealias Task = () -> Void

public struct Asyncs {
    /*
     1、多线程
     */
    public static func async(_ task: @escaping Task) {
        _async(task)
    }
    public static func async(_ task: @escaping Task,
                             _ mainTask: @escaping Task) {
        _async(task, mainTask)
    }
    private static func _async(_ task: @escaping Task,
                               _ mainTask: Task? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
    
    /*
     2、延迟执行
     */
    @discardableResult
    public static func delay(_ seconds: Double,
                             _ block: @escaping Task) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds,
                                      execute: item)
        return item
    }
    
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ task: @escaping Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task)
    }
    
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ task: @escaping Task,
                                  _ mainTask: @escaping Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task, mainTask)
    }
    
    private static func _asyncDelay(_ seconds: Double,
                                    _ task: @escaping Task,
                                    _ mainTask: Task? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds,
                                          execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
    

}


//3、锁
public struct Cache {
    private static var data = [String: Any]()
//    private static var lock = DispatchSemaphore(value: 1)
//    private static var lock = NSLock()
    private static var lock = NSRecursiveLock()
    
    public static func get(_ key: String) -> Any? {
        data[key]
    }
    
    public static func set(_ key: String, _ value: Any) {
//        lock.wait()
//        defer { lock.signal() }
        
        lock.lock()
        defer { lock.unlock() }
        
        data[key] = value
    }
}
