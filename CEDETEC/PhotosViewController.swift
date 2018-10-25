//
//  PhotosViewController.swift
//  CEDETEC
//
//  Created by Jorge Espinosa Lara on 10/24/18.
//  Copyright © 2018 BrafkaTeam. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UIImagePickerControllerDelegate {
    
    var a: UIImage = UIImage()
    var b: UIImage = UIImage()
    var c: UIImage = UIImage()
    var d = URL(string: " ")
    
    @IBOutlet weak var roundRound: UIActivityIndicatorView!
    @IBOutlet weak var fotoVista: UIImageView!
    @IBOutlet weak var fotoVista2: UIImageView!
    @IBOutlet weak var fotoVista3: UIImageView!
    private let miPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fotoVista.image = a
        fotoVista2.image = b
        fotoVista3.image = c
        
        // Do any additional setup after loading the view.
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
