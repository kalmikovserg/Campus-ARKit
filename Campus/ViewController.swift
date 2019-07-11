//
//  ViewController.swift
//  Campus
//
//  Created by Сергей Калмыков on 7/9/19.
//  Copyright © 2019 Сергей Калмыков. All rights reserved.
//

import ARKit

class ViewController: UIViewController {
    
    var configuration: ARConfiguration!
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet var selectTypeCamera: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let campus = loadModel(name: "Cumpus.scnassets/campus.scn")!
        campus.position = SCNVector3(-2, -2, -5)
        sceneView.scene.rootNode.addChildNode(campus)
        
        let computerCampus = createCapus()
        computerCampus.position = SCNVector3(3, 0 , -4)
        sceneView.scene.rootNode.addChildNode(computerCampus)
        
        selectTypeCamera.selectedSegmentIndex = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        workCamera()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    @IBAction func choseCamera(_ sender: UISegmentedControl) {
        workCamera()
    }
    
    func createCapus() -> SCNNode {
        let box = SCNBox(width: 3, height: 1, length: 1, chamferRadius: 0)
        let bricks = UIImage(named: "Cumpus.scnassets/Bricks.jpg")
        let matirial = SCNMaterial()
        matirial.diffuse.contents = bricks
        box.materials = [matirial]
        let bulding = SCNNode(geometry: box)
        return bulding
    }
    
    private func workCamera() {
        switch selectTypeCamera.selectedSegmentIndex {
        case 0:
            configuration =  ARFaceTrackingConfiguration.isSupported ? ARFaceTrackingConfiguration() : ARWorldTrackingConfiguration()
        case 1:
            configuration = ARWorldTrackingConfiguration()
        default:
            break
        }
        sceneView.session.run(configuration, options: [])
    }
    
    private func loadModel(name: String) -> SCNNode? {
        guard let scene = SCNScene(named: name) else { return nil }
        return scene.rootNode.clone()
    }
}

