//
//  Extensions.swift
//  Movierese
//
//  Created by mohamedSliem on 7/7/22.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController {
    func showAlertWithOk(alertTitle: String,message: String,actionTitle: String){
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    static var activityIndactorView: UIView!
    static var activityIndactor: NVActivityIndicatorView!
    
    func showLoader(frame: CGRect? = nil) {
        
        UIViewController.activityIndactorView = UIView(frame: frame ?? view.frame)
        UIViewController.activityIndactorView.backgroundColor = .black
        
        let loaderFrame = CGRect(
            x: UIViewController.activityIndactorView.frame.width / 2 - 50,
            y: UIViewController.activityIndactorView.frame.height / 2 - 100,
            width: 100, height: 100
        )
        
        let color =  UIColor(displayP3Red: 0.62, green: 0.61, blue: 0.82, alpha: 1.0)
        UIViewController.activityIndactor = NVActivityIndicatorView(
            frame: loaderFrame,
            type: .ballZigZagDeflect,
            color: color, padding: 25
        )
        
        DispatchQueue.main.async {
            
            self.view.addSubview(UIViewController.activityIndactorView)
            UIViewController.activityIndactorView.addSubview(UIViewController.activityIndactor)
            UIViewController.activityIndactor.startAnimating()
            
        }
        
        
    }
    
    func removeLoader(){
        DispatchQueue.main.async {
            
            UIViewController.activityIndactor.stopAnimating()
            UIViewController.activityIndactorView.removeFromSuperview()
            
        }
    }
}

extension UIView{
    var height : CGFloat {
        return frame.size.height
    }
    var width : CGFloat  {
        return frame.size.width
    }
    var left : CGFloat {
        return frame.origin.x
    }
    var right : CGFloat {
        return left + width
    }
    var top : CGFloat {
        return frame.origin.y
    }
    var bottom : CGFloat{
        return top + height
    }
    
}
