//
//  ContentView.swift
//  手势排序
//
//  Created by zhangwenyi on 2022/5/25.
//

import SwiftUI

struct ContentView: View {
    let words = Array("文艺的文艺呀")
    @State var enabled = false
    @State var dragAmount = CGSize.zero
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<words.count) { num in
                Text(String(words[num])).bold().font(.title).foregroundColor(.white)
                    .padding(2)
                    .background(enabled ? .orange : .cyan)
                    .offset(dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged{
                    dragAmount = $0.translation
                }
                .onEnded{ _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
