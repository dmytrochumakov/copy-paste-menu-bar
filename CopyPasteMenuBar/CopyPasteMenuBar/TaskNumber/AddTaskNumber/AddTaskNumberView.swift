//
//  AddTaskNumberView.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 19.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct AddTaskNumberView: View {

    @State private var taskNumber: String = ""
    var addTaskButtonTapped: (String) -> Void

    var body: some View {
        VStack {
            TextField("task number", text: $taskNumber)
                .modifier(TextFieldClearButtonModifier(text: $taskNumber))
            Button("add task number") {
                addTaskButtonTapped(taskNumber)
            }
        }
        .padding()
    }

}

#Preview {
    AddTaskNumberView(addTaskButtonTapped: { _ in })
}
