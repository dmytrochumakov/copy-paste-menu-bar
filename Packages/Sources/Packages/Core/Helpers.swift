//
//  Helpers.swift
//  CopyPasteMenuBar
//
//  Created by Dmytro Chumakov on 26.10.2023.
//

import AppKit

func copyToPasteboard(_ string: String) {
    let pasteboard = NSPasteboard.general
    pasteboard.declareTypes([.string], owner: nil)
    pasteboard.setString(string, forType: .string)
}
