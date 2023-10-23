//
//  CopyTaskNumberView.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 19.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct CopyTaskNumberView: View {

    var copyButtonTapped: () -> Void

    var body: some View {
        Button("Copy") {
            copyButtonTapped()
        }
    }

}

#Preview {
    CopyTaskNumberView(copyButtonTapped: {})
}
