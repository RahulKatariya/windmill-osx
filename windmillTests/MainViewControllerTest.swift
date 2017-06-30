//
//  MainViewControllerTest.swift
//  windmillTests
//
//  Created by Markos Charatzas on 30/06/2017.
//  Copyright © 2017 qnoid.com. All rights reserved.
//

import XCTest
@testable import windmill

class MainViewControllerTest: XCTestCase {
    
    func testPerformanceExample() {
        
        let standardOutput = "ers/qnoid/.windmill/windmill/windmill/ViewController.swift /Users/qnoid/.windmill/windmill/windmill/AccountResource.swift /Users/qnoid/.windmill/windmill/windmill/WindmillTableViewCell.swift /Users/qnoid/.windmill/windmill/windmill/LoginViewController.swift /Users/qnoid/.windmill/windmill/windmill/Windmill.swift /Users/qnoid/.windmill/windmill/windmill/WindmillTableViewDataSource.swift /Users/qnoid/.windmill/windmill/windmill/WindmillTableViewDelegate.swift /Users/qnoid/.windmill/windmill/windmill/AppDelegate.swift -output-file-map /Users/qnoid/.windmill/windmill/build/Build/Intermediates.noindex/windmill.build/Debug-iphoneos/windmill.build/Objects-normal/arm64/windmill-OutputFileMap.json -parseable-output -serialize-diagnostics -emit-dependencies -emit-module -emit-module-path /Users/qnoid/.windmill/windmill/build/Build/Intermediates.noindex/windmill.build/Debug-iphoneos/windmill.build/Objects-normal/arm64/windmill.swiftmodule -Xcc -I/Users/qnoid/.windmill/windmill/build/Build/Intermediates.noindex/windmill.build/Debug-iphoneos/windmill.build/swift-overrides.hmap -Xcc -iquote -Xcc /Users/qnoid/.windmill/windmill/build/Build/Intermediates.noindex/windmill.build/Debug-iphoneos/windmill.build/windmill-generated-files.hmap -Xcc -I/Users/qnoid/.windmill/windmill/build/Build/Intermediates.noindex/windmill.build/Debug-iphoneos/windmill.build/windmill-own-target-headers.hmap -Xcc -I/Users/qnoid/.windmill/windmill/build/Build/Intermediates.noindex/windmill.build/Debug-iphoneos/windmill.build/windmill-all-target-headers.hmap -Xcc -iquote -Xcc /Users/qnoid/.windmill/windmill/build/Build/Intermediates.noindex/windmill.build/Debug-iphoneos/windmill.build/windmill-project-headers.hmap -Xcc -I/Users/qnoid/.windmill/windmill/build/Build/Products/Debug-iphoneos/include -Xcc -I/Users/qnoid/.windmill/windmill/build/Build/Intermediates.noindex/windmill.build/Debug-iphoneos/windmill.build/DerivedSources/arm64 -Xcc -I/Users/qnoid/.windmill/windmill/build/Build/Intermediates.noindex/windmill.build/Debug-iphoneos/windmill.build/DerivedSources -Xcc -DDEBUG=1 -emit-objc-header -emit-objc-header-path /Users/qnoid/.windmill/windmill/build/Build/Intermediates.noindex/windmill.build/Debug-iphoneos/windmill.build/Objects-normal/arm64/windmill-Swift.h -Xcc -working-directory/Users/qnoid/.windmill/windmill\n\nCompileSwift normal arm64 /Users/qnoid/.windmill/windmill/windmill/WindmillTextView.swift\n    cd /Users/qnoid/.windmill/windmill\n    /Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift -frontend -c -primary-file /Users/qnoid/.windmill/windmill/windmill/WindmillTextView.swift /Users/qnoid/.windmill/windmill/windmill/ViewController.swift /Users/qnoid/.windmill/windmill/windmill/AccountResource.swift /Users/qnoid/.windmill/windmill/windmill/WindmillTableViewCell.swift /Users/qnoid/.windmill/windmill/windmill/LoginViewController.swift /Users/qnoid/.windmill/windmill/windmill/Windmill.swift /Users/qnoid/.windmill/windmill/windmill/WindmillTableViewDataSource.swift /Users/qnoid/.windmill/windmill/windmill/WindmillTableViewDelegate.swift /Users/qnoid/.windmill/windmill/windmill/AppDelegate.swift -target arm64-apple-ios10.3 -Xllvm -aarch64-use-tbi -enable-objc-interop -sdk /Applications/Xcode-beta.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS11.0.sdk -I /Users/qnoid/.windmill/windmill/build/Build/Products/Debug-iphoneos -F /Users/qnoid/.windmill/windmill/build/Build/Products/Debug-iphoneos -enable-testing -g -module-cache-path /Users/qnoid/.windmill/windmill/build/ModuleCache -swift-version 3 -D DEBUG -serialize-debugging-options -Xcc -I/Users/qnoid/.windmill/windmill/build/Build/Intermediates.noindex/windmill.build/Debug-iphoneos/windmill.build/swift-overrides.hmap -Xcc -iquote -Xcc /Users/qnoid/.windmill/windmill/build/Build/Intermediates.noindex/windmill.build/Debug-iphoneos/windmill.build/windmill-generated-files.hmap -Xcc -I/Users/qnoid/.windmill/windmill/build/Build/Intermediates.noindex/windmill.build/Debug-iphoneos/windmill.build/windmill-own-target-headers.hmap -Xcc -I/Users"
        
        let windmill = Windmill()
        let mainViewController = MainViewController.make()
        mainViewController.loadView()
        
        self.measure {
            
            for _ in 0...150 {
                mainViewController.windmill(windmill, standardOutput: standardOutput, count: 4096)
            }
            
            mainViewController.buffer = ""
            mainViewController.location = 0
            mainViewController.textView.string = ""
        }
    }

}
