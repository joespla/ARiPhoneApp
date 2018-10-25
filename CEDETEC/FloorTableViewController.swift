//
//  FloorTableViewController.swift
//  CEDETEC
//
//  Created by Jorge Espinosa Lara on 9/13/18.
//  Copyright © 2018 BrafkaTeam. All rights reserved.
//

import UIKit

class FloorTableViewController: UITableViewController {

    let datosJSON = "[ {\"piso\": \"Primer Piso\"}, {\"piso\": \"Segundo Piso\"}, {\"piso\": \"Tercer Piso\"}, {\"piso\": \"Cuarto Piso\"}]"
    
    var nuevoArray:[Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nuevoArray = JSONParseArray(datosJSON)
        self.tableView.backgroundColor = UIColor(red: 0.34, green: 0.69, blue: 0.98, alpha: 1.0)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (nuevoArray?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "floor", for: indexPath)
        let objetoMarca = nuevoArray![indexPath.row] as! [String: Any]
        let s:String = objetoMarca["piso"] as! String
        cell.textLabel?.text = s
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVista = segue.destination as! ClassroomsTableViewController
        let indice = self.tableView.indexPathForSelectedRow?.row
        let objetoMarca = nuevoArray![indice!] as! [String: Any]
        let s:String = objetoMarca["piso"] as! String
        if s == "Primer Piso" {
            siguienteVista.floor = "1"
        }else{
            if s == "Segundo Piso" {
               siguienteVista.floor = "2"
            }else{
                if s == "Tercer Piso" {
                    siguienteVista.floor = "3"
                }else{
                    siguienteVista.floor = "4"
                }
            }
        }
        
    }
 
    
    func JSONParseArray(_ string: String) -> [AnyObject]{
        if let data = string.data(using: String.Encoding.utf8){
            do{
                if let array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)  as? [AnyObject] {
                    return array
                }
            }catch{
                print("error")
                //handle errors here
            }
        }
        return [AnyObject]()
    }

}
