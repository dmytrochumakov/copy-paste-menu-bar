//
//  QABuildData.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 23.10.2023.
//

import Foundation

struct QABuildData: Equatable {
    let enviroment:  QABuildReportEnviroment
    let firebaeLink: String
    let azureLink:   String
}
