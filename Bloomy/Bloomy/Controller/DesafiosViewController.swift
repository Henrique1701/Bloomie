//
//  DesafiosViewController.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 09/12/20.
//

import UIKit
import CoreData

class DesafiosViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var contentView: UIView!
    
    // MARK: Variáveis Globais
    var challenges:[Challenge] = []
    var challengeSummaryDataSource:[String] = []
    var challengeImageDataSource: [UIImage] = []
    var islandsNames: [String] = []
    
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.challenges = getAcceptedChallenges()
        self.challengeSummaryDataSource = getChallengeSummary()
        self.challengeImageDataSource = getChallengesIslandName()
        self.islandsNames = getIslandsNames()
        self.configurePageViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        challenges = getAcceptedChallenges()
        challengeSummaryDataSource = getChallengeSummary()
        challengeImageDataSource = getChallengesIslandName()
        self.islandsNames = getIslandsNames()
        hideContentController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configurePageViewController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        currentViewControllerIndex = 0
    }
    
    // MARK: Navigation Bar
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
    }

    // MARK: Page View Controller
    func configurePageViewController() {
        
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing:DesafiosPageViewController.self)) as? DesafiosPageViewController else {
            return
        }
        
        guard let noChallengeViewController = storyboard?.instantiateViewController(withIdentifier: String(describing:DesafiosVazioViewController.self)) as? DesafiosVazioViewController else {
            return
        }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        pageViewController.didMove(toParent:self)
        
        pageViewController.view.backgroundColor = #colorLiteral(red: 0.9938541055, green: 0.9598969817, blue: 0.9428560138, alpha: 1)
        
        if (challenges.isEmpty) {
            contentView.addSubview(noChallengeViewController.view)
        } else {
            contentView.addSubview(pageViewController.view)
            
            pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            let views: [String: Any] = ["pageView": pageViewController.view as Any]
            
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",
                                                                      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                      metrics: nil,
                                                                      views: views))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",
                                                                      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                      metrics: nil,
                                                                      views: views))
            
            guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else {
                return
            }
            pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
        }
    }
    
    func detailViewControllerAt(index: Int) -> DesafiosDataViewController? {
        // Garantir que o Page view controller não ultrapasse o limite de páginas
        if (index >= challengeSummaryDataSource.count || challengeSummaryDataSource.isEmpty) {
            return nil
        }
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing:DesafiosDataViewController.self)) as? DesafiosDataViewController else {
            return nil
        }
        
        dataViewController.index = index
        dataViewController.summaryText = challengeSummaryDataSource[index]
        dataViewController.cardImage
            = challengeImageDataSource[index]
        dataViewController.islandName = islandsNames[index]
        
        if index == challengeSummaryDataSource.count-1 {
            dataViewController.lastScreen = true
        } else {
            dataViewController.lastScreen = false
        }
        
        return dataViewController
    }
    
    // MARK: Dados que serão usados nas páginas do Page View Controller
    var islandNameToImage: [String:String] = [
        "Atenção Plena": "card_atencao_plena",
        "Saúde": "card_saude",
        "Pessoas Queridas": "card_pessoas_queridas",
        "Lazer": "card_lazer"
    ]
    
    func getAcceptedChallenges() -> [Challenge] {
        var acceptedChallenges: [Challenge] = []
        let islands = getSortedIslands(islands: UserManager.shared.getIslands()!)
        for island in  islands {
            if let dailyChallenge = island.dailyChallenge {
                if dailyChallenge.accepted && !dailyChallenge.done {
                    acceptedChallenges.append(dailyChallenge)
                }
            }
        }
        return acceptedChallenges
    }
    
    func getSortedIslands(islands: [Island]) -> [Island] {
        var sortedIslands: [Island] = []
        let islandsNames = [
            IslandsNames.health.rawValue,
            IslandsNames.leisure.rawValue,
            IslandsNames.mindfulness.rawValue,
            IslandsNames.loveds.rawValue
        ]
        
        for islandName in islandsNames {
            if let island = IslandManager.shared.getIsland(withName: islandName) {
                sortedIslands.append(island)
            }
        }
        
        return sortedIslands
    }
    
    func getIslandsNames() -> [String] {
        var islandsNames: [String] = []
        for challenge in challenges {
            islandsNames.append(challenge.challengeToIsland!.name!)
        }
        return islandsNames
    }
    
    func getChallengeSummary() -> [String] {
        var challengeSummary: [String] = []
        for challenge in challenges {
            challengeSummary.append(challenge.summary!)
        }
        return challengeSummary
    }
    
    func getChallengesIslandName() -> [UIImage] {
        var challengeIslandName: [UIImage] = []
        for challenge in challenges {
            challengeIslandName.append(UIImage(imageLiteralResourceName: islandNameToImage[challenge.challengeToIsland!.name!]!))
        }
        return challengeIslandName
    }
    
    func hideContentController() {
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing:DesafiosPageViewController.self)) as? DesafiosPageViewController else {
            return
        }
        // Reseta o Delegate do Page View Controller
        pageViewController.dataSource = nil
    }
    
    @objc func updatePageViewController() {
        DispatchQueue.main.async {
            self.hideContentController()
            self.configurePageViewController()
        }
    }
}

// MARK: Page View Controller Protocols
extension DesafiosViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return challengeSummaryDataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? DesafiosDataViewController
        
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        
        currentViewControllerIndex = currentIndex
        
        if currentIndex == 0 {
            return nil
        }
        
        currentIndex -= 1
        
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let dataViewController = viewController as? DesafiosDataViewController
        
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        
        if currentIndex == challengeSummaryDataSource.count {
            return nil
        }
        
        currentIndex += 1
        
        currentViewControllerIndex = currentIndex
        
        return detailViewControllerAt(index: currentIndex)
    }
}
