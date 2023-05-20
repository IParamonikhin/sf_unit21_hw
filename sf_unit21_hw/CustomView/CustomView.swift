//
//  CustomView.swift
//  sf_unit21_hw
//
//  Created by Иван on 20.05.2023.
//

import UIKit

class CustomView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var workingView: UIView!
    var xibName: String = "CustomView"
    
    var isBig: Bool = false
    
    var setBackgroundColor: UIColor = UIColor.white{
        didSet { workingView.backgroundColor = setBackgroundColor }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCustomView()
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    func getFromXib() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: xibName, bundle: bundle)
        let view = xib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    func doBigger() {
        workingView.frame = CGRect(x: workingView.frame.minX,
                                   y: workingView.frame.minY, width: workingView.frame.width + 30,
                                   height: workingView.frame.height + 30)
        cornerRadius(workingView)
    }
    
    func cornerRadius(_ view: UIView) {
        view.layer.cornerRadius = view.frame.height / 2
    }
    
    func setCustomView() {
        self.backgroundColor = .clear
        workingView = getFromXib()
//        cornerRadius(self)
        cornerRadius(workingView)
        workingView.frame = bounds
        workingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(workingView)
    }

}
