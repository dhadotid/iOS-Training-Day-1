//
//  LoginViewController.swift
//  Training 1
//
//  Created by yudha on 30/09/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    var user : UserDefaults?
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        user = UserDefaults.standard
        
        let email = user?.string(forKey: "data_email")
        let hp = user?.string(forKey: "data_hp")
        
        if email?.count != 0 && hp?.count != 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tujuan = storyboard.instantiateViewController(identifier: "homeStory")
            tujuan.modalPresentationStyle = .fullScreen
            self.show(tujuan, sender: self)
        }
     }
    
    @IBAction func btnLogin(_ sender: Any) {
        
        let url = "http://192.168.64.2/server_resto_ios/index.php/Api/login"
        
        if tfEmail.text == "" || tfPassword.text == "" {
            //tampilkan alert
            showAlert(title: "Infor", message: "Tidak boleh kosong")
        }else{
            let params: [String: String] = ["email" : tfEmail.text!, "password" : tfPassword.text!]
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON{ (responseInsert) in
                let allJson = JSON(responseInsert.result.value as Any)
                let pesan = allJson["pesan"].stringValue
                let status = allJson["sukses"].boolValue
                
                if status{
                    
                    let data = allJson["data"]
                    let email = data["user_email"].stringValue
                    let hp = data["user_hp"].stringValue
                    
                    self.user?.setValue(email, forKey: "data_email")
                    self.user?.setValue(hp, forKey: "data_hp")
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tujuan = storyboard.instantiateViewController(identifier: "homeStory")
                    tujuan.modalPresentationStyle = .fullScreen
                    self.show(tujuan, sender: self)
                }else{
                    self.showAlert(title: "Gagal", message: pesan)
                }
            }
        }
    }
    
 
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
