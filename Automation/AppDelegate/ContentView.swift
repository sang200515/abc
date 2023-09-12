//
//  ContentView.swift
//  Sang's App
//
//  Created by Sang Truong on 09/09/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView(state: HomeState())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(state: HomeState())
    }
}
