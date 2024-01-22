//
//  GitBranchNameViewMock.swift
//  CopyPasteMenuBar
//
//  Created Dmytro Chumakov on 01.11.2023.
//

import Foundation

extension GitBranchNameView {
    static var mock: Self {
        .init(store: .init(initialState: .mock) {
            GitBranchNameFeature(closePopover: {})._printChanges()
        })
    }
}
