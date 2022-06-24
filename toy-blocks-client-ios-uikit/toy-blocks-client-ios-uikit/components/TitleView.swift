//
//  Title.swift
//  toy-blocks-client-ios-uikit
//
//  Created by Thiago Galvani on 23/06/22.
//

import UIKit

class TitleView: UIView {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Nodes"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "Roboto-Bold", size: 34)
        titleLabel.font = titleLabel.font.withSize(34)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        self.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
