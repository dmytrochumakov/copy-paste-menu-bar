//
//  CredentialsListFeature.swift
//  CopyPasteMenuBar
//
//  Created Dmytro Chumakov on 26.10.2023.
//

import ComposableArchitecture
import Foundation

public struct Credential: Hashable, Codable {
    let name: String
    let data: String
}

@Reducer
public struct CredentialsListFeature {
    let closePopover: () -> Void

    private let userDefaults: UserDefaults = .standard
    private let credentialKey = "credentialKey"

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .nameFieldChanged(newValue):
                state.nameField = newValue
                return .none
            case let .dataFieldChanged(newValue):
                state.dataField = newValue
                return .none
            case .add:
                state.credentials.append(.init(
                    name: state.nameField,
                    data: state.dataField
                ))
                let encoded = try? JSONEncoder().encode(state.credentials)
                userDefaults.set(encoded, forKey: credentialKey)
                return .none
            case let .copy(credential):
                copyToPasteboard(credential.data)
                closePopover()
                return .none
            case .load:
                guard let data = userDefaults.object(forKey: credentialKey) as? Data
                else {
                    return .none
                }
                state.credentials = (try? JSONDecoder().decode([Credential].self, from: data)) ?? []
                return .none
            case .clearNameField:
                state.nameField = ""
                return .none
            case .clearDataField:
                state.dataField = ""
                return .none
            case .clearFields:
                state.nameField = ""
                state.dataField = ""
                return .none
            case .openURL:
                closePopover()
                return .none
            }
        }
    }

    public struct State: Equatable {
        var credentials: [Credential]
        var nameField: String = ""
        var dataField: String = ""
    }

    public enum Action: Equatable {
        case nameFieldChanged(_ newValue: String)
        case dataFieldChanged(_ newValue: String)
        case add
        case copy(_ credential: Credential)
        case load
        case clearNameField
        case clearDataField
        case clearFields
        case openURL
    }
}
