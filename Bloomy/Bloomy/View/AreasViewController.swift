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
    
    @IBAction func chooseAtencaoPlena(_ sender: Any) {
        if (selectedAtencaoPlena == true) {
            selectedAtencaoPlena = false
            botaoAtencaoPlena.setBackgroundImage(UIImage(named: "botao_atencao_plena"), for: .normal)
            print("Atencao Plena Not Selected")
            //Animação para que o botão volte a ter o tamanho normal
            UIButton.animate(withDuration: 0.45) { () -> Void in
                self.botaoAtencaoPlena.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
            
        } else {
            selectedAtencaoPlena = true
            botaoAtencaoPlena.setBackgroundImage(UIImage(named: "botao_on_atencao_plena"), for: .normal)
            print("Atencao Selected")
            //Animação para diminuir o tamanho do botão
            UIButton.animate(withDuration: 0.45) { () -> Void in
                self.botaoAtencaoPlena.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }

        }
    }
    
    @IBAction func choosePessoasQueridas(_ sender: Any) {
        if (selectedPessoasQueridas == true) {
            selectedPessoasQueridas = false
            botaoPessoasQueridas.setBackgroundImage(UIImage(named: "botao_pessoas_queridas"), for: .normal)
            print("Pessoas Queridas Not Selected")
            //Animação para que o botão volte a ter o tamanho normal
            UIButton.animate(withDuration: 0.45) { () -> Void in
                self.botaoPessoasQueridas.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
            
        } else {
            selectedPessoasQueridas = true
            botaoPessoasQueridas.setBackgroundImage(UIImage(named: "botao_on_pessoas_queridas"), for: .normal)
            print("Pessoas Queridas Selected")
            //Animação para diminuir o tamanho do botão
            UIButton.animate(withDuration: 0.45) { () -> Void in
                self.botaoPessoasQueridas.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
    }
    
    @IBAction func chooseLazer(_ sender: Any) {
        if (selectedLazer == true) {
            selectedLazer = false
            botaoLazer.setBackgroundImage(UIImage(named: "botao_lazer"), for: .normal)
            print("Lazer Not Selected")
            //Animação para que o botão volte a ter o tamanho normal
            UIButton.animate(withDuration: 0.45) { () -> Void in
                self.botaoLazer.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        } else {
            selectedLazer = true
            botaoLazer.setBackgroundImage(UIImage(named: "botao_on_lazer"), for: .normal)
            print("Lazer Selected")
            //Animação para diminuir o tamanho do botão
            UIButton.animate(withDuration: 0.45) { () -> Void in
                self.botaoLazer.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
    }
    
    @IBAction func chooseSaude(_ sender: Any) {
        if (selectedSaude == true) {
            selectedSaude = false
            botaoSaude.setBackgroundImage(UIImage(named: "botao_saude"), for: .normal)
            print("Saude Not Selected")
            //Animação para que o botão volte a ter o tamanho normal
            UIButton.animate(withDuration: 0.45) { () -> Void in
                self.botaoSaude.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        } else {
            selectedSaude = true
            botaoSaude.setBackgroundImage(UIImage(named: "botao_on_saude"), for: .normal)
            print("Saude Selected")
            //Animação para diminuir o tamanho do botão
            UIButton.animate(withDuration: 0.45) { () -> Void in
                self.botaoSaude.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("oi")
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
