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
        var buttonFrame: CGRect = botaoAtencaoPlena.frame;
        if (selectedAtencaoPlena == true) {
            selectedAtencaoPlena = false
            botaoAtencaoPlena.setBackgroundImage(UIImage(named: "botao_atencao_plena"), for: .normal)
            buttonFrame.size = CGSize(width: 150, height: 150);
            botaoAtencaoPlena.frame = buttonFrame
            //botaoAtencaoPlena.imageView?.contentMode = .scaleAspectFit
            print("Atencao Plena Not Selected")
        } else {
            selectedAtencaoPlena = true
            botaoAtencaoPlena.setBackgroundImage(UIImage(named: "botao_on_atencao_plena"), for: .normal)
            buttonFrame.size = CGSize(width: 121, height: 121);
            botaoAtencaoPlena.frame = buttonFrame
            //botaoAtencaoPlena.imageView?.contentMode = .scaleAspectFit
            print("Atencao Selected")
        }
    }
    
    @IBAction func choosePessoasQueridas(_ sender: Any) {
        if (selectedPessoasQueridas == true) {
            selectedPessoasQueridas = false
            botaoPessoasQueridas.setBackgroundImage(UIImage(named: "botao_pessoas_queridas"), for: .normal)
            print("Pessoas Queridas Not Selected")
            
        } else {
            selectedPessoasQueridas = true
            botaoPessoasQueridas.setBackgroundImage(UIImage(named: "botao_on_pessoas_queridas"), for: .normal)
            print("Pessoas Queridas Selected")
        }
    }
    
    @IBAction func chooseLazer(_ sender: Any) {
        if (selectedLazer == true) {
            selectedLazer = false
            botaoLazer.setBackgroundImage(UIImage(named: "botao_lazer"), for: .normal)
            print("Lazer Not Selected")
        } else {
            selectedLazer = true
            botaoLazer.setBackgroundImage(UIImage(named: "botao_on_lazer"), for: .normal)
            print("Lazer Selected")
        }
    }
    
    @IBAction func chooseSaude(_ sender: Any) {
        if (selectedSaude == true) {
            selectedSaude = false
            botaoSaude.setBackgroundImage(UIImage(named: "botao_saude"), for: .normal)
            print("Saude Not Selected")
        } else {
            selectedSaude = true
            botaoSaude.setBackgroundImage(UIImage(named: "botao_on_saude"), for: .normal)
            print("Saude Selected")
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
