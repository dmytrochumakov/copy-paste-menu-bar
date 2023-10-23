//
//  QABuildReportEnviroment.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 23.10.2023.
//

import Foundation

enum QABuildReportEnviroment: String, CaseIterable {

    case stage
    case prod
    case test
    case dev
    case unknown

}
