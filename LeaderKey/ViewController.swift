//
//  ViewController.swift
//  LeaderKey
//
//  Created by eightpigs on 01/01/2018.
//  Copyright © 2018 刘印龙. All rights reserved.
//

import Cocoa
import HotKey

class ViewController: NSViewController {

    @IBOutlet weak var ntv_applistTable: NSTableView!
    
    // 所有的应用程序列表
    var appList:[AppItem]? = [AppItem]();
    
    /**
 
 if event.keyCode == 5 {
 self.openApp(app: "Google Chrome");
 } else if event.keyCode == 46 {
 self.openApp(app: "Mail");
 } else if event.keyCode == 18 {
 self.openApp(app: "DingTalk");
 } else if event.keyCode == 19 {
 self.openApp(app: "WeChat");
 } else if event.keyCode == 20 {
 self.openApp(app: "QQ");
 } else if event.keyCode == 1 {
 self.openApp(app: "SourceTree");
 } else if event.keyCode == 1 {
 self.openApp(app: "SourceTree");
 }*/
    
    // 键值 与 具体应用的对应关系
    var keys:Dictionary<Int,String> = [
        5 : "Google Chrome",
        46 : "Mail",
        18 : "DingTalk",
        19 : "WeChat",
        20 : "QQ",
        1 : "SourceTree",
        3 : "Firefox",
        34 : "IntelliJ IDEA",
        33 : "iTerm",
        30 : "Sublime Text",
        45 : "NeteaseMusic",
        2 : "DataGrip",
        0 : "Android Studio",
        8 : "Visual Studio Code",
        14 : "Evernote",
        37 : "~/Downloads/",
        9 : "Vivaldi",
        27 : "System Preferences"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPreferences()
        
        register(self)
        
        loadApps();
        
        self.ntv_applistTable.delegate = self as? NSTableViewDelegate
        self.ntv_applistTable.dataSource = self
    }
    
    private var hotKey: HotKey? {
        didSet {
            guard let hotKey = hotKey else {
                print("un register key")
                return
            }
            
            print("register key successful")
            
            hotKey.keyDownHandler = { [weak self] in
                self?.showWindow();
            }
        }
    }
    
    func unregister(_ sender: Any?) {
        hotKey = nil
    }
    
    func register(_ sender: Any?) {
        hotKey = HotKey(keyCombo: KeyCombo(key: .f18))
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func viewWillAppear() {
        
        toggleDockIcon(showIcon: false)
        
        self.view.window?.titleVisibility = .hidden
        self.view.window?.titlebarAppearsTransparent = true
        
        self.view.window?.styleMask.insert(.fullSizeContentView)
        
        self.view.window?.styleMask.remove(.closable)
        self.view.window?.styleMask.remove(.fullScreen)
        self.view.window?.styleMask.remove(.miniaturizable)
        self.view.window?.styleMask.remove(.resizable)
        
        self.view.window?.isMovable = true
        
        self.view.wantsLayer = true;
        self.view.layer?.backgroundColor = BG_COLOR.cgColor;
        self.view.window?.alphaValue = WINDOW_ALPHA;
        
        self.view.setAccessibilityModal(true)
        
        self.view.window?.setContentSize(NSSize.init(width: BASE_WINDOW_WIDTH , height: BASE_WINDOW_HEIGHT));
        
        self.view.window?.orderOut(self)
        
        NSApp.hide(nil)
        
        self.view.window?.hidesOnDeactivate = true;
    }
    
    override func keyDown(with event: NSEvent) {
        print( "按的内容是：\(event.keyCode)  -   \(event)" )
        let appName: String = keys[ event.keyCode.hashValue ] as! String;
        openApp( app: appName );
    }
    
    /**
     # Show App Lists
     */
    func showWindow(){
        self.view.window?.makeKeyAndOrderFront(self)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    
    /**
     ## toggleDockIcon
     Hide or Show in Dock
     */
    func toggleDockIcon(showIcon state: Bool) {
        if state {
            NSApp.setActivationPolicy(NSApplication.ActivationPolicy.regular)
        }
        else {
            NSApp.setActivationPolicy(NSApplication.ActivationPolicy.accessory)
        }
    }
    
    func loadApps(){
        let image = NSImage.init(named: NSImage.Name(rawValue: "life"))
        for i in 0...10 {
            let item: AppItem = AppItem.init(icon: image!, name: "Test \(i)", prefix: "g");
            appList?.append(item)
        }
    }
    
    func openApp(app: String) {
        NSWorkspace.shared.open(URL(fileURLWithPath: "/Applications/\(app).app"))
    }
}


extension ViewController : NSTableViewDataSource{
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return appList!.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        guard let item = appList?[row] else {
            return nil
        }
        
        if tableColumn?.identifier.rawValue == "appIcon" {
            return item.icon;
        }else if tableColumn?.identifier.rawValue == "appName" {
            return item.name;
        }
        
        return "";
    }
}

