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
    internal var tableModel = [NodeCellController]() {
        didSet { tableView.reloadData() }
    }
    
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
        
        let loader = RemoteNodeLoader(client: API(session: URLSession(configuration: .ephemeral)))
        // Getting Node

        // Getting Nodes Statuses
        nodeList.fetchStatuses(completionHandler: {
            self.tableModel.append(contentsOf: self.nodeList.nodes.map { NodeCellController(model: $0, loader: loader)})
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
        return tableModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return cellController(forRowAt: indexPath).view(tableView: tableView, indexPath: indexPath, expandedNode: expandedNode)
        }
        
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.background()
        return cell
        
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> NodeCellController {
        tableModel[indexPath.section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        expandedNode = indexPath.section == expandedNode ? -1 : indexPath.section
        tableView.reloadData()
    }
}

final class NodeCellController {
    private let model: Node
    private let loader: RemoteNodeLoader
    
    init(model: Node, loader: RemoteNodeLoader) {
        self.model = model
        self.loader = loader
        loadBlocks()
    }
    
    func view(tableView: UITableView, indexPath: IndexPath, expandedNode: Int) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NodeTableViewCell.identifier,
            for: indexPath) as? NodeTableViewCell
        else {
            fatalError("Error fetching dequeued reusable cell!")
        }
        
        cell.configure(node: model, isExpanded: indexPath.section == expandedNode)
        return cell
    }
    
    func loadBlocks() {
        guard let url = URL(string: model.url), model.online else {
            return
        }
        
        loader.loadNodeBlock(from: url) { result in
            switch result {
            case let .success(blocks):
                self.model.blocks = blocks
            case .failure:
                return
            }
        }
    }
}

class API: HTTPClient {
    
    private let session: URLSession
    private struct UnexpectedValuesRepresentation: Error {}
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        let task = session.dataTask(with: url) { data, _ , error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data {
                    return data
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }
        task.resume()
    }
}
