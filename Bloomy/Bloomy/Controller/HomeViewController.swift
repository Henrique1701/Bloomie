//
//  HomeViewController.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 19/11/20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!
    @IBOutlet weak var fourthStackView: UIStackView!
    @IBOutlet weak var firstLeftButton: UIButton!
    @IBOutlet weak var firstRightButton: UIButton!
    @IBOutlet weak var secondLeftButton: UIButton!
    @IBOutlet weak var secondRightButton: UIButton!
    @IBOutlet weak var thirdLeftButton: UIButton!
    @IBOutlet weak var thirdRightButton: UIButton!
    @IBOutlet weak var fourthLeftButton: UIButton!
    @IBOutlet weak var fourthRightButton: UIButton!
    private let quantityIslands: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Pegar a quantidade de ilhas selecionadas pelo usuário
        setUpIslandsDisplay(quantityIslands: self.quantityIslands)
    }
    override func viewDidAppear(_ animated: Bool) {
        // Esconde a navigation bar de todas as telas
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        // Mostra a navigation bar de todas as telas
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    func setUpIslandsDisplay(quantityIslands: Int) {
        switch quantityIslands {
        case 1:
            self.setUpDisplayOneIsland()
        case 2:
            self.setUpDisplayTwoIsland()
        case 3:
            self.setUpDisplayThreeIsland()
        case 4:
            self.setUpDisplayFourIsland()
        default:
            return
        }
    }
    func setUpDisplayOneIsland() {
        self.fourthStackView.isHidden = true
        self.thirdStackView.isHidden = true
        self.secondStackView.isHidden = true
        self.firstRightButton.isHidden = true
        // TODO: Definir qual a ilha será exibida
    }
    func setUpDisplayTwoIsland() {
        self.fourthStackView.isHidden = true
        self.thirdStackView.isHidden = true
        self.secondRightButton.isHidden = true
        self.firstRightButton.isHidden = true
        // TODO: Definir quais ilhas serão exibidas
    }
    func setUpDisplayThreeIsland() {
        self.fourthStackView.isHidden = true
        self.thirdRightButton.isEnabled = false
        self.thirdRightButton.alpha = 0
        self.secondLeftButton.isEnabled = false
        self.secondLeftButton.alpha = 0
        self.firstRightButton.isEnabled = false
        self.firstRightButton.alpha = 0
        // TODO: Definir quais ilhas serão exibidas
    }
    func setUpDisplayFourIsland() {
        self.fourthRightButton.isEnabled = false
        self.fourthRightButton.alpha = 0
        self.thirdLeftButton.isEnabled = false
        self.thirdLeftButton.alpha = 0
        self.secondRightButton.isEnabled = false
        self.secondRightButton.alpha = 0
        self.firstLeftButton.isEnabled = false
        self.firstLeftButton.alpha = 0
        // TODO: Definir a ordem das ilhas
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
