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
    var a: URL?
    var b: URL?
    var c: URL?
    var d = URL(string: " ")
    
    @IBOutlet weak var roundRound: UIActivityIndicatorView!
    @IBOutlet weak var fotoVista: UIImageView!
    @IBOutlet weak var fotoVista2: UIImageView!
    @IBOutlet weak var fotoVista3: UIImageView!
    private let miPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage1(from: a!)
        downloadImage2(from: b!)
        downloadImage3(from: c!)
        ph1spinner.startAnimating()
        ph2spinner.startAnimating()
        ph3spinner.startAnimating()
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage1(from url: URL) {
        print("Image download started...")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Image download finished...")
            DispatchQueue.main.async() {
                self.fotoVista.image = UIImage(data:data)
                self.ph1spinner.stopAnimating()
                self.ph1spinner.isHidden = true
            }
        }
    }
    func downloadImage2(from url: URL) {
        print("Image download started...")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Image download finished...")
            DispatchQueue.main.async() {
                self.fotoVista2.image = UIImage(data:data)
                self.ph2spinner.stopAnimating()
                self.ph2spinner.isHidden = true
            }
        }
    }
    func downloadImage3(from url: URL) {
        print("Image download started...")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Image download finished...")
            DispatchQueue.main.async() {
                self.fotoVista3.image = UIImage(data:data)
                self.ph3spinner.stopAnimating()
                self.ph3spinner.isHidden = true
            }
        }
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        fotoVista.image = url as? UIImage
//        picker.dismiss(animated: true, completion: nil)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
