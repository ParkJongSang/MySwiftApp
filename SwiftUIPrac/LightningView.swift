//
//  LightningView.swift
//  SwiftUIPrac
//
//

import SwiftUI

struct DuplicateAndBlurEffect: ViewModifier {
    let value: CGFloat

    func body(content: Content) -> some View {
        content.blur(radius: value)
            .overlay(content)
    }
}

struct Lightning: Shape {
    var fraction1: CGFloat
    var fraction2: CGFloat
    var variant: CGFloat
    var innerRadius: CGFloat

    var animatableData: CGFloat {
        get { return innerRadius }
        set { innerRadius = newValue }
    }

    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width
            let height = rect.height

            let width1 = width/2*(1-innerRadius)*0.33
            let width2 = width/2*(1-innerRadius)*0.66
            let height1 = height/2*(1-innerRadius)*0.33
            let height2 = height/2*(1-innerRadius)*0.66

            let swidth = width/2*innerRadius
            let sheight = height/2*innerRadius

            let startPoint = CGPoint(x: width/2 + cos(fraction1)*swidth, y: height/2 + sin(fraction1)*sheight)

            let fractionPoint1 = CGPoint(x: width/2 + cos(fraction1)*(width1+swidth), y: height/2 + sin(fraction1)*(height1+sheight))
            let fractionPoint2 = CGPoint(x: width/2 + cos(fraction2)*(width2+swidth), y: height/2 + sin(fraction2)*(height2+sheight))

            let ending1 = CGPoint(x: width/2 + cos(fraction2+variant)*width/2, y: height/2+sin(fraction2+variant)*height/2)
            let ending2 = CGPoint(x: width/2 + cos(fraction2-variant)*width/2, y: height/2+sin(fraction2-variant)*height/2)

            path.move(to: startPoint)
            path.addLine(to: fractionPoint1)
            path.addLine(to: fractionPoint2)
            path.addLine(to: ending1)
            path.move(to: fractionPoint2)
            path.addLine(to: ending2)
        }
    }
}

struct LightningView: View {
    @State var f1: CGFloat = CGFloat.random(in: 0...CGFloat.pi*2)
    @State var f2: CGFloat = CGFloat.random(in: 0...CGFloat.pi*2)
    @State var variant = CGFloat.random(in: 0...0.2)
    @State var innerRadius: CGFloat = 0.5

    let interval = Double.random(in: 0.1...0.3)

    func randomize() {
        withAnimation() {
            self.f1 = CGFloat.random(in: 0...CGFloat.pi*2)
            self.f2 = f1 + CGFloat.random(in: -1...1)
            self.variant = CGFloat.random(in: 0...0.2)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.randomize()
        }
    }

    let animation = Animation.easeInOut(duration: 0.1)
    let gradient = RadialGradient(gradient:Gradient(colors: [.black, Color.purple.opacity(0.3), Color.red.opacity(0.6)]), center: .center, startRadius: 0, endRadius: CGFloat.random(in: 120...180))

    var body: some View {
        ZStack {
            Lightning(fraction1: self.f1, fraction2: self.f2, variant: self.variant, innerRadius: self.innerRadius)
                .stroke(gradient, lineWidth: 12)
                .animation(animation.delay(0.1))
                .opacity(0.3)

            Lightning(fraction1: self.f1, fraction2: self.f2, variant: self.variant, innerRadius: self.innerRadius)
                .stroke(gradient, lineWidth: 6)
                .animation(animation.delay(0.05))
                .opacity(0.6)

            Lightning(fraction1: self.f1, fraction2: self.f2, variant: self.variant, innerRadius: self.innerRadius)
                .stroke(gradient, lineWidth: 2)
        }
        .modifier(DuplicateAndBlurEffect(value: 20.0))
        .onAppear(perform: {
            withAnimation(Animation.easeInOut(duration: 0.8).repeatForever()) {
                self.innerRadius = 1.0
            }
            self.randomize()
        })
    }
}
