//
//  DetailViewController.swift
//  CEDETEC
//
//  Created by Jorge Espinosa Lara on 9/13/18.
//  Copyright © 2018 BrafkaTeam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var className = "a"
    var classID = "asd"
    var classSchedule = "sdfg"
    var photo:[String] = ["asdf"]
    var video = "asdf"
    var model = "asdf"
    var aux = 0

    var url = URL(string: " ")
    var url2 = URL(string: " ")
    var url3 = URL(string: " ")
    var urlPug = URL(string: " ")
    var urlVideo = URL(string: " ")

    var image1: UIImage = UIImage()
    var image2: UIImage = UIImage()
    var image3: UIImage = UIImage()

    @IBOutlet weak var classNameLabel: UITextView!
    @IBOutlet weak var classIDLabel: UILabel!
    @IBOutlet weak var classScheduleLabel: UILabel!
    @IBOutlet weak var spinnerPhotos: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        classNameLabel.text = className
        classIDLabel.text = classID
        classScheduleLabel.text = classSchedule
        spinnerPhotos.isHidden = true
        url = URL(string: photo[0])
        url2 = URL(string: photo[1])
        url3 = URL(string: photo[2])
        urlPug = URL(string: model)
        urlVideo = URL(string: video)
    }

    @IBAction func photosButton(_ sender: Any) {
        spinnerPhotos.isHidden = false
        spinnerPhotos.startAnimating()
    }
    @IBAction func showPhotos(_ sender: UIButton) {
        aux = 1
    }

    @IBAction func showVideos(_ sender: UIButton) {
        aux = 2
    }

    @IBAction func showModel(_ sender: UIButton) {
        aux = 3
    }

    func downloadMultimedia(){
        if let data = try? Data(contentsOf: url!){
            let image : UIImage = UIImage(data: data)!
            image1 = image
        }
        if let data = try? Data(contentsOf: url2!){
            let image: UIImage = UIImage(data: data)!
            image2 = image
        }
        if let data = try? Data(contentsOf: url3!){
            let image: UIImage = UIImage(data: data)!
            image3 = image
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        spinnerPhotos.stopAnimating()
        spinnerPhotos.isHidden = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PhotosViewController{
            let siguienteVista = segue.destination as! PhotosViewController
            siguienteVista.a = url
            siguienteVista.b = url2
            siguienteVista.c = url3
        }
        if segue.destination is ModelViewController{
            let siguienteVista = segue.destination as! ModelViewController
            siguienteVista.d = urlPug
        }
        if segue.destination is VideosViewController{
            let siguienteVista = segue.destination as! VideosViewController
            siguienteVista.e = urlVideo
        }
    }
}
