//
//  AppItem.swift
//  LeaderKey
//
//  Created by eightpigs on 01/01/2018.
//  Copyright © 2018 刘印龙. All rights reserved.
//
import Cocoa

class AppItem {
    
    // 应用图片
    var icon: NSImage?
    // 应用名称
    var name: String = "";
    
    // 应用程序的启动快捷键
    var prefix: String = "";
    
    init(){}
    
    init(icon:NSImage, name:String, prefix: String){
        self.icon = icon;
        self.name = name;
        self.prefix = prefix;
    }
}
