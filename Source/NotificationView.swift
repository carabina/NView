//
//  NotificationView.swift
//  NView
//
//  Created by Vladislav on 27.06.2018.
//

import Foundation
import UIKit


open class NotificationView:UIToolbar {
    
    
    open static var shared = NotificationView()
    
    //Properties
    /**
     Font for title
     */
    open var titleFont:UIFont = Notification.titleFont {
        didSet {
            titleLabel.font = titleFont
        }
    }
    /**
     Color of title
     */
    open var titleColor:UIColor = UIColor.white {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    /**
     Font for message
     */
    open var subtitleFont:UIFont = Notification.subTitleFont {
        didSet {
            subTitleLabel.font = subtitleFont
        }
    }
    /**
     Color of Message text
     */
    open var subtitleColor:UIColor = UIColor.white {
        didSet {
            subTitleLabel.textColor = subtitleColor
        }
    }
    /**
     Time that show when View will hide
     */
    open var duration:TimeInterval = Notification.duration
    
    
    
    fileprivate var isDragging:Bool = false
    fileprivate var isAnimating:Bool = false
    
    fileprivate var timer:Timer? {
        didSet {
            if oldValue?.isValid == true {
                oldValue?.invalidate()
            }
        }
    }
    
    
    
    //Frames
    
    
    /**
     Size of image
     */
    open var iconSize:CGSize = Notificationlayout.sizeCell {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    fileprivate var imageViewFrame:CGRect {
        return CGRect(x: 15.0, y: 8.0 + Notificationlayout.contentTop, width: iconSize.width, height: iconSize.height)
    }
    
    fileprivate var dragViewFrame:CGRect {
        let width:CGFloat = 40
        return CGRect(x: (Notificationlayout.width - width)/2, y: Notificationlayout.height - 5, width: width, height: Notificationlayout.dragViewHeight)
    }
    
    fileprivate var textPointX:CGFloat {
        return Notificationlayout.imageBorder + self.iconSize.width + Notificationlayout.titleBorder
    }
    
    fileprivate var titlelabelFrame:CGRect {
        let y:CGFloat = 3 + Notificationlayout.contentTop
        if self.imageView.image == nil {
            let x:CGFloat = 5
            return CGRect(x: x, y: y, width: Notificationlayout.width - x, height: Notificationlayout.titleHeight)
        }
        return CGRect(x: textPointX, y: y, width: Notificationlayout.width - textPointX, height: Notificationlayout.titleHeight)
    }
    
    fileprivate var subTitleLabelFrame:CGRect {
        let y:CGFloat = 25.0 + Notificationlayout.contentTop
        if self.imageView.image == nil {
            let x:CGFloat = 5
            return CGRect(x: x, y: y, width: Notificationlayout.width - x, height: Notificationlayout.subTitleHeight)
        }
        return CGRect(x: textPointX, y: y, width: Notificationlayout.width - textPointX, height: Notificationlayout.subTitleHeight)
    }
    
    fileprivate var previusStatusBar:UIStatusBarStyle?
    
    
    
    
    
    
    //Views
    
    fileprivate lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 3
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = titleFont
        label.textColor = titleColor
        label.numberOfLines = 1
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()
    
    fileprivate lazy var subTitleLabel:UILabel = {
        let label = UILabel()
        label.font = subtitleFont
        label.textColor = subtitleColor
        label.textAlignment = .left
        label.numberOfLines = 2
        label.backgroundColor = .clear
        return label
    }()
    
    fileprivate lazy var dragView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = Notificationlayout.dragViewHeight/2
        view.backgroundColor = UIColor(white: 1, alpha: 0.35)
        return view
    }()
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: Notificationlayout.width, height: Notificationlayout.height))
        
        
        startNotificationObservers()
        
        setupUI()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        setupFrames()
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: Notificationlayout.height)
    }
    
    fileprivate func startNotificationObservers() {
        if !UIDevice.current.isGeneratingDeviceOrientationNotifications {
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupUI), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc fileprivate func setupUI() {
        //Bar Style
        self.translatesAutoresizingMaskIntoConstraints = false
        self.barTintColor = nil
        self.isTranslucent = true
        self.barStyle = .black
        //self.tintColor = UIColor(red: 5, green: 31, blue: 75, alpha: 1)
        self.layer.zPosition = CGFloat.greatestFiniteMagnitude - 1
        self.backgroundColor = .clear
        self.isMultipleTouchEnabled = false
        self.isExclusiveTouch = true
        
        
        self.frame = CGRect(x: 0, y: 0, width: Notificationlayout.width, height: Notificationlayout.height)
        self.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleLeftMargin]
        
        // Add subviews
        self.addSubview(self.titleLabel)
        self.addSubview(self.subTitleLabel)
        self.addSubview(self.imageView)
        self.addSubview(self.dragView)
        
        //Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        self.addGestureRecognizer(tap)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        self.addGestureRecognizer(pan)
        
        //SetupFrame
        self.setupFrames()
    }
    
    fileprivate func setupFrames() {
        
        var frame = self.frame
        frame.size.width = Notificationlayout.width
        self.frame = frame
        
        titleLabel.frame = titlelabelFrame
        subTitleLabel.frame = subTitleLabelFrame
        imageView.frame = imageViewFrame
        dragView.frame = dragViewFrame
        
        fixLabelMessageSize()
    }
    
    @objc fileprivate func scheduledDismiss() {
        self.hide(complition: nil)
    }
    
    fileprivate func fixLabelMessageSize() {
        let size = self.subTitleLabel.sizeThatFits(CGSize(width: Notificationlayout.width - self.textPointX, height: CGFloat.greatestFiniteMagnitude))//
        var frame = self.subTitleLabel.frame
        frame.size.height = size.height > Notificationlayout.subTitleHeight ? Notificationlayout.subTitleHeight : size.height
        self.subTitleLabel.frame = frame
    }
    
    @objc fileprivate func didTap(_ gesture:UIGestureRecognizer) {
        isUserInteractionEnabled = false
        self.hide(complition: nil)
    }
    @objc fileprivate func didPan(_ gesture:UIPanGestureRecognizer) {
        switch gesture.state {
        case .ended:
            isDragging = false
            if frame.origin.y < 0 || duration <= 0 {
                self.hide(complition: nil)
            }
            break
        case .began:
            isDragging = true
            break
        case .changed:
            guard let superView = self.superview else { return }
            guard let gestureView = gesture.view else { return }
            
            let translation = gesture.translation(in: superview)
            let newCenter = CGPoint(x: superView.bounds.size.width/2, y: gestureView.center.y + translation.y)
            print(newCenter.y)
            if (newCenter.y >= (-1 * Notificationlayout.height / 2) && newCenter.y <= Notificationlayout.height / 2 ) {
                gestureView.center = newCenter
                gesture.setTranslation(.zero, in: superView)
            }
            
            break
            
        default: break
        }
    }
    
    public func hide( complition: (() -> ())?) {
        guard !isDragging else {
            timer = nil
            return
        }
        
        if self.superview == nil {
            isAnimating = false
            return
        }
        
        if isAnimating {
            return
        }
        
        isAnimating = true
        
        self.timer = nil
        
        UIView.animate(withDuration: Notification.animationDuration, delay: 0, options: .curveEaseOut, animations: {
            var frame = self.frame
            frame.origin.y -= frame.size.height
            self.frame = frame
        }) { _ in
            self.removeFromSuperview()
            UIApplication.shared.delegate?.window??.windowLevel = UIWindowLevelNormal
            
            self.isAnimating = false
            
            complition?()
        }
        
        
    }
    
    public func show(withImage image:UIImage?, title:String?,message:String?, duration:TimeInterval = Notification.duration,size:CGSize = Notificationlayout.sizeCell) {
        guard let window = UIApplication.shared.delegate?.window else { return }
        
        timer = nil
        
        self.imageView.image = image
        self.titleLabel.text = title
        self.subTitleLabel.text = message
        self.iconSize = size
        
        
        var frame = self.frame
        frame.origin.y = -frame.size.height
        self.frame = frame
        
        self.setupFrames()
        
        self.isUserInteractionEnabled = true
        isAnimating = true
        
        //Add to window
        
        if #available(iOS 11, *) {
            if let top = UIApplication.shared.delegate?.window??.safeAreaInsets.top, top > 0 {
                self.previusStatusBar = UIApplication.shared.statusBarStyle
                window?.windowLevel = UIWindowLevelNormal
                window?.rootViewController?.setStatusBarStyle(status: .lightContent)
            }else {
                window?.windowLevel = UIWindowLevelStatusBar
            }
        }
        window?.addSubview(self)
        
        //Show animation
        
        UIView.animate(withDuration: Notification.animationDuration, delay: 0, options: .curveEaseOut, animations: {
            var frame = self.frame
            frame.origin.y += frame.size.height
            self.frame = frame
        }) { _ in
            self.isAnimating = false
        }
        
        //Schedule to hide
        
        if duration > 0 {
            let time = self.duration + Notification.animationDuration
            timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(NotificationView.scheduledDismiss), userInfo: nil, repeats: false)
        }
        
        
    }
    
    
    //helper
    
    public static func hide(complition:(()->())? = nil) {
        self.shared.hide(complition: complition)
    }
    
    public static func show(withImage image:UIImage?,title:String?,message:String?,duration:TimeInterval = Notification.duration,size:CGSize = Notificationlayout.sizeCell) {
        self.shared.show(withImage: image, title: title, message: message, duration: duration, size: size)
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIViewController {
    fileprivate func setStatusBarStyle(status:UIStatusBarStyle) {
        UIApplication.shared.statusBarStyle = status
        setNeedsStatusBarAppearanceUpdate()
    }
}

