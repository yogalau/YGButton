//
//  ViewController.swift
//  YGButton
//
//  Created by yogalau on 11/10/2020.
//  Copyright (c) 2020 yogalau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MAKR: Horizontal Content
    private let horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let horizontalAlignLeft: YGButton = {
        let button = YGButton()
        button.title = "LEFT"
        button.titleColor = .white
        button.titleFont = .boldSystemFont(ofSize: 10)
        button.image = UIImage(named: "icon")
        button.imageSize = .init(width: 12, height: 12)
        button.tintColor = .white
        button.backgroundColor = .black
        button.hightlightColor = UIColor.black.withAlphaComponent(0.8)
        button.cornerRadius = 0
        button.contentInset = .init(top: 8, left: 16, bottom: 8, right: 16)
        button.contentHorizontalAlignment = .left
        return button
    }()
    private let horizontalAlignCenter: YGButton = {
        let button = YGButton()
        button.title = "CENTER"
        button.titleColor = .white
        button.titleFont = .boldSystemFont(ofSize: 10)
        button.image = UIImage(named: "icon")
        button.imageSize = .init(width: 12, height: 12)
        button.tintColor = .white
        button.backgroundColor = .black
        button.hightlightColor = UIColor.black.withAlphaComponent(0.8)
        button.cornerRadius = 4
        button.contentInset = .init(top: 8, left: 16, bottom: 8, right: 16)
        return button
    }()
    private let horizontalAlignRight: YGButton = {
        let button = YGButton()
        button.title = "RIGHT"
        button.titleColor = .white
        button.titleFont = .boldSystemFont(ofSize: 10)
        button.image = UIImage(named: "icon")
        button.imageSize = .init(width: 12, height: 12)
        button.tintColor = .white
        button.backgroundColor = .black
        button.hightlightColor = UIColor.black.withAlphaComponent(0.8)
        button.cornerRadius = 8
        button.contentInset = .init(top: 8, left: 16, bottom: 8, right: 16)
        button.contentHorizontalAlignment = .right
        button.imageHorizontalPosition = .AtTitleRight
        return button
    }()
    
    //MAKR: Vertical Content
    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let verticalAlignLeft: YGButton = {
        let button = YGButton()
        button.title = "LEFT"
        button.titleColor = .white
        button.titleFont = .boldSystemFont(ofSize: 10)
        button.image = UIImage(named: "icon")
        button.imageSize = .init(width: 12, height: 12)
        button.tintColor = .white
        button.backgroundColor = .black
        button.hightlightColor = UIColor.black.withAlphaComponent(0.8)
        button.cornerRadius = 12
        button.contentInset = .init(top: 8, left: 16, bottom: 8, right: 16)
        button.contentHorizontalAlignment = .left
        button.contentAxis = .vertical
        return button
    }()
    private let verticalAlignCenter: YGButton = {
        let button = YGButton()
        button.title = "CENTER"
        button.titleColor = .white
        button.titleFont = .boldSystemFont(ofSize: 10)
        button.image = UIImage(named: "icon")
        button.imageSize = .init(width: 12, height: 12)
        button.tintColor = .white
        button.backgroundColor = .black
        button.hightlightColor = UIColor.black.withAlphaComponent(0.8)
        button.cornerRadius = 16
        button.contentInset = .init(top: 8, left: 16, bottom: 8, right: 16)
        button.contentAxis = .vertical
        return button
    }()
    private let verticalAlignRight: YGButton = {
        let button = YGButton()
        button.title = "RIGHT"
        button.titleColor = .white
        button.titleFont = .boldSystemFont(ofSize: 10)
        button.image = UIImage(named: "icon")
        button.imageSize = .init(width: 12, height: 12)
        button.tintColor = .white
        button.backgroundColor = .black
        button.hightlightColor = UIColor.black.withAlphaComponent(0.8)
        button.cornerRadius = 20
        button.contentInset = .init(top: 8, left: 16, bottom: 8, right: 16)
        button.contentHorizontalAlignment = .right
        button.imageVerticalPosition = .AtTitleBottom
        button.contentAxis = .vertical
        return button
    }()
    
    private let horizontalStack1: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let fillImageTitle: YGButton = {
        let button = YGButton()
        button.title = "FILL"
        button.titleColor = .white
        button.titleFont = .boldSystemFont(ofSize: 10)
        button.image = UIImage(named: "icon")
        button.imageSize = .init(width: 12, height: 12)
        button.tintColor = .white
        button.backgroundColor = .black
        button.hightlightColor = UIColor.black.withAlphaComponent(0.8)
        button.contentInset = .init(top: 8, left: 16, bottom: 8, right: 16)
        button.contentHorizontalAlignment = .fill
        button.cornerRadius = 8
        button.roundingCorners = [.topLeft, .bottomRight]
        return button
    }()
    private let fillTitleImage: YGButton = {
        let button = YGButton()
        button.title = "FILL"
        button.titleColor = .white
        button.titleFont = .boldSystemFont(ofSize: 10)
        button.image = UIImage(named: "icon")
        button.imageSize = .init(width: 12, height: 12)
        button.tintColor = .white
        button.backgroundColor = .black
        button.hightlightColor = UIColor.black.withAlphaComponent(0.8)
        button.contentInset = .init(top: 8, left: 16, bottom: 8, right: 16)
        button.contentHorizontalAlignment = .fill
        button.imageHorizontalPosition = .AtTitleRight
        button.cornerRadius = 8
        button.roundingCorners = [.topRight, .bottomLeft]
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let SCREEN_WIDTH = UIScreen.main.bounds.width
        
        horizontalStack.frame = .init(x: 8, y: 64, width: SCREEN_WIDTH - 16, height: 48)
        horizontalStack.addArrangedSubview(horizontalAlignLeft)
        horizontalStack.addArrangedSubview(horizontalAlignCenter)
        horizontalStack.addArrangedSubview(horizontalAlignRight)
        view.addSubview(horizontalStack)
        
        verticalStack.frame = .init(x: 8, y: 120, width: SCREEN_WIDTH - 16, height: 48)
        verticalStack.addArrangedSubview(verticalAlignLeft)
        verticalStack.addArrangedSubview(verticalAlignCenter)
        verticalStack.addArrangedSubview(verticalAlignRight)
        view.addSubview(verticalStack)
        
        horizontalStack1.frame = .init(x: 8, y: 176, width: SCREEN_WIDTH - 16, height: 48)
        horizontalStack1.addArrangedSubview(fillImageTitle)
        horizontalStack1.addArrangedSubview(fillTitleImage)
        view.addSubview(horizontalStack1)
    }

}

