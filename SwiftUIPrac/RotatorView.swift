//
//  RotatorView.swift
//  SwiftUIPrac
//
//  Created by USER on 2020/11/26.
//

import SwiftUI

func pow(_ x: Int, _ y: Int) -> Int {
    var result = 1
    for _ in 0..<y {
        result *= x
    }
    return result
}

struct RotatorShape: Shape {
    static let maxDivision: Int = 6
    var division: Int

    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width
            let height = rect.height

            let segments = 3 * pow(2, division - 1)
            let wx = width * 0.5 / CGFloat(Self.maxDivision)
            let wy = height * 0.5 / CGFloat(Self.maxDivision)

            for index in 0..<segments {
                let angle = 2 * CGFloat.pi/CGFloat(segments) * CGFloat(index)

                path.move(to: CGPoint(x: width/2 + cos(angle)*wx*CGFloat(division), y: height/2 + sin(angle)*wy*CGFloat(division)))
                path.addLine(to: CGPoint(x: width/2 + cos(angle)*wx*CGFloat(division+1), y: height/2 + sin(angle)*wy*CGFloat(division+1)))
            }

        }
    }
}

struct CompassView: View {
    @State var angleStep: Double = 0

    func delayForDivision(_ division: Int) -> Double {
        return Double(division) * 0.1
    }

    func angleForDivision(_ division: Int) -> Double {
        let segments = 3 * pow(2, division - 1)
        let baseAngle = 2 * Double.pi / Double(segments)
        return baseAngle * angleStep
    }

    func animate() {
        withAnimation() {
            self.angleStep += 1.0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.animate()
        }
    }

    var body: some View {
        let animation = Animation.easeInOut(duration: 1.0)
        return ZStack {
            ForEach(1 ..< RotatorShape.maxDivision + 1) { division in
                RotatorShape(division: division)
                    .stroke(Color.red, lineWidth: 2.0)
                    .blendMode(.plusLighter)
                    .rotationEffect(Angle(radians: angleForDivision(division)))
                    .animation(animation.delay(delayForDivision(division)))
                RotatorShape(division: division)
                    .stroke(Color.red, lineWidth: 2.0)
                    .blendMode(.plusLighter)
                    .rotationEffect(Angle(radians: angleForDivision(division)))
                    .animation(animation.delay(delayForDivision(division) + Double(division) + 0.015))
                RotatorShape(division: division)
                    .stroke(Color.red, lineWidth: 2.0)
                    .blendMode(.plusLighter)
                    .rotationEffect(Angle(radians: angleForDivision(division)))
                    .animation(animation.delay(delayForDivision(division) + Double(division) + 0.03))
            }
        }
        .onAppear() {
            withAnimation {
                self.animate()
            }
        }
    }
}

struct RotatorView: View {
    var body: some View {
        CompassView()
            .frame(width: 300, height: 300, alignment: .center)
    }
}

