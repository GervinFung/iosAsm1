//
//  ViewController.swift
//  project
//
//  Created by Guest User on 6/27/21.
//  Copyright © 2021 Guest User. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height = self.view.frame.size.height - 250, width = self.view.frame.size.width;
        
        self.view.addSubview(self.createTopLabel(dimension: 175))
        let musicInstrumentName = ["piano", "cello", "guitar", "violin", "drum", "saxophone"]
        self.view.addSubview(MusicInstruments(musicInstrumentName: musicInstrumentName, height: Int(height), width: Int(width)))
    }
    
    private func createTopLabel(dimension: Int) -> UILabel {
        let label = UILabel(frame: CGRect(x: 30, y: 50, width: dimension * 2, height: 21))
        label.textAlignment = .center
        label.text = "Click the Instruments to Reveal the Name"
        label.isHidden = false
        return label
    }
}

final class MusicInstruments: UIImageView {
    
    private let label: UILabel, endLabel: UILabel
    private let musicInstrumentName: Array<String>
    private var index: Int;
    private let maxIndex: Int;
    
    init(musicInstrumentName: Array<String>, height: Int, width: Int) {
        
        self.musicInstrumentName = musicInstrumentName
        self.index = 0
        self.maxIndex = musicInstrumentName.count - 1
        
        let name = musicInstrumentName[0]
        self.label = UILabel(frame: CGRect(x: width / 2 - name.count * 42, y: height + 5, width: width, height: 50))
        self.label.font = UIFont.systemFont(ofSize: CGFloat(integerLiteral: 25))
        self.label.textAlignment = .center
        self.label.text = name
        self.label.isHidden = true
        
        self.endLabel = UILabel(frame: CGRect(x: width / 2 - name.count * 42, y: height + 60, width: width, height: 50))
        self.endLabel.font = UIFont.systemFont(ofSize: CGFloat(integerLiteral: 25))
        self.endLabel.textAlignment = .center
        self.endLabel.text = "You have reached the last instrument"
        self.endLabel.isHidden = true
        
        super.init(image: UIImage(named: "img/" + name + ".jpg"))
        
        //set the frame size of the UIImageView, with constant height & weight
        //x will have offset as well as y to set the position of the UIImageView
        self.frame = CGRect(x: 0, y: 90, width: width, height: height)
        
        //event listener for the UIImageView to display instrument name after clicking/tapping
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(singleTap)
        
        //add border to UIImageView for interface enhancement, otherwise, it's weird to see without border
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.gray.cgColor
        
        
        self.addSubview(self.label)
        self.addSubview(self.endLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapDetected() {
        self.label.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if (self.index == self.maxIndex) {
                self.endLabel.isHidden = false
                return
            }
            self.index += 1
            let name = self.musicInstrumentName[self.index]
            self.label.isHidden = true
            self.label.text = name
            self.image = UIImage(named: "img/" + name + ".jpg")
        }
    }
}
