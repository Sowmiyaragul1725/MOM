//
//  BaseViewController.swift
//  MOM
//
//  Created by SowmiyaRagul on 26/03/23.
//

import UIKit

class BaseViewController : UIViewController {
    //MARK: ShowAlert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
