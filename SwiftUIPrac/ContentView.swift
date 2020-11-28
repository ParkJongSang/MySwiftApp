//
//  ContentView.swift
//  SwiftUIPrac
//
//

import SwiftUI

struct ContentView: View {
	let crazyViewLink: some View = {
		NavigationLink(destination: CrazyView().frame(width: 200, height: 200)) {
			Text("Crazy View")
		}
		.padding(.all, 10)
	}()

	let loadingViewLink: some View = {
		NavigationLink(destination: LoadingView()) {
			Text("Loading View")
		}
		.padding(.all, 10)
	}()

	let rotatorViewLink: some View = {
		NavigationLink(destination: RotatorView()) {
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
