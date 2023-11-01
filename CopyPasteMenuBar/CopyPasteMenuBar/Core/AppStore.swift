//
//  AppStore.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 31.10.2023.
//

import ComposableArchitecture

struct AppStore {

    let taskListStore: StoreOf<TaskNumberListFeature>
    let gitBranchNameStore: StoreOf<GitBranchNameFeature>
    let qaBuildReportStore: StoreOf<QABuildReportFeature>
    let credentialsListStore: StoreOf<CredentialsListFeature>

    init(
        taskListStore: StoreOf<TaskNumberListFeature>,
        gitBranchNameStore: StoreOf<GitBranchNameFeature>,
        qaBuildReportStore: StoreOf<QABuildReportFeature>,
        credentialsListStore: StoreOf<CredentialsListFeature>
    ) {
        self.taskListStore = taskListStore
        self.gitBranchNameStore = gitBranchNameStore
        self.qaBuildReportStore = qaBuildReportStore
        self.credentialsListStore = credentialsListStore
    }

    init() {
        self.taskListStore = Store(initialState: TaskNumberListFeature.State(taskNumbers: [])) {
            TaskNumberListFeature()._printChanges()
        }
        self.gitBranchNameStore = Store(initialState: GitBranchNameFeature.State()) {
            GitBranchNameFeature()._printChanges()
        }
        self.qaBuildReportStore = Store(initialState: QABuildReportFeature.State()) {
            QABuildReportFeature()._printChanges()
        }
        self.credentialsListStore = Store(initialState: CredentialsListFeature.State.init(credentials: [])) {
            CredentialsListFeature()._printChanges()
        }
    }

}

extension AppStore {

    static var mock: Self {
        .init(taskListStore: Store(initialState: TaskNumberListFeature.State(taskNumbers: [])) {
            TaskNumberListFeature()._printChanges()
        }, gitBranchNameStore: Store(initialState: GitBranchNameFeature.State.mock) {
            GitBranchNameFeature()._printChanges()
        }, qaBuildReportStore: Store(initialState: QABuildReportFeature.State()) {
            QABuildReportFeature()._printChanges()
        }, credentialsListStore: Store(initialState: CredentialsListFeature.State.mock) {
            CredentialsListFeature()._printChanges()
        })
    }

}
