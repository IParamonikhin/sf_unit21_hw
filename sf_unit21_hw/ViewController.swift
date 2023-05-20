//
//  ViewController.swift
//  sf_unit21_hw
//
//  Created by Иван on 20.05.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var panOutlet: UIPanGestureRecognizer!
    

    var customViewArray = [CustomView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0...6{
            let newCustomViewElement: CustomView = CustomView(frame: CGRect(x: 10, y: 100 + 100 * index, width: 90, height: 90))
            customViewArray.append(newCustomViewElement)
            let panAction = UIPanGestureRecognizer(target: self, action: #selector(panAction))
            customViewArray[index].addGestureRecognizer(panAction)
            view.addSubview(customViewArray[index])
        }
    }

    @IBAction func panAction(_ gesture: UIPanGestureRecognizer) {
        var isBig: Bool = false
        struct Capture{
            var x: Bool
            var y: Bool
        }

        let gestureTranslation = gesture.translation(in: view)
        
        guard let gestureView = gesture.view else { return }
        
        for index in 0...customViewArray.count - 1{
            if gestureView == customViewArray[index]{
                if customViewArray[index].isBig{
                    isBig = true
                }
            }
        }
        gestureView.center = CGPoint(x: gestureView.center.x + gestureTranslation.x, y: gestureView.center.y + gestureTranslation.y)
        for index in 0...customViewArray.count - 1{
            var capture: Capture = Capture(x: false, y: false)
            let enemyView = customViewArray[index]
            if !enemyView.isBig && !enemyView.isHidden && !isBig{
                if gestureView != enemyView{
                    
                    for value in Int(enemyView.frame.minY)...Int(enemyView.frame.maxY) {
                        if Int(gestureView.center.y) == value {
                            capture.y = true
                        }
                    }
                    for value in Int(enemyView.frame.minX)...Int(enemyView.frame.maxX) {
                        if Int(gestureView.center.x) == value {
                            capture.x = true
                        }
                    }
                    
                    if capture.x && capture.y{
                        enemyView.doBigger()
                        enemyView.setBackgroundColor = .systemIndigo
                        gestureView.isHidden = true
                        capture.x = false
                        capture.y = false
                        enemyView.isBig = true
                    }
                }
            }
        }
        gesture.setTranslation(.zero, in: view)
        
        guard gesture.state == .ended else { return }
        
        
    }
    
}

