//
//  SreenShotView.swift
//  Automation
//
//  Created by Sang Truong on 12/09/2023.
//

import SwiftUI

struct SreenShotView: View {
    var onAction: (() -> Void)
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onDisappear {
                onAction()
            }
    }
}
