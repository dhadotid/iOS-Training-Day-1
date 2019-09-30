//
//  RegisterViewController.swift
//  Training 1
//
//  Created by yudha on 30/09/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController {

    @IBOutlet weak var tfNama: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfHp: UITextField!
    
    @IBAction func btnRegister(_ sender: Any) {
        let url = "http://192.168.64.2/server_resto_ios/index.php/Api/register"
        
        if tfNama.text == "" || tfEmail.text == "" || tfPassword.text == "" || tfHp.text == "" {
            //tampilkan alert
            showAlert(title: "Infor", message: "Tidak boleh kosong")
        }else{
            let params: [String: String] = ["name" : tfNama.text!, "email" : tfEmail.text!, "password" : tfPassword.text!, "hp" : tfHp.text!]
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON{ (responseInsert) in
                let allJson = JSON(responseInsert.result.value as Any)
                let pesan = allJson["pesan"].stringValue
                let status = allJson["sukses"].boolValue
                
                if status{
                    self.navigationController?.popToRootViewController(animated: true)
                    self.showAlert(title: "Berhasil", message: pesan)
                }else{
                    self.showAlert(title: "Gagal", message: pesan)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
