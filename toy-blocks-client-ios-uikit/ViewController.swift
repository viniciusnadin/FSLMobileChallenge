//
//  ViewController.swift
//  toy-blocks-client-ios-uikit
//
//  Created by Thiago Galvani on 22/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "NodesTableView"
        tableView.register(NodeTableViewCell.self, forCellReuseIdentifier: NodeTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.background()
        return tableView
    }()
    
    private lazy var titleView: TitleView = {
        let titleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    
    private var nodeList = NodeList()
    private var tableModel = [NodeCellController]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTitleViewToMainView()
        addTableViewToMainView()
        fetchNodeList()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.background()
    }
    
    // MARK: - Private Methods
    private func fetchNodeList() {
        let loader = RemoteNodeLoader(client: API(session: URLSession(configuration: .ephemeral)))
        nodeList.fetchStatuses(completionHandler: {
            self.tableModel.append(contentsOf: self.nodeList.nodes.map { NodeCellController(model: $0, loader: loader)})
        })
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> NodeCellController {
        tableModel[indexPath.section]
    }
    
    // MARK: - View Methods
    private func addTitleViewToMainView() {
        view.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func addTableViewToMainView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
}

// MARK: - TableViewDataSource and TableViewDelegate Extension
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath).view(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) {
            tableView.performBatchUpdates(nil)
        }
    }
}
