//
//  HomeView.swift
//  Sang's App
//
//  Created by Sang Truong on 09/09/2023.
//

import Foundation
import SwiftUI
import AppKit

struct HomeView: View {
    @ObservedObject var state: HomeState

    var body: some View {
        switch state.type {
        case .home:
            homeview
        case .jsonFormater:
            JsonFormatView(action: {
                state.type = .home
            })
            .frame(width: 800, height: 800)
        case .translate:
            TranslationView(action: {
                state.type = .home
            })
                .frame(width: 700, height: 500)

        case .ruler:
            SreenShotView(onAction: {
                state.type = .home
            })
                .frame(width: 700, height: 500)
        }
    }

    @ViewBuilder
    private var homeview: some View {
        ScrollView {
            VStack {
                searchBarView
                Divider()
                    .padding(.vertical, 4)
                searchResultView
                Spacer()
            }
            .padding()
            .frame(width: 700, height: 500)
            .onAppear {
                DispatchQueue.main.async {
                    state.isTextFieldActive = true
                }
            }
        }
    }

}

//MARK: UI Elements
private extension HomeView {
    var searchBarView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search for apps and commands...", text: $state.searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .accentColor(.clear)
                .font(.system(size: 20))
                .onSubmit {
                    state.type = state.itemSelected?.type ?? .home
                    state.isTextFieldActive = true
                }
                .onChange(of: state.searchText) { newValue in
                    guard let item = state.filteredListItems.first else { return }
                    state.itemSelected = item
                }
        }
    }


    var searchView: some View {
        HStack {
            TextField("Search", text: $state.searchText)
                .cornerRadius(10)
                .focused(state.$isTextFieldActive)

            if !state.searchText.isEmpty {
                Button(action: {
                    state.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
    }

    var searchResultView: some View {
        VStack (alignment: .leading, spacing: 4) {
            ForEach(Array(state.filteredListItems.enumerated()), id:\.offset) { index, item in
                HStack {
                    item.image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .cornerRadius(5)
                    Text(item.title)
                    Spacer()
                }
                .padding(.horizontal, 4)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(item.title.lowercased() == state.itemSelected?.title.lowercased() ? Color.green : Color.clear, lineWidth: 2)
                )
                .cornerRadius(8)
                .onHover { isHovered in
                    if isHovered {
                        state.itemSelected = item
                    }
                }
                .onTapGesture {
                    state.type = item.type
                }.keyboardShortcut(.defaultAction)

            }
        }
    }
}


//MARK: UI Logics
private extension HomeView {

    func openGoogleChrome() {
        do {
            try NSWorkspace.shared.open([state.targetURL], withApplicationAt: state.googleChromeURL, options: [], configuration: [:])
        } catch {
            print("failed")
        }
    }
}
private struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(state: HomeState())
    }
}

