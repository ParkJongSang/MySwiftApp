//
//  LoadingView.swift
//  SwiftUIPrac
//

import SwiftUI

struct LoadingView: View {
    let circles = 100
    let diameter: CGFloat = 100.0
    let circleSize: CGFloat = 40.0
    let cutOut: CGFloat = 0.8
    @State var flipped: Bool = false
    @State var startAngle: CGFloat = 0

    func interpolateColor(_ i: Double) -> Color {
        let colors: [UIColor] = [.blue, .cyan, .red, .orange]
        var interpolator: CGFloat = 0.0
        var sIndex: Int = 0

        if i < 0.5 {
            interpolator = CGFloat(i) * 2
        } else {
            interpolator = (CGFloat(i) - 0.5) * 2
            sIndex = 1
        }

        var r1: CGFloat = 0.0
        var g1: CGFloat = 0.0
        var b1: CGFloat = 0.0
        var r2: CGFloat = 0.0
        var g2: CGFloat = 0.0
        var b2: CGFloat = 0.0
        var a: CGFloat = 0.0

        colors[sIndex].getRed(&r1, green: &g1, blue: &b1, alpha: &a)
        colors[sIndex+1].getRed(&r2, green: &g2, blue: &b2, alpha: &a)

        let r = r2 * interpolator + r1 * (1.0 - interpolator)
        let g = g2 * interpolator + g1 * (1.0 - interpolator)
        let b = b2 * interpolator + b1 * (1.0 - interpolator)

        return Color(red: Double(r), green: Double(g), blue: Double(b))
    }

    func circlePosition(index: Int) -> CGPoint {
        let baseAngle = CGFloat(index) / CGFloat(circles) * CGFloat.pi * 2 * cutOut
        let flipValue = 2 * CGFloat.pi - baseAngle
        let angle: CGFloat = flipped ? baseAngle + startAngle + flipValue : baseAngle + startAngle
        let xCoord: CGFloat = diameter + (diameter - circleSize) * cos(angle)
        let yCoord: CGFloat = diameter + (diameter - circleSize) * sin(angle)

        return CGPoint(x: xCoord, y: yCoord)
    }

    func circleDelay(index: Int) -> Double {
        return 5 * Double(circles - index) / Double(circles)
    }

    func animate() {
        withAnimation {
            self.flipped = !self.flipped
            self.startAngle += CGFloat.pi / 3
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.animate()
        }
    }

    var body: some View {
        ZStack {
            ForEach (0..<circles) { index in
                Circle()
                    .fill(interpolateColor(Double(index)/100.0))
                    .frame(width: circleSize, height: circleSize)
                    .position(self.circlePosition(index: index))
                    .animation(Animation.easeInOut(duration: 1.0).delay(self.circleDelay(index: index)))
            }
        }
		.navigationBarTitle("Loading View")
        .frame(width: 2*diameter, height: 2*diameter)
        .onAppear() {
            self.animate()
        }
    }
}
