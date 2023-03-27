//
//  MOMViewModel.swift
//  MOM
//
//  Created by SowmiyaRagul on 26/03/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class MOMViewModel {
    //MARK: SignIn
    func signIn(userName: String,password: String,completionHandler: @escaping (Bool?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: userName, password: password) { (authResult, error) in
            if let error = error as? NSError {
                completionHandler(false,error)
            } else {
                completionHandler(true,nil)
            }
        }
    }
    
    //MARK: SignUp
    func signUp(userName: String,password: String,completionHandler: @escaping (Bool?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: userName, password: password) { (authResult, error) in
            if let error = error as? NSError {
                completionHandler(false,error)
            } else {
                completionHandler(true,nil)
            }
        }
    }
    
    //MARK: GetMOMlist
    func listOfMOM(completionHandler: @escaping (Bool?, Error?,DataSnapshot?) -> Void) {
        let ref = Database.database().reference()
        ref.child("MOM").observe(.value, with: { data in
            // Get user value
            completionHandler(true,nil,data)
        }) { error in
            completionHandler(false,error,nil)
        }
    }
    
    //MARK: SaveData
    func saveData(momDetail: MOMDetail?,completionHandler: @escaping (Bool?) -> Void) {
        var values : [String: Any] = [:]
        values["date"] = momDetail?.date
        values["title"] = momDetail?.title
        values["notes"] = momDetail?.notes
        values["time"] = momDetail?.key
        let ref = Database.database().reference().child("MOM").child(momDetail?.key ?? "")
        ref.updateChildValues(["title": momDetail?.title ?? ""])
        ref.updateChildValues(["notes": momDetail?.notes ?? ""])
        ref.updateChildValues(["date": momDetail?.date ?? ""])
    }
}

