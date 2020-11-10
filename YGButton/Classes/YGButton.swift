//
//  YGButton.swift
//  YGButton
//
//  Created by yogalau on 2020/11/5.
//  Copyright (c) 2020 yogalau. All rights reserved.
//

import UIKit

class YGButton: UIControl {
    
    //MARK: - Button Properties
    private var normalColor: UIColor?
    /// Button hightlightColor
    var hightlightColor: UIColor?
    
    /// Button cornerRadius, default is 0. It will default set the cornerCurve property is continuous when system version greater than iOS 13.
    var cornerRadius: CGFloat = 0 {
        didSet {
            if roundingCorners == .allCorners {
                layer.cornerRadius = cornerRadius
                if #available(iOS 13, *) {
                    layer.cornerCurve = .continuous
                }
            }
            else {
                layer.cornerRadius = 0
            }
        }
    }
    
    /// Button rounded corners, default is allCorners. You can custom the rounding corners by this property. if the button set this property it will Off-Screen Render.
    var roundingCorners: UIRectCorner = .allCorners {
        didSet {
            let current = cornerRadius
            cornerRadius = current
        }
    }
    
    //MARK: - Content View Properties
    private let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = false
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    /// Button content spacing, default is 8
    var contentSpacing: CGFloat = 8 {
        didSet {
            contentView.spacing = contentSpacing
        }
    }
    
    /// Button content inset, default is zero.
    var contentInset: UIEdgeInsets = .zero {
        didSet {
            contentTopInset.constant = contentInset.top
            contentBottomInset.constant = contentInset.bottom * -1
            contentLeftInset.constant = contentInset.left
            contentRightInset.constant = contentInset.right * -1
        }
    }
    
    private var contentCenterY: NSLayoutConstraint!
    private var contentCenterX: NSLayoutConstraint!
    private var contentTopInset: NSLayoutConstraint!
    private var contentBottomInset: NSLayoutConstraint!
    private var contentLeftInset: NSLayoutConstraint!
    private var contentRightInset: NSLayoutConstraint!
    
    /**
     Button content axis, default is horizontal. Button must with image content. E.g if you set the image for button so image and title contents align with horizontal. if the property set vertical, image and title contents align with vertical.
     */
    var contentAxis = NSLayoutConstraint.Axis.horizontal {
        didSet {
            contentView.axis = contentAxis
            
            guard let imageView = imageView else { return }
            switch contentAxis {
            case .horizontal:
                let current = imageHorizontalPosition
                imageHorizontalPosition = current
                break
            case .vertical:
                let current = imageVerticalPosition
                imageVerticalPosition = current
                break
            @unknown default:
                break
            }
            
            if contentAxis == .horizontal {
                if let imageCenterX = imageCenterX, let imageTopInset = imageTopInset, let imageBottomInset = imageBottomInset {
                    imageContentView.removeConstraints([
                        imageCenterX,
                        imageTopInset,
                        imageBottomInset
                    ])
                }

                imageCenterY = .init(item: imageContentView, attribute: .centerY, relatedBy: .equal, toItem: imageView, attribute: .centerY, multiplier: 1, constant: 0)
                imageContentView.addConstraint(imageCenterY)

                imageLeftInset = .init(item: imageContentView, attribute: .left, relatedBy: .equal, toItem: imageView, attribute: .left, multiplier: 1, constant: 0)
                imageContentView.addConstraint(imageLeftInset)
                imageRightInset = .init(item: imageContentView, attribute: .right, relatedBy: .equal, toItem: imageView, attribute: .right, multiplier: 1, constant: 0)
                imageContentView.addConstraint(imageRightInset)
            }
            else {
                if let imageCenterY = imageCenterY, let imageLeftInset = imageLeftInset, let imageRightInset = imageRightInset {
                    imageContentView.removeConstraints([
                        imageCenterY,
                        imageLeftInset,
                        imageRightInset
                    ])
                }

                imageCenterX = .init(item: imageContentView, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerX, multiplier: 1, constant: 0)
                imageContentView.addConstraint(imageCenterX)

                imageTopInset = .init(item: imageContentView, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .top, multiplier: 1, constant: 0)
                imageContentView.addConstraint(imageTopInset)
                imageBottomInset = .init(item: imageContentView, attribute: .bottom, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 0)
                imageContentView.addConstraint(imageBottomInset)
            }
        }
    }
    
    //MARK: - Title Label Properties
    private var titleLabel: UILabel?
    
    /// Button's title label content.
    var title: String? {
        get { return titleLabel?.text }
        set {
            guard let newValue = newValue else { return }
            titleLabel = UILabel()
            titleLabel?.translatesAutoresizingMaskIntoConstraints = false
            titleLabel?.text = newValue
            contentView.addArrangedSubview(titleLabel!)
        }
    }
    
    /// Button's title label text color. default is BLACK.
    var titleColor: UIColor? {
        get { return titleLabel?.textColor }
        set {
            titleLabel?.textColor = newValue ?? .black
        }
    }
    
    /// Button's title label text font. default of size is 14.
    var titleFont: UIFont? {
        get { return titleLabel?.font }
        set {
            titleLabel?.font = newValue ?? .systemFont(ofSize: 14)
        }
    }
    
    //MARK: - Image Properties
    private let imageContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var imageView: ImageView? {
        didSet {
            guard let imageView = imageView else { return }
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageContentView.addSubview(imageView)
            let current = contentAxis
            contentAxis = current
        }
    }
    
    private var imageCenterX: NSLayoutConstraint!
    private var imageCenterY: NSLayoutConstraint!
    private var imageTopInset: NSLayoutConstraint!
    private var imageBottomInset: NSLayoutConstraint!
    private var imageLeftInset: NSLayoutConstraint!
    private var imageRightInset: NSLayoutConstraint!
    private var imageWidth: NSLayoutConstraint!
    private var imageHeight: NSLayoutConstraint!
    
    /// Button's image content.
    var image: UIImage? {
        get { return imageView?.image }
        set {
            guard let newValue = newValue else { return }
            if let imageView = imageView {
                imageView.image = newValue
            }
            else {
                imageView = ImageView(image: newValue)
            }
            contentView.insertArrangedSubview(imageContentView, at: 0) // Default is the first subview
        }
    }
    
    /// Button's image content size.
    var imageSize: CGSize = .zero {
        didSet {
            guard let imageView = imageView else { return }
            imageView.contentSize = imageSize
        }
    }
    
    /**
     Button's image horizontal position.
     
     AtTitleRight: The image is to the right of the title.
     ***
     AtTitleLeft: The image is to the left of the title.
     */
    enum ImageHorizontalPosition: Int {
        case AtTitleLeft = 0
        case AtTitleRight = 1
    }
    /**
     Button's image vertical position
     
     AtTitleTop: The image is to the top of the title.
     ***
     AtTitleBottom: The image is to bottom left of the title.
     */
    enum ImageVerticalPosition: Int {
        case AtTitleTop = 0
        case AtTitleBottom = 1
    }
    
    /// Button's image horizontal position, default is AtTitleLeft. E.g The image is to the top of the title.
    var imageHorizontalPosition: ImageHorizontalPosition = .AtTitleLeft {
        didSet {
            guard let _ = titleLabel, contentAxis == .horizontal else { return }
            imageContentView.removeFromSuperview()
            switch imageHorizontalPosition {
            case .AtTitleLeft:
                contentView.insertArrangedSubview(imageContentView, at: ImageHorizontalPosition.AtTitleLeft.rawValue)
                break
            case .AtTitleRight:
                contentView.insertArrangedSubview(imageContentView, at: ImageHorizontalPosition.AtTitleRight.rawValue)
                break
            }
        }
    }
    /// Button's image vertical position, default is AtTitleTop. E.g The image is to the bottom of the title.
    var imageVerticalPosition: ImageVerticalPosition = .AtTitleTop {
        didSet {
            guard let _ = titleLabel, contentAxis == .vertical else { return }
            imageContentView.removeFromSuperview()
            switch imageVerticalPosition {
            case .AtTitleTop:
                contentView.insertArrangedSubview(imageContentView, at: ImageVerticalPosition.AtTitleTop.rawValue)
                break
            case .AtTitleBottom:
                contentView.insertArrangedSubview(imageContentView, at: ImageVerticalPosition.AtTitleBottom.rawValue)
                break
            }
        }
    }
    
    //MARK: Override Super Property
    override var frame: CGRect {
        didSet {
            translatesAutoresizingMaskIntoConstraints = true
        }
    }
    
    override var backgroundColor: UIColor? {
        get { return super.backgroundColor }
        set {
            guard let newValue = newValue else { return }
            super.backgroundColor = newValue
            if !newValue.isEqual(hightlightColor) {
                normalColor = newValue
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            guard let hightlightColor = hightlightColor, let normalColor = normalColor else { return }
            UIView.transition(with: self, duration: 0.1, options: .curveLinear, animations: { [unowned self] in
                backgroundColor = isHighlighted ? hightlightColor : normalColor
            }, completion: nil)
        }
    }
    
    /// A color used to tint template images in the view hierarchy.
    override var tintColor: UIColor! {
        didSet {
            imageView?.tintColor = tintColor
        }
    }
    
    /// The horizontal alignment of content (text and images) within a control.
    override var contentHorizontalAlignment: UIControl.ContentHorizontalAlignment {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// Constants for specifying the vertical alignment of content (text and images) in a control.
    override var contentVerticalAlignment: UIControl.ContentVerticalAlignment {
        didSet {
            setNeedsLayout()
        }
    }
    
    //MARK: Override Super Function
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        
        // Init content constraints variables
        contentCenterX = .init(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        contentCenterY = .init(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        contentTopInset = .init(item: contentView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: contentInset.top)
        addConstraint(contentTopInset)
        contentBottomInset = .init(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: contentInset.bottom * -1)
        addConstraint(contentBottomInset)
        contentLeftInset = .init(item: contentView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: contentInset.left)
        addConstraint(contentLeftInset)
        contentRightInset = .init(item: contentView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: contentInset.right * -1)
        addConstraint(contentRightInset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
        layoutIfNeeded()
        
        //MARK: - Corners
        if roundingCorners != .allCorners {
            drawRoundingCorners()
        }
        
        guard let titleLabel = titleLabel, let imageView = imageView, let image = imageView.image else { return }
        
        var contentWidth: CGFloat = 0
        var contentHeight: CGFloat = 0
        switch contentAxis {
        case .horizontal:
            contentWidth = image.size.width + contentSpacing + titleLabel.frame.width + contentInset.left + contentInset.right
            
            if image.size.height > titleLabel.frame.height {
                contentHeight = image.size.height
            }
            else {
                contentHeight = titleLabel.frame.height
            }
            break
        case .vertical:
            if image.size.width > titleLabel.frame.width {
                contentWidth = image.size.width
            }
            else {
                contentWidth = titleLabel.frame.width
            }
            
            contentHeight = image.size.height + contentSpacing + titleLabel.frame.height + contentInset.top + contentInset.bottom
            break
        @unknown default:
            break
        }

        // If the button actually width greater than content width then align the content view according to contentHorizontal.
        if frame.width > contentWidth {
            switch contentHorizontalAlignment {
            case .center:
                if !contentCenterX.isActive {
                    addConstraint(contentCenterX)
                }
                removeConstraint(contentLeftInset)
                removeConstraint(contentRightInset)
                break
            case .left:
                removeConstraint(contentCenterX)
                if !contentLeftInset.isActive {
                    addConstraint(contentLeftInset)
                }
                removeConstraint(contentRightInset)
                break
            case .right:
                removeConstraint(contentCenterX)
                removeConstraint(contentLeftInset)
                if !contentRightInset.isActive {
                    addConstraint(contentRightInset)
                }
                break
            case .fill:
                removeConstraint(contentCenterX)
                if !contentLeftInset.isActive {
                    addConstraint(contentLeftInset)
                }
                if !contentRightInset.isActive {
                    addConstraint(contentRightInset)
                }
            default:
                if !contentCenterX.isActive {
                    addConstraint(contentCenterX)
                }
                removeConstraint(contentLeftInset)
                removeConstraint(contentRightInset)
                break
            }
        }
        
        // If the button actually width greater than content width then align the content view according to contentHorizontal
        if frame.height > contentHeight {
            switch contentVerticalAlignment {
            case .center:
                if !contentCenterY.isActive {
                    addConstraint(contentCenterY)
                }
                removeConstraint(contentTopInset)
                removeConstraint(contentBottomInset)
                break
            case .top:
                removeConstraint(contentCenterY)
                if !contentTopInset.isActive {
                    addConstraint(contentTopInset)
                }
                removeConstraint(contentBottomInset)
                break
            case .bottom:
                removeConstraint(contentCenterY)
                removeConstraint(contentTopInset)
                if !contentBottomInset.isActive {
                    addConstraint(contentBottomInset)
                }
                break
            case .fill:
                removeConstraint(contentCenterY)
                if !contentTopInset.isActive {
                    addConstraint(contentTopInset)
                }
                if !contentBottomInset.isActive {
                    addConstraint(contentBottomInset)
                }
            default:
                if !contentCenterY.isActive {
                    addConstraint(contentCenterY)
                }
                removeConstraint(contentTopInset)
                removeConstraint(contentBottomInset)
                break
            }
        }
        
        // If height of image greater than button so make them equal
        if image.size.height > frame.height {
            imageTopInset = .init(item: imageContentView, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .top, multiplier: 1, constant: 0)
            imageContentView.addConstraint(imageTopInset)
            imageBottomInset = .init(item: imageContentView, attribute: .bottom, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 0)
            imageContentView.addConstraint(imageBottomInset)
        }
        // If width of image greater than button so make them equal
        else if image.size.width > frame.width {
            imageLeftInset = .init(item: imageContentView, attribute: .left, relatedBy: .equal, toItem: imageView, attribute: .left, multiplier: 1, constant: 0)
            imageContentView.addConstraint(imageLeftInset)
            imageRightInset = .init(item: imageContentView, attribute: .right, relatedBy: .equal, toItem: imageView, attribute: .right, multiplier: 1, constant: 0)
            imageContentView.addConstraint(imageRightInset)
        }
    }
    
    private func drawRoundingCorners() {
        guard cornerRadius > 0 else { return }
        
        let rect = bounds
        
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: roundingCorners, cornerRadii: size)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        
        layer.shouldRasterize = true
    }
    
}


//MARK: - Override UIImageView's property of intrinsicContentSize, it make the image size can modify
fileprivate class ImageView: UIImageView {
    
    /// Button image size
    var contentSize: CGSize?
    
    override var intrinsicContentSize: CGSize {
        return contentSize ?? super.intrinsicContentSize
    }
    
}
