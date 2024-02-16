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
    let prStore: StoreOf<PRFeature>
    let switchToAnotherTaskStore: StoreOf<SwitchToAnotherTaskFeature>
    let gitBranchNameStore: StoreOf<GitBranchNameFeature>
    let qaBuildReportStore: StoreOf<QABuildReportFeature>
    let credentialsListStore: StoreOf<CredentialsListFeature>

    init(
        closePopover: @escaping () -> Void,
        taskListStore: StoreOf<TaskNumberListFeature>,
        prStore: StoreOf<PRFeature>,
        switchToAnotherTaskStore: StoreOf<SwitchToAnotherTaskFeature>,
        gitBranchNameStore: StoreOf<GitBranchNameFeature>,
        qaBuildReportStore: StoreOf<QABuildReportFeature>,
        credentialsListStore: StoreOf<CredentialsListFeature>
    ) {
        self.closePopover = closePopover
        self.taskListStore = taskListStore
        self.prStore = prStore
        self.switchToAnotherTaskStore = switchToAnotherTaskStore
        self.gitBranchNameStore = gitBranchNameStore
        self.qaBuildReportStore = qaBuildReportStore
        self.credentialsListStore = credentialsListStore
    }

    init(closePopover: @escaping () -> Void) {
        self.closePopover = closePopover
        taskListStore = Store(initialState: TaskNumberListFeature.State(taskNumbers: [])) {
            TaskNumberListFeature(closePopover: closePopover)._printChanges()
        }
        prStore = Store(initialState: PRFeature.State(link: "")) {
            PRFeature(closePopover: closePopover)._printChanges()
        }
        switchToAnotherTaskStore = Store(initialState: SwitchToAnotherTaskFeature.State(link: "")) {
            SwitchToAnotherTaskFeature(closePopover: closePopover)._printChanges()
        }
        gitBranchNameStore = Store(initialState: GitBranchNameFeature.State()) {
            GitBranchNameFeature(closePopover: closePopover)._printChanges()
        }
       qaBuildReportStore = Store(initialState: QABuildReportFeature.State()) {
                    QABuildReportFeature(closePopover: closePopover)._printChanges()
                }
        credentialsListStore = Store(initialState: CredentialsListFeature.State(credentials: [])) {
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
                     }, prStore: Store(initialState: PRFeature.State.mock) {
                         PRFeature(closePopover: closePopover)._printChanges()
                     }, switchToAnotherTaskStore: Store(initialState: SwitchToAnotherTaskFeature.State.mock) {
                         SwitchToAnotherTaskFeature(closePopover: closePopover)._printChanges()
                     }, gitBranchNameStore: Store(initialState: GitBranchNameFeature.State.mock) {
                         GitBranchNameFeature(closePopover: closePopover)._printChanges()
                     }, qaBuildReportStore: Store(initialState: QABuildReportFeature.State()) {
                         QABuildReportFeature(closePopover: closePopover)._printChanges()
                     }, credentialsListStore: Store(initialState: CredentialsListFeature.State.mock) {
                         CredentialsListFeature(closePopover: closePopover)._printChanges()
                     })
    }
}
