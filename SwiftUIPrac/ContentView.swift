//
//  ContentView.swift
//  SwiftUIPrac
//
//

import SwiftUI

struct CrazyView: View {
    var body: some View {
        ZStack {
            ForEach(0..<30) { index in
                LightningView()
                    .blendMode(.plusLighter)
            }
        }
    }
}

struct ContentView: View {
    var body: some View {

        NavigationView {
            VStack {
                NavigationLink(destination: CrazyView().frame(width: 200, height: 200)) {
                    Text("Crazy View")
                }
                .navigationTitle("라이트닝 뷰")
                .padding(.all, 10)

                NavigationLink(destination: LoadingView()) {
                    Text("Loading View")
                }
                .navigationTitle("로딩 뷰(아이패드 air)")
                .padding(.all, 10)
            }
        }
//        ZStack {
//            VStack {
//                LoadingView()
//                Text("#LoadingView")
//                    .font(.headline)
//            }
//        }
//        .frame(maxWidth: .infinity,maxHeight: .infinity)
//        .background(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
