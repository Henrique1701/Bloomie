//
//  TableViewController.swift
//  Bloomy
//
//  Created by Marina Lima on 07/12/20.
//

import UIKit

public class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var soundsSwitch: UISwitch!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let stateSoundsSwitch = UserDefaults.standard.bool(forKey: "stateSoundsSwitch")
        self.soundsSwitch.setOn(stateSoundsSwitch, animated: true)
    }

    @IBAction func touchedSoundsSwitch(_ sender: Any) {
        let stateSoundsSwitch = self.soundsSwitch.isOn
        UserDefaults.standard.set(stateSoundsSwitch, forKey: "stateSoundsSwitch")
        MusicPlayer.shared.changeStatePlayer(state: stateSoundsSwitch)
    }
    
}
