//
//  ViewController.swift
//  RigolDP832Test
//
//  Created by Michael Teeuw on 09-02-15.
//  Copyright (c) 2015 Michael Teeuw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var channel1switch: UISwitch!
    @IBOutlet weak var channel2switch: UISwitch!
    @IBOutlet weak var channel3switch: UISwitch!
    
    @IBOutlet weak var channel1VoltageSlider: UISlider!
    @IBOutlet weak var channel2VoltageSlider: UISlider!
    @IBOutlet weak var channel3VoltageSlider: UISlider!

    @IBOutlet weak var channel1CurrentSlider: UISlider!
    @IBOutlet weak var channel2CurrentSlider: UISlider!
    @IBOutlet weak var channel3CurrentSlider: UISlider!
    
    @IBOutlet weak var channel1VoltageLabel: UILabel!
    @IBOutlet weak var channel2VoltageLabel: UILabel!
    @IBOutlet weak var channel3VoltageLabel: UILabel!
    
    @IBOutlet weak var channel1CurrentLabel: UILabel!
    @IBOutlet weak var channel2CurrentLabel: UILabel!
    @IBOutlet weak var channel3CurrentLabel: UILabel!
    
    

    let rigol = RDPDevice()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        rigol.connect("rigollan.local")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func channelToggle(sender: UISwitch) {
        switch sender {
            case channel1switch:
                rigol.channels[0].active = sender.on
            case channel2switch:
                rigol.channels[1].active = sender.on
            case channel3switch:
                rigol.channels[2].active = sender.on
            default: break
        }
        
    }

    @IBAction func voltageChange(sender: UISlider) {
        
        switch sender {
            case channel1VoltageSlider:
                rigol.channels[0].voltage = sender.value
            case channel2VoltageSlider:
                rigol.channels[1].voltage = sender.value
            case channel3VoltageSlider:
                rigol.channels[2].voltage = sender.value
            default: break
        }
        
        updateUI()
    }
    
    @IBAction func currentChange(sender: UISlider) {
        
        switch sender {
            case channel1CurrentSlider:
                rigol.channels[0].current = sender.value
            case channel2CurrentSlider:
                rigol.channels[1].current = sender.value
            case channel3CurrentSlider:
                rigol.channels[2].current = sender.value
            default: break
        }
        
        updateUI()
    }
    
    
    func updateUI() {
        channel1VoltageLabel.text = String(format: "%.3fV", rigol.channels[0].voltage)
        channel2VoltageLabel.text = String(format: "%.3fV", rigol.channels[1].voltage)
        channel3VoltageLabel.text = String(format: "%.3fV", rigol.channels[2].voltage)
        
        channel1CurrentLabel.text = String(format: "%.3fA", rigol.channels[0].current)
        channel2CurrentLabel.text = String(format: "%.3fA", rigol.channels[1].current)
        channel3CurrentLabel.text = String(format: "%.3fA", rigol.channels[2].current)
        
    }
    
}





 
