//
//  ClassroomsTableViewController.swift
//  CEDETEC
//
//  Created by Jorge Espinosa Lara on 9/13/18.
//  Copyright © 2018 BrafkaTeam. All rights reserved.
//

import UIKit

class ClassroomsTableViewController: UITableViewController, UISearchResultsUpdating {

    var datosFiltrados = [Any]()
    let searchController = UISearchController(searchResultsController: nil)
    var floor = ""
    let direccion="https://s3.amazonaws.com/purple-cdtc/laboratorios.json"
    var nuevoArray:[Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: direccion)
        let datos = try? Data(contentsOf: url!)
        nuevoArray = try! JSONSerialization.jsonObject(with: datos!) as? [Any]
        datosFiltrados = nuevoArray!
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        self.tableView.backgroundColor = UIColor(red: 0.18, green: 0.19, blue: 0.20, alpha: 1.0)
        print(floor)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (datosFiltrados.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classroom", for: indexPath)
        let objetoMarca = datosFiltrados[indexPath.row] as! [String: Any]
        let s:String = objetoMarca["nombre"] as! String
        cell.textLabel?.text=s
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var indice = 0
        var objetoMarca = [String:Any]()
        let siguienteVista = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        if (self.searchController.isActive){
            indice = indexPath.row
            objetoMarca = datosFiltrados[indice] as! [String: Any]
            
        }else{
            indice = indexPath.row
            objetoMarca = nuevoArray![indice] as! [String: Any]
        }
        let s:String = objetoMarca["nombre"] as! String
        let t:String = objetoMarca["ubicacion"] as! String
        let u:String = objetoMarca["piso"] as! String
        let photos:[String] = objetoMarca["imagen"] as! [String]
        let videos:String = objetoMarca["video"] as! String
        let materials:String = objetoMarca["material"] as! String
        siguienteVista.className = s
        siguienteVista.classID = t
        siguienteVista.classSchedule = u
        siguienteVista.photo = photos
        siguienteVista.video = videos
        siguienteVista.model = materials
        self.navigationController?.pushViewController(siguienteVista, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text! == "" {
            datosFiltrados = nuevoArray!
        } else {
            datosFiltrados = nuevoArray!.filter{
                let objetoMarca=$0 as! [String:Any]
                let s:String = objetoMarca["nombre"] as! String;
                return(s.lowercased().contains(searchController.searchBar.text!.lowercased())) }
        }
        self.tableView.reloadData()
    }
    
    func JSONParseArray(_ string: String) -> [AnyObject]{
        if let data = string.data(using: String.Encoding.utf8){
            do{
                if let array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)  as? [AnyObject] {
                    return array
                }
            }catch{
                print("error")
            }
        }
        return [AnyObject]()
    }
}
