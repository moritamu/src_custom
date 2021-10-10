//
//  ContentView.swift
//  MyOkashi
//
//  Created by Swift-Beginners.
//

import SwiftUI

struct ContentView: View {
    // OkashiDataを参照する状態変数
    @ObservedObject var okashiDataList = OkashiData()
    // 入力された文字列を保持する状態変数
    @State var inputText = ""
    // SafariViewの表示有無を管理する変数
    @State var showSafari = false
    
    var body: some View {
        // 垂直にレイアウト（縦方向にレイアウト）
        VStack {
            // 文字を受け取るTextFieldを表示する
            TextField("キーワードを入力してください", text: $inputText, onCommit: {
                // 入力完了直後に検索をする
                okashiDataList.searchOkashi(keyword: inputText)
            })
            // 上下左右に空白を開ける
            .padding()
            
            // リスト表示する
            List(okashiDataList.okashiList) { okashi in
                // 1つ１つの要素が取り出させれる
                
                // ボタンを用意する
                Button(action: {
                    // SafariViewを表示する
                    showSafari.toggle()
                }) {
                    // Listの表示内容を生成する
                    // 水平にレイアウト(横方向にレイアウト)
                    HStack {
                        // 画像を表示する
                        Image(uiImage: okashi.image)
                            // リサイズする
                            .resizable()
                            // アスペクト比（縦横比）を維持してエリア内に収まるようにする
                            .aspectRatio(contentMode: .fit)
                            // 高さ40
                            .frame(height: 40)

                        // テキスト表示する
                        Text(okashi.name)
                    }  // HStackここまで
                } // Buttonここまで
                .sheet(isPresented: self.$showSafari, content: {
                    // SafariViewを表示する
                    SafariView(url: okashi.link)
                        // 画面下部をいっぱいになるようにセーフエリア外までいっぱいになるように指定
                        .edgesIgnoringSafeArea(.bottom)
                }) // sheetここまで
            } // Listここまで
        } // VStackここまで
    } // bodyここまで
} // ContentViewここまで

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
