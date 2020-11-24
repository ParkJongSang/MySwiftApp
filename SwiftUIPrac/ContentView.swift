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
        ZStack {
            VStack {
                LoadingView()
                Text("#LoadingView")
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.white)
    }
}
