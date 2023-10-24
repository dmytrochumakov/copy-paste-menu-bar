//
//  CredentialsListView.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 24.10.2023.
//

import SwiftUI
import ComposableArchitecture

enum CredentialType: String, CaseIterable {

    case testPhone
    case testOTPCode
    case vpnPin
    case zoomLink

    var data: String {
        switch self {
        case .testPhone:
            return "505 47 01 54"
        case .testOTPCode:
            return "0000"
        case .vpnPin:
            return "147258369"
        case .zoomLink:
            return "https://eur05.safelinks.protection.outlook.com/?url=https%3A%2F%2Fus05web.zoom.us%2Fj%2F5465688336%3Fpwd%3DWE5IWm95YVpVc2J4VU92SjE5VW9ZUT09&data=05%7C01%7Cdchumakov%40competo.io%7C72a07955554c42dd20cc08dbb2a52a4c%7Ccaa950687cc14c41925f875c22a5c4c9%7C0%7C0%7C638300194664852159%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=fGwSCd68jhUe3gFZgP%2FUx3n%2BWR%2FNrm32lvXbcHQ2qb8%3D&reserved=0"
        }
    }

}

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
            case .copy:
                let pasteboard = NSPasteboard.general
                pasteboard.declareTypes([.string], owner: nil)
                pasteboard.setString(state.dataField, forType: .string)
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
        case copy
        case load
    }

}
extension CredentialsListFeature.State {
    static var mock: Self {
        .init(credentials: [],
              nameField: "",
              dataField: "")
    }
}
struct CredentialsListView: View {

    var store: StoreOf<CredentialsListFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                ForEach(viewStore.state.credentials, id: \.self) { credential in
                    VStack {
                        Text(credential.name)
                        HStack {
                            Text(credential.data)
                            Button("Copy data") {
                                viewStore.send(.copy)
                            }
                        }
                    }
                }
                Form {
                    Group {
                        Text("Enter credential name")
                        TextField("", text: viewStore.binding(get: \.nameField, send: { .nameFieldChanged($0) }))
                    }
                    Group {
                        Text("Enter credential data")
                        TextField("", text: viewStore.binding(get: \.dataField, send: { .dataFieldChanged($0) }))
                    }
                    Button("Add new credential") {
                        viewStore.send(.add)
                    }
                }
            }
        }
        .onAppear {
            store.send(.load)
        }
    }

}

#Preview {
    CredentialsListView(store: .init(initialState: .mock) {
        CredentialsListFeature()._printChanges()
    })
}
