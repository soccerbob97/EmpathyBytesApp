//
//  ARMenu.swift
//  empathyApp
//
//  Created by Harsha Karanth on 10/21/21.
//

import Foundation
import UIKit

class ARMenu : UIViewController{
    
    //UITableViewDelegate, UITableViewDataSource
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self,forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    /** Gets called when the subviews get added to the main view */
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        // bounds of the tableview is bounds of main view
    }
}

extension ARMenu : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    /** Dequeue a cell and return it */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(text: "Custom Cell \(indexPath.row + 1)", imageName: indexPath.row % 2 == 0 ? "ToyAirplane" : "ToyAirplane")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
