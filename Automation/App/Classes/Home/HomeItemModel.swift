//
//  HomeItemModel.swift
//  Sang's App
//
//  Created by Sang Truong on 10/09/2023.
//

import Foundation
import SwiftUI

protocol Identifiable {
    static var reuseIdentifier: String { get }
}

extension Identifiable {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

struct HomeItemModel: Identifiable {
    var id = UUID()
    let title: String
    let image: Image
    let type: HomeState.submitType
    
    init(title: String, image: Image,type: HomeState.submitType) {
        self.title = title
        self.image = image
        self.type = type
    }
}
