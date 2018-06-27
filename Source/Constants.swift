//
//  Constants.swift
//  NView
//
//  Created by Vladislav on 27.06.2018.
//

import UIKit

//Protocols
protocol NotificationlayoutProtocol {
    static var height:CGFloat { get }
    static var width:CGFloat { get }
    static var titleHeight:CGFloat  { get }
    static var subTitleHeight:CGFloat { get }
    static var dragViewHeight:CGFloat { get }
    static var contentTop:CGFloat { get }
    static var imageBorder:CGFloat { get }
    static var titleBorder:CGFloat { get }
}


protocol NotificationProtocol {
    static var titleFont:UIFont { get }
    static var subTitleFont:UIFont { get }
    static var animationDuration:TimeInterval { get }
    static var duration:TimeInterval { get }
}




public struct Notification:NotificationProtocol {
    static let titleFont:UIFont = UIFont.boldSystemFont(ofSize: 14)
    static let subTitleFont:UIFont = UIFont.systemFont(ofSize: 13)
    
    static let animationDuration:TimeInterval = 0.3
    public static let duration:TimeInterval = 5.0
    
}


public struct Notificationlayout:NotificationlayoutProtocol {
    static var height: CGFloat {
        let defaultHeight:CGFloat = 64.0
        if #available(iOS 11.0, *) {
            if let top = UIApplication.shared.delegate?.window??.safeAreaInsets.top {
                return top + defaultHeight
            }
        }
        return defaultHeight
    }
    
    static var width:CGFloat {
        return UIScreen.main.bounds.width
    }
    
    
    static let titleHeight:CGFloat = 26
    static let subTitleHeight:CGFloat = 35
    static let dragViewHeight:CGFloat = 3
    
    static var contentTop:CGFloat {
        let defaultTop:CGFloat = 0
        if #available(iOS 11.0, *) {
            if let top = UIApplication.shared.delegate?.window??.safeAreaInsets.top {
                return top + defaultTop
            }
        }
        return defaultTop
    }
    
    public static var sizeCell:CGSize { return CGSize(width: 22, height: 22) }
    
    
    static let imageBorder:CGFloat = 15
    static let titleBorder:CGFloat = 10
}
