//
//  RDPChannel.swift
//  RigolDP832Test
//
//  Created by Michael Teeuw on 09-02-15.
//  Copyright (c) 2015 Michael Teeuw. All rights reserved.
//

import Foundation

class RDPChannel {
    
    var device: RDPDevice
    var channelIdentifier: String
    
    var voltage:Float = 0 { didSet { updateChannel() }}
    var current:Float = 0 { didSet { updateChannel() }}
    var active:Bool = false {
        didSet {
            device.toggleChannel(channelIdentifier, toState: active)
        }
    }
    
    init(channelIdentifier:String, forDevice device:RDPDevice) {
        self.channelIdentifier = channelIdentifier
        self.device = device
    }
    
    func updateChannel() {
        device.setChannel(channelIdentifier, toVoltage: voltage, andCurrent: current)
    }
    
}