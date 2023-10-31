//
//  CredentialsListView.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 24.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct CredentialsListView: View {

    var store: StoreOf<CredentialsListFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                ForEach(viewStore.state.credentials, id: \.self) { credential in
                    VStack {
                        Text(credential.name)
                        HStack {
                            if credential.data.contains("https") {
                                Link(destination: URL(string: credential.data)!, label: {                                    
                                    Text(credential.data)
                                })
                            } else {
                                Text(credential.data)
                            }
                            Button("Copy data") {
                                viewStore.send(.copy(credential))
                            }
                        }
                    }
                }
                Form {
                    Group {
                        Text("Enter credential name")
                        let nameField = viewStore.binding(get: \.nameField, send: { .nameFieldChanged($0) })
                        TextField("", text: nameField)
                            .modifier(TextFieldClearButtonModifier(text: nameField,
                                                                   clearButtonTapped: {
                                viewStore.send(.clearNameField)
                            }))
                    }
                    Group {
                        Text("Enter credential data")
                        let dataField = viewStore.binding(get: \.dataField, send: { .dataFieldChanged($0) })
                        TextField("", text: dataField)
                            .modifier(TextFieldClearButtonModifier(text: dataField, clearButtonTapped: {
                                viewStore.send(.clearDataField)
                            }))
                    }
                    Button("Add new credential") {
                        viewStore.send(.add)
                        viewStore.send(.clearFields)
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
    CredentialsListView.mock
}
