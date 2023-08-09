//
//  Extention.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import UIKit


extension UIViewController{
    
    func setupNavbar(title: String){
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.appGreen()
        self.title =  title
        self.navigationItem.backButtonDisplayMode = .minimal
    }
    
    func blurEffect(){
        let blurEffect = UIBlurEffect(style: .light)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
            blurVisualEffectView.frame = view.bounds
        self.view.addSubview(blurVisualEffectView)
    }
    
}


extension UIColor{
    static func appGreen() -> UIColor{
        return UIColor(red: 8/255.0, green: 119/255.0, blue: 45/255.0, alpha: 1.0)
    }
    
    static func appRed() -> UIColor{
        return UIColor(red: 174/255.0, green: 24/255.0, blue: 32/255.0, alpha: 1.0)
    }
}


extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
