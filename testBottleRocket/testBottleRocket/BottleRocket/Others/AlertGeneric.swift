//
//  AlertGeneric.swift
//  testBottleRocket
//
//  Created by roreyesl on 08/09/21.
//

import Foundation
import UIKit

class AlertGeneric {
    
    //MARK: - Functions
    
    static public func simpleWith(title        : String? = "Bottle Rocket",
                                  message      : String?,
                                  actionTitle  : String = "Aceptar",
                                  actionHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {       
        let alertController = UIAlertController(title         : title,
                                                message       : message ?? "",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title  : actionTitle,
                                                style  : .default,
                                                handler: actionHandler))
        return alertController
    }
}
