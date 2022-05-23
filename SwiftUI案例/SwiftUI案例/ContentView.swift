//
//  ContentView.swift
//  SwiftUI案例
//
//  Created by zhangwenyi on 2022/5/21.
//

import SwiftUI

struct ContentView: View {
    enum city: String {
        case taiyuan,xian,datong
    }
    @State var str: String = "wy"
    @State var textColor = Color.red
    @State var selectedCity = city.xian
    @State private var progress = 0.5
    var body: some View {
//        Text("Hello, world!")
//            .padding()
        VStack {
            VStack {
                //Text
                Text("我是一个Text，**Markdown语法加粗了**").foregroundColor(.red)
                
                //Label
                //可以设置文本、图片
                //labelStyle设置label样式
                Label("我是label", systemImage: /*@START_MENU_TOKEN@*/"42.circle"/*@END_MENU_TOKEN@*/).labelStyle(.titleOnly)
                
                //自定义label样式（后面看一下放在哪里比较好）
    //            struct RedBorderedLabelStyle: LabelStyle {
    //                func makeBody(configuration: Configuration) -> some View {
    //                    Label(configuration)
    //                        .border(Color.red)
    //                }
    //            }
    //            Label("自定义label样式").labelStyle(.RedBorderedLabelStyle)
                
                //Button，文字和响应
                Button {
                    print("button点击响应")
                } label: {
                    Text("我是按钮")
                }
                
                //Link
                //只是添加一个URL即可
                Link(destination: URL(string:"https://www.baidu.com/")!) {
                    /*@START_MENU_TOKEN@*/Text("Link")/*@END_MENU_TOKEN@*/
                }
                //直接拿Assets中图片
    //            Image("wy")
    //                .resizable()
    //                .aspectRatio(contentMode: .fit)
    //            UIImage.init(named: "wyy")
                
                //加载网络图片
    //            AsyncImage.
                
                //TimelineView
                TimelineView(.periodic(from: Date.now, by: 1.0)) {
                    context in
                    Text(context.date.description).font(.title)
                }
                //Canvas
                Canvas { context, size in
                    context.stroke(Path(ellipseIn: CGRect(origin: .zero, size: size)),with: .color(.blue), lineWidth: 3)
                }.frame(width: 100, height: 50, alignment: .center).border(.red,width: 2)
                //TextEditor
                TextEditor(text: /*@START_MENU_TOKEN@*/.constant("Placeholder")/*@END_MENU_TOKEN@*/).frame(width: 100, height: 30, alignment: .center)
                
                //TextField，预览无法操作
                TextField("Placeholder", text: $str).frame(width: 100, height: 50, alignment: .center).textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        print("我点击了！")
                    }
                
            }
            VStack {
                //ColorPicker
                //supportsOpacity是否设置透明度
                ColorPicker("picker", selection: $textColor, supportsOpacity: false).font(.largeTitle).foregroundColor(textColor)
                
                //Picker
//                Picker(selection: $selectedCity) {
//                    Text("taiyuan").tag(city.taiyuan)
//                    Text("xian").tag(city.xian)
//                    Text("datong").tag(city.datong)
//                } label: {
//                    Text("select")
//                }
//                Text("this city is : \($selectedCity.rawValue)")
                Picker(selection: $selectedCity, label: Text("Picker").frame(width: 50, height: 10, alignment: .center)) {
                    Text("taiyuan").tag(city.taiyuan)
                    Text("xian").tag(city.xian)
                    Text("datong").tag(city.datong)
                }.border(.orange)
                Text("this city is : \(selectedCity.rawValue)")

                //ProgressView
//                ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                ProgressView(value: progress, total: 10, label: {
                    Text("WY")
                }, currentValueLabel: {
                    Text("start")
                })
//                .progressViewStyle(.circular)
                Button("加1") {
                    progress += 1
                }
//                ProgressView(value: progress)
//                Button("More", action: { progress += 0.05 })

            }
        }
        
//        .contentShape(Rectangle())//追加热区设置
//        .onTapGesture {
//                print("tap")
//                //热区
//                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
