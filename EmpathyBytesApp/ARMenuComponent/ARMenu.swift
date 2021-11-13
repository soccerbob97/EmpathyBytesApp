//
//  ARMenu.swift
//  empathyApp
//
//  Created by Harsha Karanth on 10/21/21.
//

import Foundation
import UIKit
import SwiftUI

class ARMenu : UIViewController{
    
    //UITableViewDelegate, UITableViewDataSource
    
    var models : [ModelEntity] = []

    private let tableView : UITableView = {
        let tableView = UITableView()
        //each cell must be a CustomTableViewCell
        tableView.register(CustomTableViewCell.self,forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()
    
    private let titleLabel : UILabel = {
        let width = UIScreen.main.bounds.width
        let label = UILabel(frame:CGRect(x: 0, y: 0, width: width, height:40 ))
        label.textColor = .black
        label.font = .systemFont(ofSize: 25,weight: .bold)
        //Border is for debugging purposes
        //label.layer.borderColor = UIColor.darkGray.cgColor
        //label.layer.borderWidth = 3.0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        models = fetchData()
        configureARMenuTitle()
        configureTableView()
    }
    
    func configureARMenuTitle() {
        print("label add")
        titleLabel.text = "AR Makerspace Gallery"
        self.view.addSubview(titleLabel)
        //configureTitleConstrains()
    }
    func configureTableView() {
        // next two commands declare that ArMenu will implement the Data Source and Delegate classes
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        self.view.addSubview(tableView)
        constrainTableView()
    }
    
    func constrainTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 25).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension ARMenu : UITableViewDataSource, UITableViewDelegate {
    /** returns number of rows in tableview */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    /** Dequeue a cell and return it */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row % models.count]
        //Currently there is only two models avaiable so we are modding by models.count to fill the whole tableview
        cell.configure(text: model.title, imageName: model.imageName)
        return cell
    }
    /** Returns height for each row */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row % 2 == 0 ? 100 : 150
    }
    
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("in did select")
        let model = models[indexPath.row % models.count]
        let host = UIHostingController(rootView: ModelDescriptionView(modelEntity: model))
        navigationController?.pushViewController(host, animated: true)
        
    }
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row % models.count]
        let host = UIHostingController(rootView: ModelDescriptionView(modelEntity: model))
        navigationController?.pushViewController(host, animated: true)
    }
}

extension ARMenu {
    /** Creates models objects with name and image */
    func fetchData() -> [ModelEntity] {
        let model1 = ModelEntity(imageName: ImageConstants.toyAirplane , title: ImageConstants.toyAirplaneTitle, description: ImageConstants.toyAirplaneDescription)
        let model2 = ModelEntity(imageName: ImageConstants.guitar, title: ImageConstants.guitarTitle, description: ImageConstants.guitarAirplaneDescription)
        return [model1,model2]
    }
    
}

/*
func configureTitleConstrains() {
    titleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
}
 */
