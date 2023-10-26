//
//  TextFieldClearButtonModifier.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 26.10.2023.
//

import SwiftUI

struct TextFieldClearButtonModifier: ViewModifier {

    @Binding var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "delete.left")
                        .foregroundColor(Color.gray)
                }
                .padding(.trailing, 8)
            }
        }
    }

}
