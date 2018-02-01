//
//  KeyMonitor.swift
//  LeaderKey
//
//  Created by eightpigs on 01/02/2018.
//  Copyright © 2018 刘印龙. All rights reserved.
//

import Foundation
import Cocoa

func exec(name: String) {
    var type : KeyEventType = KeyEventType.Application
    if name.index(of: "/") != nil {
        type = KeyEventType.Folder
    }
    execOpen(name: name, type: type)
}


func execOpen(name: String, type: KeyEventType) {
    if type == KeyEventType.Application {
        NSWorkspace.shared.launchApplication(name)
    } else if type == KeyEventType.Folder {
        shell(command: "/usr/bin/open", args: [name])
    }
}
