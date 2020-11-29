//
//  CheckView.swift
//  SwiftUIPrac
//
//  Created by 박종상 on 2020/11/29.
//

import SwiftUI


private struct CheckShape: Shape {
	func path(in rect: CGRect) -> Path {
		return Path { path in
			let width = rect.width
			let height = rect.height

			let startX: CGFloat = 0.0
			let startY: CGFloat = 0.0
			let centerX: CGFloat = (width / 2) - 20
			let centerY: CGFloat = (height / 2) + 30
			let goalX: CGFloat = width
			let goalY: CGFloat = 0

			let startPos = CGPoint(x: startX, y: startY)
			let centerPos = CGPoint(x: centerX, y: centerY)
			let goalPos = CGPoint(x: goalX, y: goalY)

			path.move(to: startPos)
			path.addLine(to: centerPos)
			path.move(to: centerPos)
			path.addLine(to: goalPos)
		}
	}

}

struct CheckView: View {
	@State private var percentage: CGFloat = .zero
	@State private var toggle: Bool = false
	let checkWidth: CGFloat = 100
	let cehckHeight: CGFloat = 100
    var body: some View {
		VStack {
			Button("BUTTON!!") {
				self.toggle.toggle()
				if self.toggle {
					self.percentage = 1.0
				} else {
					self.percentage = .zero
				}
			}
			CheckShape()
				.trim(from: 0, to: percentage)
				.stroke(Color.green, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
				.frame(width: checkWidth, height: cehckHeight, alignment: .center)
				.animation(.easeOut(duration: 1.0))
				.background(Color.blue)
				.cornerRadius(checkWidth / 2)
				.blendMode(.plusLighter)
		}
		.navigationBarTitle("Check View")
    }
}

struct CheckView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			CheckView()
				.preferredColorScheme(.dark)
		}
    }
}
