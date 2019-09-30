//
//  MenuTableViewController.swift
//  Training 1
//
//  Created by yudha on 30/09/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MenuTableViewController: UITableViewController {

    var data = [[String : String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    //hitung data array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    //tampilkan data array
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu", for: indexPath) as! MenuTableViewCell
        
        let datas = data[indexPath.row]
        
        cell.lblNama.text = datas["menu_nama"]
        cell.lblHarga.text = datas["menu_harga"]
        let gambar = datas["menu_gambar"]
        
        Alamofire.request(gambar!).responseJSON { (getImage) in
            let dataGambar = getImage.data
            cell.imgMenu.image = UIImage(data: dataGambar!)
        }
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    
    func getData(){
        let url = "http://192.168.64.2/server_resto_ios/index.php/Api/getMakanan"
        
        Alamofire.request(url).responseJSON { (getDataMakanan) in
            let allJson = JSON(getDataMakanan.result.value as Any)
            let success = allJson["sukses"].boolValue
            
            if success{
                self.data = allJson["data"].arrayObject as! [[String : String]]
                
                self.tableView.reloadData()
            }
            
        }
    }
    
    //swipe to delete
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let datas = data[indexPath.row]
            let id = datas["menu_id"]
            let params : [String: String] = ["id" : id!]
            let urlDelete = "http://192.168.64.2/server_resto_ios/index.php/Api/deleteMakanan"
            Alamofire.request(urlDelete, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON{ (responseDelete) in
                let allJson = JSON(responseDelete.result.value as Any)
                let pesan = allJson["pesan"].stringValue
                let sukses = allJson["sukses"].boolValue
                
                if sukses{
                    self.showAlert(title: "Berhasil", message: pesan)
                    self.getData()
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
    
    //swipe to update
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            
            let datas = self.data[indexPath.row]
            let nama = datas["menu_nama"]
            let harga = datas["menu_harga"]
            let urlGambar = datas["menu_gambar"]
            let id = datas["menu_id"]
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tujuan = storyboard.instantiateViewController(identifier: "EditMenu") as EditMenuViewController
            
            tujuan.strNama = nama
            tujuan.strHarga = harga
            tujuan.strUrlGambar = urlGambar
            tujuan.id = id
            
            self.show(tujuan, sender: self)
        }
        
        //LITTERAL untuk color picker
        editAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
