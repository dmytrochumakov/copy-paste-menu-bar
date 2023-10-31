//
//  TextFieldClearButtonModifier.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 26.10.2023.
//

import SwiftUI

struct TextFieldClearButtonModifier: ViewModifier {

    @Binding var text: String
    var clearButtonTapped: () -> Void

    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button(action: {
                    clearButtonTapped()
                }) {
                    Image(systemName: "delete.left")
                        .foregroundColor(Color.gray)
                }
                .padding(.trailing, 8)
            }
        }
    }

}
