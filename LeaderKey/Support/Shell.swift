//
//  Shell.swift
//  LeaderKey
//
//  Created by eightpigs on 01/02/2018.
//  Copyright © 2018 刘印龙. All rights reserved.
//

import Foundation

func shell(command: String, args: [String]) {
    let task = Process()
    task.launchPath = command
    task.arguments = args
    task.launch()
}
