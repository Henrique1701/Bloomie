//
//  TableViewController.swift
//  Bloomy
//
//  Created by Marina Lima on 23/11/20.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var configuracoesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

   override func numberOfSections(in tableView: UITableView) -> Int {
       return 0
    }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}
