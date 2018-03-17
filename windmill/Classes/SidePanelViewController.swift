//
//  SidePanelViewController.swift
//  windmill
//
//  Created by Markos Charatzas on 26/08/2017.
//  Copyright © 2017 qnoid.com. All rights reserved.
//

import AppKit
import os

class SidePanelViewController: NSViewController {
    
    weak var gridView: NSGridView!
    
    // MARK: Checkout views
    lazy var checkout: NSTextField = {
        let checkout = NSTextField(labelWithString: "checkout")
        checkout.isHidden = true
        return checkout
    }()
    
    lazy var origin: NSTextField = {
        let origin = NSTextField(labelWithString: "Origin:")
        origin.isHidden = true
        return origin
    }()
        
    lazy var originValue: NSTextField = {
        let originValue = NSTextField(labelWithString: "")
        originValue.isHidden = true
        originValue.isSelectable = true
        return originValue
    }()
    
    // MARK: Build views
    
    lazy var build: NSTextField = {
        let build = NSTextField(labelWithString: "build")
        build.isHidden = true
        return build
    }()
    
    lazy var buildConfiguration: NSTextField = {
        let buildConfiguration = NSTextField(labelWithString: "Configuration:")
        buildConfiguration.isHidden = true
        return buildConfiguration
    }()
    
    lazy var buildConfigurationValue: NSTextField = {
        let buildConfigurationValue = NSTextField(labelWithString: "Debug")
        buildConfigurationValue.isHidden = true
        buildConfigurationValue.isSelectable = true
        return buildConfigurationValue
    }()
    
    // MARK: Test views
    
    lazy var test: NSTextField = {
        let test = NSTextField(labelWithString: "test")
        test.isHidden = true
        return test
    }()
    
    lazy var platform: NSTextField = {
        let destination = NSTextField(labelWithString: "Platform:")
        destination.isHidden = true
        return destination
    }()
    
    lazy var platformValue: NSTextField = {
        let destinationValue = NSTextField(labelWithString:  "iOS Simulator")
        destinationValue.isHidden = true
        destinationValue.isSelectable = true
        
        return destinationValue
    }()
    
    lazy var platformVersion: NSTextField = {
        let deploymentTarget = NSTextField(labelWithString: "Version:")
        deploymentTarget.isHidden = true
        return deploymentTarget
    }()
    
    lazy var platformVersionValue: NSTextField = {
        let platformVersionValue = NSTextField(labelWithString:  "10.3")
        platformVersionValue.isHidden = true
        platformVersionValue.isSelectable = true
        return platformVersionValue
    }()
    
    lazy var platformName: NSTextField = {
        let platformName = NSTextField(labelWithString: "Name:")
        platformName.isHidden = true
        return platformName
    }()
    
    lazy var platformNameValue: NSTextField = {
        let platformNameValue = NSTextField(labelWithString:  "Generic iOS Device")
        platformNameValue.isHidden = true
        platformNameValue.isSelectable = true
        return platformNameValue
    }()

    // MARK: Archive views
    
    lazy var archive: NSTextField = {
        let archive = NSTextField(labelWithString: "archive")
        archive.isHidden = true
        return archive
    }()

    lazy var archiveScheme: NSTextField = {
        let certificate = NSTextField(labelWithString: "Scheme:")
        certificate.isHidden = true
        return certificate
    }()
    
    lazy var archiveSchemeValue: NSTextField = {
        let certificate = NSTextField(labelWithString: "[Scheme]")
        certificate.isHidden = true
        return certificate
    }()

    lazy var archiveConfiguration: NSTextField = {
        let archiveConfiguration = NSTextField(labelWithString: "Configuration:")
        archiveConfiguration.isHidden = true
        return archiveConfiguration
    }()

    lazy var archiveConfigurationValue: NSTextField = {
        let archiveConfigurationValue = NSTextField(labelWithString: "Release")
        archiveConfigurationValue.isHidden = true
        archiveConfigurationValue.isSelectable = true
        return archiveConfigurationValue
    }()
    
    lazy var archiveCertificate: NSTextField = {
        let certificate = NSTextField(labelWithString: "Signing Certificate:")
        certificate.isHidden = true
        return certificate
    }()

    lazy var archiveCertificateValue: NSTextField = {
        let certificate = NSTextField(labelWithString: "[Certificate]")
        certificate.isHidden = true
        return certificate
    }()

    
    // MARK: Export views
    lazy var export: NSTextField = {
        let export = NSTextField(labelWithString: "export")
        export.isHidden = true
        return export
    }()
    
    lazy var certificate: NSTextField = {
        let certificate = NSTextField(labelWithString: "Signing Certificate:")
        certificate.isHidden = true
        return certificate
    }()
    
    lazy var certificateValue: NSTextField = {
        let certificateValue = NSTextField(labelWithString:  "iOS Distribution: Markos Charatzas (AQ2US2UQQ7)")
        certificateValue.isHidden = true
        certificateValue.isSelectable = true
        return certificateValue
    }()

    lazy var certificateExpiryDate: NSTextField = {
        let certificateExpiryDate = NSTextField(labelWithString: "Expires:")
        certificateExpiryDate.isHidden = true
        return certificateExpiryDate
    }()
    
    lazy var certificateExpiryDateValue: NSTextField = {
        let certificateExpiryDateValue = NSTextField(labelWithString:  "Jan 29, 2018")
        certificateExpiryDateValue.isHidden = true
        certificateExpiryDateValue.isSelectable = true
        return certificateExpiryDateValue
    }()
    
    lazy var provisioning: NSTextField = {
        let provisioning = NSTextField(labelWithString:  "Provisioning Profile:")
        provisioning.isHidden = true
        return provisioning
    }()
    
    lazy var provisioningValue: NSTextField = {
        let provisioningValue = NSTextField(labelWithString: "iOS Team Ad Hoc Provisioning Profile: io.windmill.windmill")
        provisioningValue.isHidden = true
        provisioningValue.isSelectable = true
        return provisioningValue
    }()
    
    // MARK: Deploy views
    lazy var deploy: NSTextField = {
        let deploy = NSTextField(labelWithString: "deploy")
        deploy.isHidden = true
        return deploy
    }()
    
    lazy var acccount: NSTextField = {
        let acccount = NSTextField(labelWithString: "Account:")
        acccount.isHidden = true
        return acccount
    }()
    
    lazy var accountValue: NSTextField = {
        let accountValue = NSTextField(labelWithString: (try? Keychain.defaultKeychain().findWindmillUser()) ?? "")
        accountValue.isHidden = true
        accountValue.isSelectable = true
        return accountValue
    }()
    
    weak var topConstraint: NSLayoutConstraint!
    
    lazy var archiveSection: (configuration: NSTextField, scheme: NSTextField, certificate: NSTextField) = { [unowned self] in
        return (configuration: archiveConfiguration, scheme: self.archiveScheme, certificate: self.archiveCertificate)
        }()
    
    lazy var archiveValues: (configurationValue: NSTextField, schemeValue: NSTextField, certificateValue: NSTextField) = { [unowned self] in
        return (configurationValue: archiveConfigurationValue, schemeValue: self.archiveSchemeValue, certificateValue: self.archiveCertificateValue)
        }()

    let defaultCenter = NotificationCenter.default
    
    weak var windmill: Windmill? {
        didSet {
            self.defaultCenter.addObserver(self, selector: #selector(willStartProject(_:)), name: Windmill.Notifications.willStartProject, object: windmill)
            self.defaultCenter.addObserver(self, selector: #selector(activityDidLaunch(_:)), name: Windmill.Notifications.activityDidLaunch, object: windmill)
            self.defaultCenter.addObserver(self, selector: #selector(activityDidExitSuccesfully(_:)), name: Windmill.Notifications.activityDidExitSuccesfully, object: windmill)
        }
    }
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/YYYY")
        
        return dateFormatter
    }()

    override func updateViewConstraints() {
        
        if(self.topConstraint == nil) {
            if let topAnchor = (self.view.window?.contentLayoutGuide as AnyObject).topAnchor {
                topConstraint = self.gridView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
                topConstraint.isActive = true
            }
        }
        
        super.updateViewConstraints()
    }
    
    private func layout() {
        
        let empty = NSGridCell.emptyContentView
        
        let gridView = NSGridView(views: [
            [checkout, empty],
            [origin, originValue],
            [build, empty],
            [buildConfiguration, buildConfigurationValue],
            [test, empty],
            [platform, platformValue],
            [platformVersion, platformVersionValue],
            [platformName, platformNameValue],
            [archive, empty],
            [archiveConfiguration, archiveConfigurationValue],
            [archiveScheme, archiveSchemeValue],
            [archiveCertificate, archiveCertificateValue],
            [export, empty],
            [certificate, certificateValue],
            [certificateExpiryDate, certificateExpiryDateValue],
            [provisioning, provisioningValue],
            [deploy, empty],
            [acccount, accountValue]
            ])
        
        self.view.wml_addSubview(view: gridView, layout: .equalWidth)
        self.gridView = gridView
        
        gridView.column(at: 0).xPlacement = .trailing
        gridView.rowAlignment = .firstBaseline
        
        headerCell(for: checkout, cell:gridView.cell(for:checkout)!)
        headerCell(for: build, cell:gridView.cell(for:build)!)
        headerCell(for: test, cell:gridView.cell(for:test)!)
        headerCell(for: archive, cell:gridView.cell(for:archive)!)
        headerCell(for: export, cell:gridView.cell(for:export)!)
        headerCell(for: deploy, cell:gridView.cell(for:deploy)!)
    }
    
    func headerCell(for view: NSTextField, cell: NSGridCell) {
        cell.row!.topPadding = 10
        view.font = NSFont(name: view.font!.fontName, size: 18)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
    }
    
    @objc func willStartProject(_ aNotification: Notification) {
        for activityView in self.gridView.subviews {
            activityView.isHidden = true
        }
    }
    
    @objc func activityDidLaunch(_ aNotification: Notification) {
        
        guard let activity = aNotification.userInfo?["activity"] as? ActivityType else {
            return
        }

        switch activity {
        case .build:
            self.build.isHidden = false
            self.buildConfiguration.isHidden = false
            self.buildConfigurationValue.isHidden = false
            self.buildConfigurationValue.stringValue = Configuration.debug.name
        case .test:
            let devices = aNotification.userInfo?["devices"] as? Devices
            let destination = aNotification.userInfo?["destination"] as? Devices.Destination
            
            self.test.isHidden = false
            self.platform.isHidden = false
            self.platformValue.isHidden = false
            self.platformValue.stringValue = devices?.platform == nil ? "N/A" : "iOS Simulator"
            self.platformVersion.isHidden = false
            self.platformVersionValue.isHidden = false
            self.platformVersionValue.stringValue = devices?.version?.description ?? "N/A"
            self.platformName.isHidden = false
            self.platformNameValue.isHidden = false
            self.platformNameValue.stringValue = destination?.name ?? "N/A"
        case .archive:
            self.archive.isHidden = false
            self.archiveSection.configuration.isHidden = false
            self.archiveValues.configurationValue.isHidden = false
            self.archiveValues.configurationValue.stringValue = Configuration.release.name
        default:
            break
        }
    }
    
    @objc func activityDidExitSuccesfully(_ aNotification: Notification) {
                
        guard let activity = aNotification.userInfo?["activity"] as? ActivityType else {
            return
        }

        switch activity {
        case .checkout:
            guard let repositoryLocalURL = aNotification.userInfo?["repositoryLocalURL"] as? URL, let commit = try? Repository.parse(localGitRepoURL: repositoryLocalURL) else {
                os_log("Repository for project not found. Have you cloned it?", log: .default, type: .debug)
                return
            }
            
            self.checkout.isHidden = false
            
            self.origin.isHidden = false
            self.originValue.stringValue = commit.repository.origin
            self.originValue.isHidden = false
        case .archive:
            guard let archive = aNotification.userInfo?["archive"] as? Archive else {
                return
            }

            let info = archive.info
            
            self.archiveSection.certificate.isHidden = false
            self.archiveCertificateValue.isHidden = false
            self.archiveCertificateValue.stringValue = info.signingIdentity
            self.archiveSection.scheme.isHidden = false
            self.archiveValues.schemeValue.stringValue = info.schemeName ?? ""
            self.archiveValues.schemeValue.isHidden = false
        case .export:
            guard let export = aNotification.userInfo?["export"] as? Export else {
                return
            }

            let distributionSummary = export.distributionSummary
            
            self.export.isHidden = false
            self.certificate.isHidden = false
            self.certificateValue.isHidden = false
            self.certificateValue.stringValue = distributionSummary.certificateType

            if let expiryDate = distributionSummary.certificateExpiryDate {
                self.certificateExpiryDate.isHidden = false
                self.certificateExpiryDateValue.isHidden = false
                self.certificateExpiryDateValue.stringValue = self.dateFormatter.string(from: expiryDate)
            }

            self.provisioning.isHidden = false
            self.provisioningValue.isHidden = false
            self.provisioningValue.stringValue = distributionSummary.profileName
            
        case .deploy:
            self.deploy.isHidden = false
            self.acccount.isHidden = false
            self.accountValue.isHidden = false
        default:
            break
        }
    }
    
    func toggle(isHidden: Bool) {
        self.gridView?.isHidden = isHidden
    }
}
