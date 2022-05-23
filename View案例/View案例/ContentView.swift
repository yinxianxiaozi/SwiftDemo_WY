//
//  ContentView.swift
//  View案例
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        Text("Hello, world!")
//            .padding()
        
        VStack {
            //Text
            Text("我是一个Text，**Markdown语法加粗了**")
            
            //Button
            Button {
                print("button点击响应")
            } label: {
                Text("我是按钮")
            }
            
//            Picker

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
