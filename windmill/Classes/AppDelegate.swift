//
//  AppDelegate.swift
//  windmill
//
//  Created by Markos Charatzas on 07/06/2014.
//  Copyright (c) 2014 qnoid.com. All rights reserved.
//

import AppKit
import Foundation

private let userIdentifier = NSUUID().UUIDString;

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate
{
    @IBOutlet weak var menu: NSMenu!
    
    weak var window: NSWindow!
    var statusItem: NSStatusItem!
    
    var mainWindowController: MainWindowController!
    
    var keychain: Keychain = Keychain.defaultKeychain()
    var scheduler: Scheduler = Scheduler()

    func applicationDidFinishLaunching(aNotification: NSNotification)
    {
        self.statusItem = NSStatusBar.systemStatusItem(self.menu, event:Event(
            action: "mouseDown:",
            target: self,
            mask: NSEventMask.LeftMouseDownMask
            ))
        
        let image = NSImage(named:"windmill")!
        image.setTemplate(true)
        self.statusItem.button?.image = image
        self.statusItem.button?.window?.registerForDraggedTypes([NSFilenamesPboardType])
        self.statusItem.button?.window?.delegate = self
        
        self.keychain.createUser(userIdentifier)
        self.mainWindowController = MainWindowController(windowNibName: "MainWindow")
        self.window = mainWindowController.window
        self.window.makeKeyAndOrderFront(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
    func mouseDown(theEvent: NSEvent)
    {
        let statusItem = self.statusItem
        dispatch_async(dispatch_get_main_queue()){
            statusItem.popUpStatusItemMenu(statusItem.menu!)
        }
    }
    
    
    func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation
    {
        println(__FUNCTION__);
        return .Copy;
    }
    
    func draggingUpdated(sender: NSDraggingInfo) -> NSDragOperation
    {
        return .Copy;
        
    }
    
    func draggingExited(sender: NSDraggingInfo!)
    {
        println(__FUNCTION__);
    }
    
    func prepareForDragOperation(sender: NSDraggingInfo) -> Bool
    {
        println(__FUNCTION__);
        return true;
        
    }
    
    func performDragOperation(sender: NSDraggingInfo) -> Bool
    {
        println(__FUNCTION__);
        let pboard = sender.draggingPasteboard()
        
        if let folder = pboard.firstFilename()
        {
            println(folder)
            self.didPerformDragOperationWithFolder(folder)
            
            return true
        }
        
        return false
    }
    
    func didPerformDragOperationWithFolder(localGitRepo: String) {
        self.deployGitRepo(localGitRepo)
    }
    
    func deployGitRepo(localGitRepo : String)
    {
        let taskOnCommit = NSTask.taskOnCommit(localGitRepo: localGitRepo)
        self.scheduler.queue(taskOnCommit)
        
        if let user = self.keychain.findWindmillUser()
        {
            let deployGitRepoForUserTask = NSTask.taskNightly(localGitRepo: localGitRepo, forUser:user)
            
            deployGitRepoForUserTask.addDependency(taskOnCommit){
                self.scheduler.queue(deployGitRepoForUserTask)
                self.scheduler.schedule {
                    return NSTask.taskPoll(localGitRepo)
                    }(ifDirty: {
                        [unowned self] in
                        self.deployGitRepo(localGitRepo)
                        })
            }
        }
    }
}

