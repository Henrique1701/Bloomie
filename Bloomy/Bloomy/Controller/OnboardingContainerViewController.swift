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
        
        self.selectRootView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
        
        self.homeObserver = NotificationCenter.default.addObserver(forName: .callHome, object: nil, queue: OperationQueue.main) { _ in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            //let homeVC = storyBoard.instantiateViewController(withIdentifier: "HomeTabBar")
            //Todo: Tirar a notification
            //self.present(homeVC, animated: false)
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let initialViewController = storyboard.instantiateInitialViewController()!
            appDelegate.window!.rootViewController = initialViewController
        }
    }
    
    func selectRootView() {
        addChild(onboardingView)
        view.addSubview(onboardingView.view)
        setupOnboardingViewConstraints()
    }
    
    func setupOnboardingViewConstraints() {
        self.onboardingView.view.translatesAutoresizingMaskIntoConstraints = false
        self.onboardingView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.onboardingView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.onboardingView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.onboardingView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
