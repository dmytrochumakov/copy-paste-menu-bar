//
//  CredentialsListFeature.swift
//  CopyPasteMenuBar
//
//  Created Dmytro Chumakov on 26.10.2023.
//

import Foundation
import ComposableArchitecture

struct Credential: Hashable, Codable {
    let name: String
    let data: String
}

struct CredentialsListFeature: Reducer {

    private let userDefaults: UserDefaults = .standard
    private let credentialKey = "credentialKey"

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .nameFieldChanged(let newValue):
                state.nameField = newValue
                return .none
            case .dataFieldChanged(let newValue):
                state.dataField = newValue
                return .none
            case .add:
                state.credentials.append(.init(name: state.nameField,
                                               data: state.dataField))
                let encoded = try? JSONEncoder().encode(state.credentials)
                userDefaults.set(encoded, forKey: credentialKey)
                return .none
            case .copy(let credential):
                copyToPasteboard(credential.data)
                return .none
            case .load:
                guard
                    let data = userDefaults.object(forKey: credentialKey) as? Data
                else {
                    return .none
                }
                state.credentials = (try? JSONDecoder().decode([Credential].self, from: data)) ?? []
                return .none
            }
        }
    }

    struct State: Equatable {
        var credentials: [Credential]
        var nameField: String = ""
        var dataField: String = ""
    }

    enum Action: Equatable {
        case nameFieldChanged(_ newValue: String)
        case dataFieldChanged(_ newValue: String)
        case add
        case copy(_ credential: Credential)
        case load
    }

}
