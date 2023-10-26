//
//  CredentialsListFeatureMock.swift
//  CopyPasteMenuBar
//
//  Created Dmytro Chumakov on 26.10.2023.
//

import Foundation

extension CredentialsListFeature.State {

    static var mock: Self {
        .init(credentials: [],
              nameField: "",
              dataField: "")
    }

}
