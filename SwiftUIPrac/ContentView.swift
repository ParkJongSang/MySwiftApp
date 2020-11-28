//
//  ContentView.swift
//  SwiftUIPrac
//
//

import SwiftUI

struct ContentView: View {
	let crazyViewLink: some View = {
		NavigationLink(destination: CrazyView(title: "Crazy View").frame(width: 200, height: 200)) {
			Text("Crazy View")
		}
		.padding(.all, 10)
	}()

	let loadingViewLink: some View = {
		NavigationLink(destination: LoadingView(title: "Loading View")) {
			Text("Loading View")
		}
		.padding(.all, 10)
	}()

	let rotatorViewLink: some View = {
		NavigationLink(destination: RotatorView(title: "Rotator View")) {
			Text("Rotator View")
		}
		.padding(.all, 10)
	}()

    var body: some View {
		ZStack {
			NavigationView {
				VStack {
					crazyViewLink
					loadingViewLink
					rotatorViewLink
				}
				.navigationBarTitle("Animations")
			}
		}
    }
}
