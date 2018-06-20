//
//  ViewController.swift
//  SpinTheBottle
//
//  Created by Karen Tserunyan on 6/20/18.
//  Copyright © 2018 Karen Tserunyan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var backgroundImageView: UIImageView!
    var bottleImageView: UIImageView!
    var spinningSoundPlayer: AVAudioPlayer?
    
    lazy var spinButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .gray
        button.setTitle("Spin", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(spinTheBottle), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "background"))
        self.bottleImageView = UIImageView(image: #imageLiteral(resourceName: "bottle2"))
        
        view.addSubview(backgroundImageView)
        view.addSubview(bottleImageView)
        view.addSubview(spinButton)
        setupSpinButton()
        
        backgroundImageView.frame = self.view.frame
        bottleImageView.center = self.view.center
    }
    
    func setupSpinButton() {
        spinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        spinButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        spinButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func handleRotate360DegreesRandom(view: UIView) {
        let rotateAnimation = CABasicAnimation()
        let randonAngle = arc4random_uniform(2160) + 1080
        //        rotateView.fromValue = 0
        rotateAnimation.toValue = Float(randonAngle) * Float(Double.pi) / 180.0
        rotateAnimation.duration = 5
        rotateAnimation.repeatCount = 0
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.fillMode = kCAFillModeForwards
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(rotateAnimation, forKey: "transform.rotation.z")
    }
    
    
    @objc func spinTheBottle(){
        
        handleRotate360DegreesRandom(view: bottleImageView)
        
        let path = Bundle.main.path(forResource: "spinsound.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            spinningSoundPlayer?.stop()
            spinningSoundPlayer = try AVAudioPlayer(contentsOf: url)
            spinningSoundPlayer?.play()
        } catch {
            //handle errors
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
