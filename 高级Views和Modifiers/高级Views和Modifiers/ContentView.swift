//
//  ContentView.swift
//  高级Views和Modifiers
//
//  Created by 张文艺 on 2022/5/25.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var finalAmount: CGFloat = 1
    @State var currentAmount: CGFloat = 0
    @State var isDragging = false
    @GestureState var magnifyBy = 1.0
    @State var show2 = false
    
    //创建拖拽手势
    var drag: some Gesture {
        DragGesture()
            .onChanged { _ in self.isDragging = true }
            .onEnded { _ in self.isDragging = false }
    }
    
    //创建缩放手势
    var magnification: some Gesture {
        MagnificationGesture()
//            .onChanged({ amount in
//                currentAmount = amount - 1
//            })
//            .onEnded({ amount in
//                finalAmount += currentAmount
//                currentAmount = 0
//            })
        .updating($magnifyBy) { currentState, gestureState, transaction in
                gestureState = currentState
            }
    }
    
    var body: some View {
        /*
         1、手势学习
         */
        VStack (alignment: .center, spacing: 5){
            //1.1 点击
            Text("点我哦")
            .onTapGesture(count: 1) {
                print("我被点击了")
            }
            
            //1.2 长按手势
            Text("长按我")
            //minimumDuration：长按生效最短时间
            //maximumDistance：两次长按的间隔
                .onLongPressGesture(minimumDuration: 1, maximumDistance: 1) { isPress in
                    print("\(isPress)")//按住或者放开
                } perform: {
                    print("长按完成")//长按生效
                }
            // <==>
//                .onLongPressGesture(minimumDuration: 0.2, maximumDistance: 0.5) {
//                    print("点完了")
//                } onPressingChanged: { isPress in
//                    print("我被点了")
//                }
            
            //1.3 缩放
            Text("旋转").bold().font(.title).padding().background(.orange)
                .foregroundColor(.white)
                .scaleEffect(currentAmount + finalAmount)
                .gesture(magnification)

            Text("缩放").bold().font(.title3).foregroundColor(.red)
            Circle()
            .frame(width: 100, height: 100)
            .scaleEffect(magnifyBy)
            .gesture(magnification)
            
            //1.4 拖拽
            Text("拖拽").bold().font(.title3).foregroundColor(.red)
            Circle()
                .fill(self.isDragging ? Color.red : Color.blue)
                .frame(width: 100, height: 100, alignment: .center)
                .gesture(drag)
        }
        //2、弹框
        VStack (alignment: .center, spacing: 5){
            Button("点我会弹出一个alert哦！") {
                show.toggle()//切换状态
            }
            .alert(isPresented: $show) {
                Alert.init(title: Text("title"), message: Text("message"), dismissButton: .cancel())
            }
            
            Button("点我会弹出一个conform哦！") {
                show.toggle()//切换状态
            }
//            .alert(isPresented: $show) {
//                Alert.init(title: Text("title"), message: Text("message"), dismissButton: .cancel())
//            }
            
            
            Button("弹框列表") {
                show2.toggle()
            }.confirmationDialog("dialog", isPresented: $show2) {
                Button("wy1") {}
                Button("wy2") {}
                Button("wy3") {}
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
