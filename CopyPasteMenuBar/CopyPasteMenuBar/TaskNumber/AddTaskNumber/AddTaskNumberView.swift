//
//  AddTaskNumberView.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 19.10.2023.
//

import ComposableArchitecture
import SwiftUI

struct AddTaskNumberView: View {
    @Binding var taskNumber: String
    var addTaskButtonTapped: () -> Void
    var clearButtonTapped: () -> Void

    var body: some View {
        VStack {
            TextField("task number", text: $taskNumber)
                .modifier(TextFieldClearButtonModifier(
                    text: $taskNumber,
                    clearButtonTapped: clearButtonTapped
                ))
            Button("add task number") {
                addTaskButtonTapped()
            }
        }
        .padding()
    }
}

#Preview {
    AddTaskNumberView(
        taskNumber: .constant(""),
        addTaskButtonTapped: {},
        clearButtonTapped: {}
    )
}
