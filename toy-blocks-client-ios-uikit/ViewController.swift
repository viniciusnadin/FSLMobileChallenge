//
//  ViewController.swift
//  toy-blocks-client-ios-uikit
//
//  Created by Thiago Galvani on 22/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    internal let tableView: UITableView = {
        let tableView = UITableView()
        tableView.accessibilityIdentifier = "NodesTableView"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(NodeTableViewCell.self, forCellReuseIdentifier: NodeTableViewCell.identifier)
        return tableView
    }()
    
    internal let titleView = TitleView()
    internal var expandedNode = -1
    internal var nodeList = NodeList()
    internal var dataSource: [Node] = []

    override func loadView() {
        super.loadView()
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        
        // TableView General Configurtions
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        // Colors COnfigurations
        view.backgroundColor = UIColor.background()
        tableView.backgroundColor = UIColor.background()
        
        // Frames Configurations
        titleView.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        tableView.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 500)
        
        // Adding Subviews
        view.addSubview(titleView)
        view.addSubview(tableView)
        
        // Getting Node
        nodeList.nodes.forEach { node in
            dataSource.append(node)
        }

        // Getting Nodes Statuses
        nodeList.fetchStatuses(completionHandler: {
            self.tableView.reloadData()
        })
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 12
        }
        
        return indexPath.section == expandedNode
            ? 120
            : 72
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NodeTableViewCell.identifier, for: indexPath) as! NodeTableViewCell
            cell.configure(node: dataSource[indexPath.section] as Node, isExpanded: indexPath.section == expandedNode)
            return cell
        }
        
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.background()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        expandedNode = indexPath.section == expandedNode ? -1 : indexPath.section
        tableView.reloadData()
    }
}

