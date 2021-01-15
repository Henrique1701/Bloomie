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
    // UIView que irá exibir a View do PageViewController
    @IBOutlet weak var contentView: UIView!
    
    // MARK: Variáveis Globais
    // Identificar quais desafios foram aceitos
    var challenges:[Challenge] = []
    
    // Identificar o texto dos desafios aceitos
    var challengeSummaryDataSource:[String] = []
    
    // Imagem dos desafios
    var challengeImageDataSource: [UIImage] = []
    
    // Nome das ilhas
    var islandsNames: [String] = []
    
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.challenges = getAcceptedChallenges()
        self.challengeSummaryDataSource = getChallengeSummary()
        self.challengeImageDataSource = getChallengesIslandName()
        self.islandsNames = getIslandsNames()
        self.configurePageViewController()
        self.setupNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Atualiza o Data Source
        challenges = getAcceptedChallenges()
        challengeSummaryDataSource = getChallengeSummary()
        challengeImageDataSource = getChallengesIslandName()
        self.islandsNames = getIslandsNames()
        // Reseta o delegate do Data Source
        hideContentController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Atualiza o contéudo Page View Controller
        configurePageViewController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Reseta o indice do PageViewController caso esteja na última página
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
        
        // Mudar cor do background
        pageViewController.view.backgroundColor = #colorLiteral(red: 0.9938541055, green: 0.9598969817, blue: 0.9428560138, alpha: 1)
        
        // Adiciona a view do Page View Controller ao contentView (uma UIView que funciona como um container para o Page View Controller neste View Controller)
        contentView.addSubview(pageViewController.view)
        
        // Autolayout
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Dicionário para facilitar na hora que for criar as constraints de AutoLayout
        let views: [String: Any] = ["pageView": pageViewController.view as Any]
        
        // A view do Page View Controller inicia no mesmo ponto que a contentView, que é a view que o contém
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
    
    // Cria uma nova página do PageViewController (que é um View Controller do tipo DesafiosDataViewController em um determinado índice
    func detailViewControllerAt(index: Int) -> DesafiosDataViewController? {
        // Garantir que o Page view controller não ultrapasse o limite de páginas
        if (index >= challengeSummaryDataSource.count || challengeSummaryDataSource.isEmpty) {
            return nil
        }
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String(describing:DesafiosDataViewController.self)) as? DesafiosDataViewController else {
            return nil
        }
        
        // Define os atributos do DesafiosDataViewController
        // O index é o valor passado como parâmetro
        dataViewController.index = index
        dataViewController.summaryText = challengeSummaryDataSource[index]
        dataViewController.cardImage
            = challengeImageDataSource[index]
        dataViewController.islandName = islandsNames[index]
        
        // Verifica se é a última tela
        if index == challengeSummaryDataSource.count-1 {
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
    
    //Retorna o nome das ilhas
    func getIslandsNames() -> [String] {
        var islandsNames: [String] = []
        for challenge in challenges {
            islandsNames.append(challenge.challengeToIsland!.name!)
        }
        return islandsNames
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
