//
//  NodeTableViewCell.swift
//  toy-blocks-client-ios-uikit
//
//  Created by Thiago Galvani on 22/06/22.
//

import UIKit

class NodeTableViewCell: UITableViewCell {

    // MARK: - Identifier
    static let identifier = "CustomTableViewCell"
    
    // MARK: - Views
    private lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = .white
        return mainView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 4
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        return mainStackView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let titleStackView = UIStackView()
        titleStackView.axis = .horizontal
        return titleStackView
    }()
    
    private lazy var onlineStackView: UIStackView = {
        let onlineStackView = UIStackView()
        onlineStackView.axis = .horizontal
        onlineStackView.alignment = .center
        onlineStackView.distribution = .fill
        return onlineStackView
    }()
    
    private lazy var nodesStackView: UIStackView = {
        let nodesStackView = UIStackView()
        nodesStackView.axis = .vertical
        nodesStackView.spacing = 4
        nodesStackView.isHidden = true
        return nodesStackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.lightGray()
        nameLabel.font = UIFont(name: "Roboto-Regular", size: 16)
        nameLabel.font = nameLabel.font.withSize(16)
        return nameLabel
    }()
    
    
    private lazy var urlLabel: UILabel = {
        let urlLabel = UILabel()
        urlLabel.alpha = 0.54
        urlLabel.textColor = UIColor.lightGray()
        urlLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        urlLabel.numberOfLines = 2
        urlLabel.lineBreakMode = .byCharWrapping
        return urlLabel
    }()
    
    private lazy var onlineLabel: UILabel = {
        let onlineLabel = UILabel()
        onlineLabel.textColor = UIColor.lightGray()
        onlineLabel.font = UIFont(name: "Roboto-Medium", size: 10)
        onlineLabel.font = nameLabel.font.withSize(10)
        let onlineParagraphStyle = NSMutableParagraphStyle()
        onlineLabel.attributedText = NSMutableAttributedString(string: "Online", attributes: [NSAttributedString.Key.kern: 1.5, NSAttributedString.Key.paragraphStyle: onlineParagraphStyle])
        return onlineLabel
    }()
    
    private lazy var onlineIndicator: UIView = {
        let onlineIndicator = UIView()
        onlineIndicator.translatesAutoresizingMaskIntoConstraints = false
        onlineIndicator.heightAnchor.constraint(equalToConstant: 8).isActive = true
        onlineIndicator.widthAnchor.constraint(equalToConstant: 8).isActive = true
        onlineIndicator.backgroundColor = UIColor.yellow
        onlineIndicator.layer.cornerRadius = 4
        return onlineIndicator
    }()
    
    private lazy var chevronIconView: UIImageView = {
        let chevronIconView = UIImageView()
        chevronIconView.translatesAutoresizingMaskIntoConstraints = false
        chevronIconView.image = UIImage(systemName: "chevron.down")
        chevronIconView.tintColor = .gray
        chevronIconView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        chevronIconView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return chevronIconView
    }()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setClearBackgroundFromViewAndContentView()
        
        addMainViewToContentView()
        addMainStackViewToMainView()
        addTitleAndOnlineStackViewToMainStackView()
        addURLLabelToMainStackView()
        addNodesStackViewToMainStackView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if nodesStackView.isHidden, selected, nodesStackView.arrangedSubviews.count > 0 {
            nodesStackView.isHidden = false
            chevronIconView.image = UIImage(systemName: "chevron.up")
        } else {
            nodesStackView.isHidden = true
            chevronIconView.image = UIImage(systemName: "chevron.down")
        }
    }
    
    // MARK: - Private Methods
    private func createNodeBlockView(title: String, content: String) -> NodeBlockView {
        let blockView = NodeBlockView()
        blockView.titleLabel.text = title
        blockView.contentLabel.text = content
        return blockView
    }
    
    // MARK: - Public Methods
    public func add(nodeBlocks: [NodeBlock]) {
        nodeBlocks.forEach {
            nodesStackView.addArrangedSubview(createNodeBlockView(title: "\($0.index)", content: $0.content))
        }
    }
    
    public func configure(node: Node) {
        nameLabel.text = node.name
        urlLabel.text = node.url
        
        if node.loading {
            onlineLabel.text = "LOADING"
            onlineIndicator.backgroundColor = UIColor.yellow
        } else {
            onlineLabel.text = node.online ? "ONLINE" : "OFFLINE"
            onlineIndicator.backgroundColor = node.online ? UIColor.green() : UIColor.red()
        }
    }
    
    // MARK: - View Methods
    private func addMainViewToContentView() {
        contentView.addSubview(mainView)
        mainView.applyShadow(cornerRadius: 3)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    private func addMainStackViewToMainView() {
        mainView.addSubview(mainStackView)
        
        let bottomAnchor = mainStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8)
        bottomAnchor.priority = UILayoutPriority(999)
        let trailingAnchor = mainStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8)
        trailingAnchor.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            bottomAnchor,
            trailingAnchor
        ])
    }
    
    private func addTitleAndOnlineStackViewToMainStackView() {
        mainStackView.addArrangedSubview(titleStackView)
        
        titleStackView.addArrangedSubview(nameLabel)
        titleStackView.addArrangedSubview(onlineStackView)
        
        onlineStackView.addArrangedSubview(onlineIndicator)
        onlineStackView.addArrangedSubview(onlineLabel)
        onlineStackView.addArrangedSubview(chevronIconView)
        
        onlineStackView.setCustomSpacing(4, after: onlineIndicator)
        onlineStackView.setCustomSpacing(18, after: onlineLabel)
    }
    
    private func addURLLabelToMainStackView() {
        mainStackView.addArrangedSubview(urlLabel)
    }
    
    private func addNodesStackViewToMainStackView() {
        mainStackView.addArrangedSubview(nodesStackView)
    }
    
    private func setClearBackgroundFromViewAndContentView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
