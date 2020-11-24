//
//  IslandsViewController.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 23/11/20.
//

import UIKit
import CoreData

class IslandsViewController: UIViewController {
    
    var selectedLazer:Bool = false
    var selectedSaude:Bool = false
    var selectedPessoasQueridas:Bool = false
    var selectedAtencaoPlena:Bool = false
    
    let user = UserManager()
    let island = IslandManager()
    
    @IBOutlet weak var userTextField: UITextField!
    @IBAction func saveUserButton(_ sender: Any) {
         user.newUser(withName: userTextField.text!)
    }
    
    
    
    @IBAction func chooseLazer(_ sender: Any) {
        if (selectedLazer == true) {
            selectedLazer = false
            print("Lazer Not Selected")
        } else {
            selectedLazer = true
            print("Lazer Selected")
        }
    }
    
    @IBAction func chooseSaude(_ sender: Any) {
        if (selectedSaude == true) {
            selectedSaude = false
            print("Saude Not Selected")
        } else {
            selectedSaude = true
            print("Saude Selected")
        }
    }
    
    @IBAction func choosePessoasQueridas(_ sender: Any) {
        if (selectedPessoasQueridas == true) {
            selectedPessoasQueridas = false
            print("Pessoas Queridas Not Selected")
        } else {
            selectedPessoasQueridas = true
            print("Pessoas Queridas Selected")
        }
    }
    
    @IBAction func chooseAtencaoPlena(_ sender: Any) {
        if (selectedAtencaoPlena == true) {
            selectedAtencaoPlena = false
            print("Atencao Plena Not Selected")
        } else {
            selectedAtencaoPlena = true
            print("Atencao Selected")
        }
    }
    
    @IBAction func selectedIslandsButton(_ sender: Any) {
        let usuario = self.user.getUser()
        
        
        if(selectedLazer == true){
            guard let lazerIsland = self.island.newIsland(withName: "Lazer") else { return }
            self.island.setUser (islandName: "Lazer", user: usuario!)
                print("Created \(lazerIsland)")
        }
        if(selectedSaude == true){
            guard let saudeIsland = IslandManager.shared.newIsland(withName: "Saúde") else { return }
            self.island.setUser(islandName: "Saúde", user: usuario!)
                print("Created \(saudeIsland)")
        }
        if(selectedAtencaoPlena == true){
            guard let atencaoPlenaIsland = IslandManager.shared.newIsland(withName: "Atenção Plena") else { return }
            self.island.setUser(islandName: "Atenção Plena", user: usuario!)
                print("Created \(atencaoPlenaIsland)")
        }
        if(selectedPessoasQueridas == true){
            guard let pessoasQueridasIsland = IslandManager.shared.newIsland(withName: "Pessoas Queridas") else { return }
            self.island.setUser(islandName: "Pessoas Queridas", user: usuario!)
                print("Created \(pessoasQueridasIsland)")
        }
        
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user.getIslands())
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
