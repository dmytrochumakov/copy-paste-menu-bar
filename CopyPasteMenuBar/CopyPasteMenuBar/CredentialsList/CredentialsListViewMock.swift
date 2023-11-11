//
//  CredentialsListViewMock.swift
//  CopyPasteMenuBar
//
//  Created Dmytro Chumakov on 26.10.2023.
//

import Foundation

extension CredentialsListView {

    static var mock: Self {
        .init(store: .init(initialState: .mock) {
            CredentialsListFeature(closePopover: {})._printChanges()
        })
    }

}
