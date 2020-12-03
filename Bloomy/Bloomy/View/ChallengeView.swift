//
//  ChallengeView.swift
//  Bloomy
//
//  Created by Wilton Ramos on 02/12/20.
//

import UIKit

class ChallengeView: UIView {
    
    let summaryLabel: UILabel = UILabel()
    let closeButton: UIButton = UIButton()
    let acceptButton: UIButton = UIButton()
    let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        self.backgroundColor = .white
    }
    
    func setupView() {
        setupStackView()
        self.layer.cornerRadius = 35
        
        self.summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.summaryLabel.text = "Olhe para a janela e tente não se jogar! \n \n \n \n jsdisajasidjasidjiasjdiasjdiasjdiasjdaisjdasijdasidjaisjdiasjdiasjdiasjdiasjdiajsdijasidjasidjaisjdiasjdiasjdiadjasijdiasjdiasjdiasjdijasdijasidjasidjiasjdiasjdiasjdlkasjdlasijdalisjdlaskjdalsijdlaisj"
        self.summaryLabel.adjustsFontSizeToFitWidth = true
        self.summaryLabel.minimumScaleFactor = 0.5
        self.summaryLabel.font = UIFont(name: "Poppins-SemiBold", size: 24)
        self.summaryLabel.numberOfLines = 0
        
        self.acceptButton.setTitle("Botão", for: .normal)
        self.acceptButton.backgroundColor = .red
    }
    
    func setupStackView() {
        self.addSubview(stackView)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.distribution = .fillProportionally
        self.stackView.alignment = .center
        self.stackView.spacing = 20
        
        self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        self.stackView.addArrangedSubview(summaryLabel)
        self.stackView.addArrangedSubview(acceptButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("initir(coder:) has not been implemeted")
    }
    
}
