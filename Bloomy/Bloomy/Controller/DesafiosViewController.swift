//
//  DesafiosViewController.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 09/12/20.
//

import UIKit
import CoreData

class DesafiosViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    lazy var challenges:[Challenge] = getAcceptedChallenges()
    
    // Texto dos desafios
    lazy var dataSource = getChallengeSummary()
    var dataSourceReload : [String] = []
//    let dataSource = ["Atenção Plena",
//                      "Pessoas Queridas",
//                      "Lazer",
//                      "Saúde"]
    
    
    
    // Imagem dos desafios
    let dataSourceImage: [UIImage] = [UIImage(imageLiteralResourceName: "card_atencao_plena"),
                                      UIImage(imageLiteralResourceName: "card_pessoas_queridas"),
                                      UIImage(imageLiteralResourceName: "card_lazer"),
                                      UIImage(imageLiteralResourceName: "card_saude")]
    
    var currentViewControllerIndex = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurePageViewController()
        self.setupNavigationController()
    }
    
    func configurePageViewController() {
        
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing:DesafiosPageViewController.self)) as? DesafiosPageViewController else {
            return
        }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        pageViewController.didMove(toParent:self)
        
        //Auto-layout
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Mudar cor do background
        pageViewController.view.backgroundColor = #colorLiteral(red: 0.9938541055, green: 0.9598969817, blue: 0.9428560138, alpha: 1)
        
        contentView.addSubview(pageViewController.view)
        
        let views: [String: Any] = ["pageView": pageViewController.view as Any]
        
        //A subview inicia no mesmo ponto que a view que a contém
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
    
    
    func detailViewControllerAt(index: Int) -> DesafiosDataViewController? {
        //Garantir que o Page view controller não ultrapasse o limite de páginas
        if (index >= dataSource.count || dataSource.isEmpty) {
            return nil
        }
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing:DesafiosDataViewController.self)) as? DesafiosDataViewController else {
            return nil
        }
        
        dataViewController.index = index
        dataViewController.summaryText = dataSource[index]
        dataViewController.cardImage
            = dataSourceImage[index]
        
        // Verifica se é a última tela
        if index == dataSource.count-1 {
            dataViewController.lastScreen = true
        } else {
            dataViewController.lastScreen = false
        }
        
        return dataViewController
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18) ?? UIFont()]
    }
    
    var islandNameToImage: [String:String] = [
        "Atenção Plena": "card_atencao_plena",
        "Saúde": "card_saude",
        "Pessoas Queridas": "card_pessoas_queridas",
        "Lazer": "card_lazer"
    ]

    //var challenges = getAcceptedChallenges()

    func getAcceptedChallenges() -> [Challenge] {
        var acceptedChallenges: [Challenge] = []
        for island in UserManager.shared.getIslands()! {
            if let dailyChallenge = island.dailyChallenge {
                if dailyChallenge.accepted && !dailyChallenge.done {
                    acceptedChallenges.append(dailyChallenge)
                }
            }
        }
        return acceptedChallenges
    }
    
    func getChallengeSummary() -> [String] {
        var challengeSummary: [String] = []
        for challenge in challenges {
            challengeSummary.append(challenge.summary!)
        }
        return challengeSummary
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataSourceReload = getChallengeSummary()
        dataSource = dataSourceReload
    }

    override func viewWillDisappear(_ animated: Bool) {
        dataSource = []
    }

}

extension DesafiosViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSource.count
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
        
        if currentIndex == dataSource.count {
            return nil
        }
        
        currentIndex += 1
        
        currentViewControllerIndex = currentIndex
        
        return detailViewControllerAt(index: currentIndex)
    }
    
}

