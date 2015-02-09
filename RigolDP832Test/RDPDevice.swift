//
//  RDPDevice.swift
//  RigolDP832Test
//
//  Created by Michael Teeuw on 09-02-15.
//  Copyright (c) 2015 Michael Teeuw. All rights reserved.
//

import Foundation

class RDPDevice: NSObject, GCDAsyncSocketDelegate {
    
    var socket: GCDAsyncSocket!
    var channels = [RDPChannel]()
    
    override init() {
        super.init()
        
        // Initialize channels.
        channels = [
            RDPChannel(channelIdentifier: "CH1", forDevice: self),
            RDPChannel(channelIdentifier: "CH2", forDevice: self),
            RDPChannel(channelIdentifier: "CH3", forDevice: self)
        ]
        
        // Set up socket.
        let mainQueue = dispatch_get_main_queue()
        socket = GCDAsyncSocket(delegate: self, delegateQueue: mainQueue)
    }
    
    func connect(host:String) {
       println("Connect to: \(host)")
        
        var error:NSError?
        
        socket.connectToHost(host, onPort: 5555, error: &error)
        
        if error != nil {
            println("Error: \(error)")
        }
    }
    
    func setChannel(channel:String, toVoltage voltage:Float, andCurrent current:Float) {
        sendCommandString(":APPL \(channel),\(voltage),\(current)")
    }
    
    func toggleChannel(channel:String, toState state:Bool) {
        let stateString = state ? "ON" : "OFF"
        sendCommandString(":OUTP \(channel),\(stateString)")
    }
    
    func sendCommandString(command:String) {
        let commandString = "\(command)\n"
        if let commandData = commandString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            println("SEND: \(commandString)")
            socket.writeData(commandData, withTimeout: -1, tag: 0)
        }
    }
    
}

// MARK: - Socket Delegate

extension RDPDevice {
    
    func socket(sock: GCDAsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        println("Socket connected to host: \(host)")
    }
    
    func socketDidDisconnect(sock: GCDAsyncSocket!, withError err: NSError!) {
        println("Socket dod disconnect with error: \(err)")
    }
}
   