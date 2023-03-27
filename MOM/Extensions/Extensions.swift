//
//  Extensions.swift
//  MOM
//
//  Created by SowmiyaRagul on 26/03/23.
//

import UIKit

let date = Date()
let calendar = Calendar.current
let hour = calendar.component(.hour, from: date)
let minutes = calendar.component(.minute, from: date)
let seconds = calendar.component(.second, from: date)

extension UITextField {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
      }
      
      func isValidPassword(_ password: String) -> Bool {
        let minPasswordLength = 6
        return password.count >= minPasswordLength
      }
}

extension Date {
    func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
         let yourDate = formatter.string(from: date)
         return yourDate
    }
}

extension Array {
     func contains<T>(obj: T) -> Bool where T: Equatable {
         return !self.filter({$0 as? T == obj}).isEmpty
     }
 }
