//
//  ModelViewController.swift
//  CEDETEC
//
//  Created by Jorge Espinosa Lara on 10/24/18.
//  Copyright © 2018 BrafkaTeam. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ModelViewController: UIViewController, ARSCNViewDelegate {
    
    //Paso 1 agregar una variable para almacenar el pug
    var nodoRaiz:SCNNode?
    var d:URL?
    
    var currentAngleY: Float = 0.0
    var isRotating = false
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
        let scene = SCNScene()
        nodoRaiz?.position = SCNVector3(x:0, y:0, z:-0.5)
        
        if nodoRaiz != nil {
            scene.rootNode.addChildNode(nodoRaiz!)
        }
        
        sceneView.scene = scene
    }
    
    
    
    @IBAction func borrar(_ sender: UILongPressGestureRecognizer) {
        nodoRaiz?.removeFromParentNode()
        nodoRaiz = nil
    }
    
    @IBAction func escalar(_ sender: UIPinchGestureRecognizer) {
            nodoRaiz!.scale = SCNVector3(sender.scale, sender.scale, sender.scale)
    }
    
    //rotar
    
    @objc func rotar(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!)
        
        let x = Float(translation.x)
        let y = Float(-translation.y)
        let anglePan = (sqrt(pow(x,2)+pow(y,2)))*(Float)(Double.pi)/180.0
        
        var rotationVector = SCNVector4()
        rotationVector.x = x
        rotationVector.y = y
        rotationVector.z = 0.0
        rotationVector.w = anglePan
        
        if nodoRaiz != nil {
            self.nodoRaiz!.rotation = rotationVector
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if nodoRaiz == nil {
            if let touch = touches.first {
                let touchLocation = touch.location(in: sceneView)
                let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)

                if let hitResult = results.first {
                    // Create a new scene
                    do{
                        let diceScene = try SCNScene(url: d!,options: [.overrideAssetURLs: true])
                        nodoRaiz = diceScene.rootNode.childNode(withName: "Pug", recursively: true)
                        nodoRaiz!.position = SCNVector3(
                            x: hitResult.worldTransform.columns.3.x,
                            y: hitResult.worldTransform.columns.3.y,
                            z: hitResult.worldTransform.columns.3.z
                        )
                        sceneView.scene.rootNode.addChildNode(nodoRaiz!)
                    }catch{
                        print("ERROR loading scene")
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.pause()
    }
}
