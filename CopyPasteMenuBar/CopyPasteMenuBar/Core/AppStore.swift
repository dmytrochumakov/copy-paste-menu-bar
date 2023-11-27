//
//  AppStore.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 31.10.2023.
//

import ComposableArchitecture

struct AppStore {

    let closePopover: () -> Void

    let taskListStore: StoreOf<TaskNumberListFeature>
    let gitBranchNameStore: StoreOf<GitBranchNameFeature>
    let credentialsListStore: StoreOf<CredentialsListFeature>

    init(
        closePopover: @escaping () -> Void,
        taskListStore: StoreOf<TaskNumberListFeature>,
        gitBranchNameStore: StoreOf<GitBranchNameFeature>,
        credentialsListStore: StoreOf<CredentialsListFeature>
    ) {
        self.closePopover = closePopover
        self.taskListStore = taskListStore
        self.gitBranchNameStore = gitBranchNameStore
        self.credentialsListStore = credentialsListStore
    }

    init(closePopover: @escaping () -> Void) {
        self.closePopover = closePopover
        self.taskListStore = Store(initialState: TaskNumberListFeature.State(taskNumbers: [])) {
            TaskNumberListFeature(closePopover: closePopover)._printChanges()
        }
        self.gitBranchNameStore = Store(initialState: GitBranchNameFeature.State()) {
            GitBranchNameFeature(closePopover: closePopover)._printChanges()
        }      
        self.credentialsListStore = Store(initialState: CredentialsListFeature.State.init(credentials: [])) {
            CredentialsListFeature(closePopover: closePopover)._printChanges()
        }
    }

}

extension AppStore {

    static var mock: Self {
        let closePopover: () -> Void = {}
        return .init(closePopover: closePopover,
                     taskListStore: Store(initialState: TaskNumberListFeature.State(taskNumbers: [])) {
            TaskNumberListFeature(closePopover: closePopover)._printChanges()
        }, gitBranchNameStore: Store(initialState: GitBranchNameFeature.State.mock) {
            GitBranchNameFeature(closePopover: closePopover)._printChanges()        
        }, credentialsListStore: Store(initialState: CredentialsListFeature.State.mock) {
            CredentialsListFeature(closePopover: closePopover)._printChanges()
        })
    }

}
