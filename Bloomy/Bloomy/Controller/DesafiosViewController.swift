//
//  DesafiosViewController.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 09/12/20.
//

import UIKit
import CoreData

class DesafiosViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurePageViewController()
        //self.updatePageViewController()
        self.setupNavigationController()
        print("ENTROU")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.configurePageViewController()
        updatePageViewController()
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        hideContentController()
//    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed { return }
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing:DesafiosPageViewController.self)) as? DesafiosPageViewController else {
            return
        }
        DispatchQueue.main.async() {
            pageViewController.dataSource = nil
            pageViewController.dataSource = self
            print("vai funcionar")
        }
    }
    
    

    
    
    // MARK: Navigation Bar
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    // MARK: Page View Controller
    @IBOutlet weak var contentView: UIView!
    
    // Identificar quais desafios foram aceitos
    lazy var challenges:[Challenge] = getAcceptedChallenges()
    
    // Identificar o texto dos desafios aceitos
    lazy var dataSource = getChallengeSummary()
    
    // Imagem dos desafios
    lazy var dataSourceImage: [UIImage] = getChallengesIslandName()
    
    var currentViewControllerIndex = 0
    
    lazy var pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing:DesafiosPageViewController.self)) as? DesafiosPageViewController
    
    // Lógica de inicialização do PageViewController
    func configurePageViewController() {
        
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing:DesafiosPageViewController.self)) as? DesafiosPageViewController else {
            return
        }
        
        // Protocolos
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
        
        print("==================================")
        print("configurePageViewController")
        print("==================================")
    }
    
    // Gera a página do Page View Controller
    func detailViewControllerAt(index: Int) -> DesafiosDataViewController? {
        // Garantir que o Page view controller não ultrapasse o limite de páginas
        if (index >= dataSource.count || dataSource.isEmpty) {
            return nil
        }
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing:DesafiosDataViewController.self)) as? DesafiosDataViewController else {
            return nil
        }
        //updatePageViewController()
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
    
    
    // MARK: Dados que serão usados nas páginas do Page View Controller
    // Converte o nome da ilha para o nome da imagem do card correspondente à ilha
    var islandNameToImage: [String:String] = [
        "Atenção Plena": "card_atencao_plena",
        "Saúde": "card_saude",
        "Pessoas Queridas": "card_pessoas_queridas",
        "Lazer": "card_lazer"
    ]
    
    // Retorna do Core Data quais são os challenges aceitos que ainda não foram concluídos
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
    
    // Retorna o texto dos challenges
    func getChallengeSummary() -> [String] {
        var challengeSummary: [String] = []
        for challenge in challenges {
            challengeSummary.append(challenge.summary!)
        }
        return challengeSummary
    }
    
    // Retorna os nomes das imagens correspondente à ilha de cada challenge
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
        pageViewController.willMove(toParent: nil)
        pageViewController.view.removeFromSuperview()
        pageViewController.removeFromParent()
//        pageViewController.dataSource = nil
//        pageViewController.dataSource = self
        print("==================================")
        print("==================================")
        print("Hide View Controller")
        print("==================================")
    }
    
    @objc func updatePageViewController() {
        print("----------------")
        print("---- Entrou ----")
        print("---- Update ----")
        print("----------------")
        DispatchQueue.main.async {
            //self.hideContentController()
            self.configurePageViewController()
//            self.dataSource = self.getChallengeSummary()
//            self.dataSourceImage = self.getChallengesIslandName()
            
        }
        
    }
}

// MARK: Page View Controller Protocols
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
    
    func setViewControllers(_ viewControllers: [UIViewController]?, direction: UIPageViewController.NavigationDirection, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        
    }
    
}
