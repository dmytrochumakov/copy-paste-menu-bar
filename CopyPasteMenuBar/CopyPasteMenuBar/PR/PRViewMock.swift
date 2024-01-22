//
//  PRViewMock.swift
//  CopyPasteMenuBar
//
//  Created Dmytro Chumakov on 08.01.2024.
//

import Foundation

extension PRView {
    static var mock: Self {
        .init(store: .init(initialState: .mock) {
            PRFeature(closePopover: {})._printChanges()
        })
    }
}
