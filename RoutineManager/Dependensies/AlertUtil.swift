//
//  AlertUtil.swift
//  RS
//
//  Created by ICoon on 29.07.2022.
//

import UIKit


public final class AlertUtil{
    
    
    func getAlert(title: String, subtitle: String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        return alert
    }

    
    func getPermissionAlert() -> UIAlertController{

        let alertController = UIAlertController(
            title: "Небоходимо разрешение",
            message: "Этому приложению необходимо разрешение получать уведомление. Его можно включить в настройках",
            preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (_) -> Void in
               
               guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                   return
               }
               if UIApplication.shared.canOpenURL(settingsUrl) {
                   UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                       exit(0)
                   })
                }
           }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) {(_) -> Void in
                exit(0)
            }
        
           alertController.addAction(cancelAction)
           alertController.addAction(settingsAction)
        
        return alertController
    }
}
