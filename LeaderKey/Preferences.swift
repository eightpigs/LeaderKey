//
//  Preferences.swift
//  LeaderKey
//
//  Created by eightpigs on 01/01/2018.
//  Copyright © 2018 刘印龙. All rights reserved.
//

import Foundation

func preferencesHome() -> String {
    return NSHomeDirectory() + "/Documents/launcher/";
}

func initPreferences(){
    let home = preferencesHome();
    let fileManager = FileManager.default
    let folderExists = fileManager.fileExists(atPath: home);
    if(!folderExists){
       try! fileManager.createDirectory(atPath: home, withIntermediateDirectories: true, attributes: nil);
    }
    
    try! "[{name:\"Google Chrome\", prefix:\"g\"}]".write(toFile: home + "/apps.json", atomically: true, encoding: String.Encoding.utf8);
}

func saveWithNSUserDefaults() {
    // 1、利用NSUserDefaults存储数据
    let defaults = UserDefaults.standard
    // 2、存储数据
    defaults.set("衣带渐宽终不悔", forKey: "name")
    // 3、同步数据
    defaults.synchronize()
}

func readWithNSUserDefaults(){
    let defaults = UserDefaults.standard
    let name = defaults.string(forKey: "name")
    let `switch` = defaults.bool(forKey: "bool")
    print(name)
    print(`switch`)
}
