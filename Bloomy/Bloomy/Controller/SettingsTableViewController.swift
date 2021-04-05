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
        
        // Altera o estado do switch
        let stateSoundsSwitch = userDefaults.bool(forKey: UserDefaultsKeys.stateSoundsSwitch)
        self.soundsSwitch.setOn(stateSoundsSwitch, animated: true)
    }

    @IBAction func touchedSoundsSwitch(_ sender: Any) {
        let stateSoundsSwitch = self.soundsSwitch.isOn
        userDefaults.set(stateSoundsSwitch, forKey: UserDefaultsKeys.stateSoundsSwitch)
        MusicPlayer.shared.changeStatePlayer(state: stateSoundsSwitch)
    }
    
}
