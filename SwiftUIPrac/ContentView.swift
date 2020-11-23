//
//  ContentView.swift
//  SwiftUIPrac
//
//  Created by USER on 2020/11/19.
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
            CrazyView()
                .frame(width: 300, height: 300)

            CrazyView()
                .frame(width: 200, height: 300)

            CrazyView()
                .frame(width: 100, height: 100)
        }
        .frame(width: 800, height: 400)
        .background(RadialGradient(gradient:Gradient(colors: [.black, Color.purple.opacity(0.3), Color.red.opacity(0.6)]), center: .center, startRadius: 0, endRadius: 400))
        .drawingGroup()
    }
}
