//
//  AreasViewController.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 30/11/20.
//

import UIKit
import CoreData

class AreasViewController: UIViewController {
    
    var selectedLazer:Bool = false
    var selectedSaude:Bool = false
    var selectedPessoasQueridas:Bool = false
    var selectedAtencaoPlena:Bool = false
    @IBOutlet weak var botaoAtencaoPlena: UIButton!
    @IBOutlet weak var botaoPessoasQueridas: UIButton!
    @IBOutlet weak var botaoLazer: UIButton!
    @IBOutlet weak var botaoSaude: UIButton!
    @IBOutlet weak var botaoVamosLa: UIButton!
    
    //Gerenciadores das funções CRUD de Ilha e Usuário
    let user = UserManager()
    let island = IslandManager()
    
    @IBAction func chooseAtencaoPlena(_ sender: Any) {
        if (selectedAtencaoPlena == true) {
            selectedAtencaoPlena = false
            botaoAtencaoPlena.setBackgroundImage(UIImage(named: "botao_atencao_plena"), for: .normal)
            //Animação para que o botão volte a ter o tamanho normal
//            UIButton.animate(withDuration: 0.45) { () -> Void in
//                self.botaoAtencaoPlena.transform = CGAffineTransform(scaleX: 1, y: 1)
//            }
            
        } else {
            selectedAtencaoPlena = true
            botaoAtencaoPlena.setBackgroundImage(UIImage(named: "botao_on_atencao_plena"), for: .normal)
            //Animação para diminuir o tamanho do botão
//            UIButton.animate(withDuration: 0.45) { () -> Void in
//                self.botaoAtencaoPlena.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//            }
            
        }
        shouldButtonBeDisabled()
    }
    
    @IBAction func choosePessoasQueridas(_ sender: Any) {
        if (selectedPessoasQueridas == true) {
            selectedPessoasQueridas = false
            botaoPessoasQueridas.setBackgroundImage(UIImage(named: "botao_pessoas_queridas"), for: .normal)
            //Animação para que o botão volte a ter o tamanho normal
//            UIButton.animate(withDuration: 0.45) { () -> Void in
//                self.botaoPessoasQueridas.transform = CGAffineTransform(scaleX: 1, y: 1)
//            }
            
        } else {
            selectedPessoasQueridas = true
            botaoPessoasQueridas.setBackgroundImage(UIImage(named: "botao_on_pessoas_queridas"), for: .normal)
            //Animação para diminuir o tamanho do botão
//            UIButton.animate(withDuration: 0.45) { () -> Void in
//                self.botaoPessoasQueridas.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//            }
        }
        shouldButtonBeDisabled()
    }
    
    @IBAction func chooseLazer(_ sender: Any) {
        if (selectedLazer == true) {
            selectedLazer = false
            botaoLazer.setBackgroundImage(UIImage(named: "botao_lazer"), for: .normal)
            //Animação para que o botão volte a ter o tamanho normal
//            UIButton.animate(withDuration: 0.45) { () -> Void in
//                self.botaoLazer.transform = CGAffineTransform(scaleX: 1, y: 1)
//            }
        } else {
            selectedLazer = true
            botaoLazer.setBackgroundImage(UIImage(named: "botao_on_lazer"), for: .normal)
            //Animação para diminuir o tamanho do botão
//            UIButton.animate(withDuration: 0.45) { () -> Void in
//                self.botaoLazer.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//            }
        }
        shouldButtonBeDisabled()
    }
    
    @IBAction func chooseSaude(_ sender: Any) {
        if (selectedSaude == true) {
            selectedSaude = false
            botaoSaude.setBackgroundImage(UIImage(named: "botao_saude"), for: .normal)
            //Animação para que o botão volte a ter o tamanho normal
//            UIButton.animate(withDuration: 0.45) { () -> Void in
//                self.botaoSaude.transform = CGAffineTransform(scaleX: 1, y: 1)
//            }
        } else {
            selectedSaude = true
            botaoSaude.setBackgroundImage(UIImage(named: "botao_on_saude"), for: .normal)
            //Animação para diminuir o tamanho do botão
//            UIButton.animate(withDuration: 0.45) { () -> Void in
//                self.botaoSaude.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//            }
        }
        shouldButtonBeDisabled()
    }
    
    // MARK: Create Islands on Core Data
    @IBAction func createIslands(_ sender: Any) {
        //Retorna o usuario criado
        let usuario = self.user.getUser()
        //Cria as ilhas que estão selecionadas para o usuario criado
        if(selectedLazer == true) {
            guard let lazerIsland = self.island.newIsland(withName: "Lazer") else { return }
            _ = self.island.setUser(islandName: "Lazer", user: usuario!)
            SeedDataBase.shared.createLeisureChallenges()
            SeedDataBase.shared.createLeisureRewards()
        }
        if(selectedSaude == true) {
            guard let saudeIsland = IslandManager.shared.newIsland(withName: "Saúde") else { return }
            _ = self.island.setUser(islandName: "Saúde", user: usuario!)
            SeedDataBase.shared.createHealthChallenges()
            SeedDataBase.shared.createHealthRewards()
        }
        if(selectedAtencaoPlena == true) {
            guard let atencaoPlenaIsland = IslandManager.shared.newIsland(withName: "Atenção Plena") else { return }
            _ = self.island.setUser(islandName: "Atenção Plena", user: usuario!)
            SeedDataBase.shared.createMindfulnessChallenges()
            SeedDataBase.shared.createMindfulnessRewards()
        }
        if(selectedPessoasQueridas == true) {
            guard let pessoasQueridasIsland = IslandManager.shared.newIsland(withName: "Pessoas Queridas") else { return }
            _ = self.island.setUser(islandName: "Pessoas Queridas", user: usuario!)
            SeedDataBase.shared.createLovedsChallenges()
            SeedDataBase.shared.createLovedsRewards()
        }
    }
    
    //Habilita o botão Vamos lá
    func enableButton() {
        botaoVamosLa.isEnabled = true
        botaoVamosLa.alpha = 1.0
    }
    
    //Desabilita o botão Vamos lá
    func disableButton() {
        botaoVamosLa.isEnabled = false
        botaoVamosLa.alpha = 0.5
    }
    
    //Verifica se o botão Vamos lá deve ser desabilitado
    func shouldButtonBeDisabled() {
        //Caso alguma das áreas esteja selecionada, o botão está habilitado
        if(selectedSaude || selectedLazer || selectedAtencaoPlena || selectedPessoasQueridas) {
            enableButton()
        } else {
            disableButton()
        }
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.layoutIfNeeded()
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18) ?? UIFont()]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableButton()
        setupNavigationController()
        
        // Cria uma variável no user defaults para armazenar o estado SoundsSwitch
        UserDefaults.standard.set(true, forKey: "stateSoundsSwitch")
    }
}
