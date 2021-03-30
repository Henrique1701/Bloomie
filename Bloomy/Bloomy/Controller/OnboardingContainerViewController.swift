//
//  OnboardingContainerViewController.swift
//  Bloomy
//
//  Created by Wilton Ramos on 04/03/21.
//

import UIKit
import SwiftUI

class OnboardingContainerViewController: UIViewController {
    let onboardingView = UIHostingController(rootView: Onboarding())
    var homeObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setRootView()
        self.setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        callHome()
    }
    
    func setRootView() {
        addChild(onboardingView)
        view.addSubview(onboardingView.view)
    }
    
    func setupConstraints() {
        self.onboardingView.view.translatesAutoresizingMaskIntoConstraints = false
        self.onboardingView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.onboardingView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.onboardingView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.onboardingView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func callHome() {
        self.homeObserver = NotificationCenter.default.addObserver(forName: .callHome, object: nil, queue: OperationQueue.main) { _ in
            let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let homeViewController = homeStoryboard.instantiateInitialViewController()!
            appDelegate.window!.rootViewController = homeViewController
        }
    }
}
