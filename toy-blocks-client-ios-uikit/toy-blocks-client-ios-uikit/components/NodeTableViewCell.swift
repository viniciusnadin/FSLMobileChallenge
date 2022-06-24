//
//  NodeTableViewCell.swift
//  toy-blocks-client-ios-uikit
//
//  Created by Thiago Galvani on 22/06/22.
//

import UIKit

class NodeTableViewCell: UITableViewCell {

    static let identifier = "CustomTableViewCell"
    
    private var nameLabel = UILabel()
    private var urlLabel = UILabel()
    private var onlineLabel = UILabel()
    private var nodeBlocksLabel = UILabel()
    private var onlineIndicator = UIView()
    private var chevronIconView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.textColor = UIColor.lightGray()
        nameLabel.font = UIFont(name: "Roboto-Regular", size: 16)
        nameLabel.font = nameLabel.font.withSize(16)
        
        urlLabel.alpha = 0.54
        urlLabel.textColor = UIColor.lightGray()
        urlLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        urlLabel.font = nameLabel.font.withSize(14)
        
        onlineLabel.textColor = UIColor.lightGray()
        onlineLabel.font = UIFont(name: "Roboto-Medium", size: 10)
        onlineLabel.font = nameLabel.font.withSize(10)
        
        let onlineParagraphStyle = NSMutableParagraphStyle()
        onlineParagraphStyle.lineHeightMultiple = 1.37
        onlineLabel.attributedText = NSMutableAttributedString(string: "Online", attributes: [NSAttributedString.Key.kern: 1.5, NSAttributedString.Key.paragraphStyle: onlineParagraphStyle])
        
        nodeBlocksLabel.textColor = UIColor.lightGray()
        nodeBlocksLabel.font = UIFont(name: "Roboto-Medium", size: 14)
        nodeBlocksLabel.font = nameLabel.font.withSize(14)
        nodeBlocksLabel.text = "Blocks go Here"
        
        chevronIconView = UIImageView(frame: CGRect(x: self.bounds.width - 65, y: 20, width: 15, height: 8))
        chevronIconView.image = UIImage(systemName: "chevron.down")
        chevronIconView.tintColor = .gray
        
        onlineIndicator.backgroundColor = UIColor.yellow
        onlineIndicator.layer.cornerRadius = 4
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 3
        self.layer.shadowOpacity = 0.23
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: -2, height: 3)
        self.layer.shadowColor = UIColor.black.cgColor
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(urlLabel)
        contentView.addSubview(onlineLabel)
        contentView.addSubview(onlineIndicator)
        contentView.addSubview(nodeBlocksLabel)
        contentView.addSubview(chevronIconView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(node: Node, isExpanded: Bool) {
        nameLabel.text = node.name
        urlLabel.text = node.url
        
        if isExpanded {
            self.addSubview(nodeBlocksLabel)
            nodeBlocksLabel.frame = CGRect(x: 20, y: 80, width: self.bounds.width - 40, height: 15)
            chevronIconView.image = UIImage(systemName: "chevron.down")
        } else {
            nodeBlocksLabel.removeFromSuperview()
            chevronIconView.image = UIImage(systemName: "chevron.up")
        }
        
        if node.loading {
            onlineLabel.text = "LOADING"
            onlineIndicator.backgroundColor = UIColor.yellow
        } else {
            onlineLabel.text = node.online ? "ONLINE" : "OFFLINE"
            onlineIndicator.backgroundColor = node.online ? UIColor.green() : UIColor.red()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.frame = CGRect(x: 20, y: 14, width: 200, height: 20)
        urlLabel.frame = CGRect(x: 20, y: 38, width: 250, height: 15)
        onlineLabel.frame = CGRect(x: self.bounds.width - 80, y: 13, width: 50, height: 20)
        onlineIndicator.frame = CGRect(x: self.bounds.width - 93, y: 20, width: 8, height: 8)
    }
    
}
