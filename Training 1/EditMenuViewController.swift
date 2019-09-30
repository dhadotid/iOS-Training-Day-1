//
//  EditMenuViewController.swift
//  Training 1
//
//  Created by yudha on 30/09/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit

class EditMenuViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfHarga: UITextField!
    @IBOutlet weak var tfUrlGambar: UITextField!
    @IBOutlet weak var ivImageMenu: UIImageView!
    
    //setter & getter
    var strNama: String?
    var strHarga: String?
    var strUrlGambar: String?
    var id: String?
    
    @IBAction func btnEditData(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
