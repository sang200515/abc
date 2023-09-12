//
//  HomeViewState.swift
//  Sang's App
//
//  Created by Sang Truong on 09/09/2023.
//

import Foundation
import SwiftUI

final class HomeState: ObservableObject {
    @Published var searchText: String = ""
    @Published var query: String = ""
    @Published  var onFocused: Bool = false
    @FocusState var isTextFieldActive: Bool
    @Published var itemSelected: HomeItemModel? =  HomeItemModel( title: "Json Formater", image: Image("jsonFormater"), type: .home)
    @Published var type: HomeState.submitType = .home
    private(set) var listItems: [HomeItemModel] = [
        HomeItemModel( title: "Ruler like Figma", image: Image("fm"), type: .ruler),
        HomeItemModel( title: "Json Formater", image: Image("jsonFormater"), type: .jsonFormater),
        HomeItemModel(title: "Translate", image: Image("translate"), type: .translate)
    ]

    var filteredListItems: [HomeItemModel] {
        if searchText.isEmpty {
            return listItems
        } else {
           return listItems.filter { $0.title.lowercased().localizedCaseInsensitiveContains(searchText.lowercased()) }
        }
    }

    enum submitType {
        case jsonFormater
        case translate
        case ruler
        case home
    }

    //Chorme
    let googleChromeURL = URL(fileURLWithPath: "/Applications/Google Chrome.app")
    var targetURL: URL {
        URL(string: "https://translate.google.com/?hl=vi&sl=en&tl=vi&text=\(AppData().getClipboardValue())&op=translate") ?? URL(string: "https://translate.google.com/?hl=vi&sl=en&tl=vi&op=translate")!
    }
}
