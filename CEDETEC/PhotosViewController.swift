//
//  PhotosViewController.swift
//  CEDETEC
//
//  Created by Jorge Espinosa Lara on 10/24/18.
//  Copyright © 2018 BrafkaTeam. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var ph3spinner: UIActivityIndicatorView!
    @IBOutlet weak var ph2spinner: UIActivityIndicatorView!
    @IBOutlet weak var ph1spinner: UIActivityIndicatorView!
    @IBAction func nextPhoto(_ sender: UIButton) {
        if cont == 3{
            cont = 0
        }
        if cont == 0{
            getData(from: a!) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.fotoVista.image = UIImage(data:data)
                }
            }
            cont += 1
        }else if cont == 1{
            getData(from: b!) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.fotoVista.image = UIImage(data:data)
                }
            }
            cont += 1
        }else{
            getData(from: c!) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.fotoVista.image = UIImage(data:data)
                }
            }
            cont += 1
        }
    }
    @IBAction func prevPhoto(_ sender: UIButton) {
        if cont == -1{
            cont = 2
        }
        if cont == 2{
            getData(from: c!) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.fotoVista.image = UIImage(data:data)
                }
            }
            cont -= 1
        }else if cont == 1{
            getData(from: b!) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.fotoVista.image = UIImage(data:data)
                }
            }
            cont -= 1
        }else{
            getData(from: a!) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.fotoVista.image = UIImage(data:data)
                }
            }
            cont -= 1
        }
    }
    var a: URL?
    var b: URL?
    var c: URL?
    var d = URL(string: " ")
    let photos: [URL?] = []
    var cont = 0
    
    @IBOutlet weak var roundRound: UIActivityIndicatorView!
    @IBOutlet weak var fotoVista: UIImageView!
    private let miPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage1(from: a!)
        ph1spinner.startAnimating()
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage1(from url: URL) {
        print("Image download started...")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.fotoVista.image = UIImage(data:data)
                self.ph1spinner.stopAnimating()
                self.ph1spinner.isHidden = true
            }
        }
    }

}
