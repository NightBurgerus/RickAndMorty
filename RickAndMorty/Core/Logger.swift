//
//  Logger.swift
//  RickAndMorty
//
//  Created by Чебупелина on 20.09.2023.
//

import Foundation

final class Logger {
    func warning(_ info: Any..., tag: AnyHashable? = nil) {
        #if DEBUG
        print("Logger ⚠️\(tag != nil ? " #\(tag!)" : ""): ", info)
        #endif
    }
    
    func error(_ info: Any..., tag: AnyHashable? = nil) {
        #if DEBUG
        print("Logger ❗\(tag != nil ? " #\(tag!)" : ""): ", info)
        #endif
    }
    
    func critical(_ info: Any..., tag: AnyHashable? = nil) {
        #if DEBUG
        print("Logger 🆘\(tag != nil ? " #\(tag!)" : ""): ", info)
        #endif
    }
    
    func debug(_ info: Any..., tag: AnyHashable? = nil) {
        #if DEBUG
        print("Logger 🚧\(tag != nil ? " #\(tag!)" : ""): ", info)
        #endif
    }
    
    func info(_ info: Any..., tag: AnyHashable? = nil) {
        #if DEBUG
        print("Logger ℹ️\(tag != nil ? " #\(tag!)" : ""): ", info)
        #endif
    }
    
    func log(_ info: Any..., tag: AnyHashable? = nil) {
        #if DEBUG
        print("Logger 📜\(tag != nil ? " #\(tag!)" : ""): ", info)
        #endif
    }
    
    func notice(_ info: Any..., tag: AnyHashable? = nil) {
        #if DEBUG
        print("Logger 📌\(tag != nil ? " #\(tag!)" : ""): ", info)
        #endif
    }
}
