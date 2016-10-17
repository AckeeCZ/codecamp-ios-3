//
//  ViewController.swift
//  bi-ios-recognizers
//
//  Created by Dominik Vesely on 03/11/15.
//  Copyright © 2015 Ackee s.r.o. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PanelViewDelegate {
    
    weak var graphView : GraphView!
    weak var panelView : PanelView!
    
    var center : CGPoint = CGPoint(x: 0,y: 0)

    
    override func loadView() {
        self.view = UIView()
        view.backgroundColor = .white
        
        let gv = GraphView(frame: CGRect.zero)
        gv.autoresizingMask = UIViewAutoresizing.flexibleWidth;
        
        self.view.addSubview(gv)
        self.graphView = gv
        
        
        
        let pv = PanelView(frame: CGRect.zero)
        pv.autoresizingMask = UIViewAutoresizing.flexibleWidth;
        pv.delegate = self
        
        
        pv.onSliderChange = { [weak self]  (value : CGFloat) in
            self?.graphView.amplitude = value
        }
        
        view.addSubview(pv)
        panelView = pv
    }
    
    
    
    
    //MARK: PanelViewDelegate
    func sliderDidChange(_ slider: UISlider, panel: PanelView) {
       // self.graphView.amplitude = CGFloat(slider.value);
        
    }
    
    func stepperDidChange(_ stepper: UIStepper, panel: PanelView) {
        self.graphView.period = CGFloat(stepper.value);
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.graphView.frame = CGRect(x: 8, y: 20 + 8, width: self.view.bounds.width - 16, height: 200);
        self.panelView.frame = CGRect(x: 8, y: 20 + 16 + 200, width: self.view.bounds.width - 16, height: 128);
        
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapReco = UITapGestureRecognizer(target: self,
            action: #selector(ViewController.tapReco(_:)))
        tapReco.numberOfTapsRequired = 1
        tapReco.numberOfTouchesRequired = 1
        
        let doubleTapReco = UITapGestureRecognizer(target: self,
            action: #selector(ViewController.doubleTapReco(_:)))
        doubleTapReco.numberOfTapsRequired = 2
        
        tapReco.require(toFail: doubleTapReco)
        
        self.view.addGestureRecognizer(doubleTapReco)
        self.view.addGestureRecognizer(tapReco)
        
        let panReco = UIPanGestureRecognizer(target: self
            , action: #selector(ViewController.pan(_:)))
        graphView.addGestureRecognizer(panReco);
        
        
    }
    
    func tapReco(_ reco : UITapGestureRecognizer) {
       // print(reco.view)
        print("tapped")
    }
    
    func doubleTapReco(_ reco : UITapGestureRecognizer) {
        
        print("Double tapped")
    }
    
    func pan(_ reco : UIGestureRecognizer) {
        let point = reco.location(in: self.panelView)
        
        switch(reco.state) {
        case .began: break;
        case .changed:
            self.graphView.offset = self.graphView.center.y
                + point.y
        default:
            return
    }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

