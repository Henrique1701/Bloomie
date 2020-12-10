//
//  TabBarDesafiosViewController.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 05/12/20.
//

import UIKit
import SwiftUI

class TabBarDesafiosViewController: UIViewController {
    let contentView = UIHostingController(rootView: ContentView())
    let desafiosVazioView = UIHostingController(rootView: DesafiosVazioView())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectRootView()
        self.setupNavigationController()
    }
    
    func selectRootView() {
        if thereIsAcceptedChallenge() {
            addChild(contentView)
            view.addSubview(contentView.view)
            setupContentViewConstraints()
            
        } else {
            addChild(desafiosVazioView)
            view.addSubview(desafiosVazioView.view)
            setupDesafiosVazioViewConstraints()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectRootView()
        self.reloadInputViews()
    }
    
    func setupContentViewConstraints() {
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupDesafiosVazioViewConstraints() {
       desafiosVazioView.view.translatesAutoresizingMaskIntoConstraints = false
       desafiosVazioView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
       desafiosVazioView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       desafiosVazioView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
       desafiosVazioView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func thereIsAcceptedChallenge() -> Bool {
        if let islands = UserManager.shared.getIslands() {
            for island in islands where island.dailyChallenge!.accepted && !(island.dailyChallenge!.done) {
                return true
            }
        }
        return false
    }
}
