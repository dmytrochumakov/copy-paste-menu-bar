//
//  SwitchToAnotherTaskViewMock.swift
//  CopyPasteMenuBar
//
//  Created Dmytro Chumakov on 08.01.2024.
//

import Foundation

extension SwitchToAnotherTaskView {
    static var mock: Self {
        .init(store: .init(initialState: .mock) {
            SwitchToAnotherTaskFeature(closePopover: {})._printChanges()
        })
    }
}
