//
//  AKAULowShelfFilter.swift
//  AudioKit
//
//  Autogenerated by scripts by Aurelius Prochazka. Do not edit directly.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import AVFoundation

/** AudioKit version of Apple's LowShelfFilter Audio Unit */
public class AKAULowShelfFilter: AKOperation {
    
    private let cd = AudioComponentDescription(
        componentType: OSType(kAudioUnitType_Effect),
        componentSubType: OSType(kAudioUnitSubType_LowShelfFilter),
        componentManufacturer: OSType(kAudioUnitManufacturer_Apple),
        componentFlags: 0,
        componentFlagsMask: 0)
    
    private var internalEffect = AVAudioUnitEffect()
    private var internalAU = AudioUnit()
    
    /** Cutoff Frequency (Hz) ranges from 10 to 200 (Default: 80) */
    public var cutoffFrequency: Float = 80 {
        didSet {
            if cutoffFrequency < 10 {
                cutoffFrequency = 10
            }
            if cutoffFrequency > 200 {
                cutoffFrequency = 200
            }
            AudioUnitSetParameter(internalAU, kAULowShelfParam_CutoffFrequency, kAudioUnitScope_Global, 0, cutoffFrequency, 0)
        }
    }
    
    /** Gain (dB) ranges from -40 to 40 (Default: 0) */
    public var gain: Float = 0 {
        didSet {
            if gain < -40 {
                gain = -40
            }
            if gain > 40 {
                gain = 40
            }
            AudioUnitSetParameter(internalAU, kAULowShelfParam_Gain, kAudioUnitScope_Global, 0, gain, 0)
        }
    }
    
    /** Initialize the effect operation */
    public init(_ input: AKOperation) {
        super.init()
        internalEffect = AVAudioUnitEffect(audioComponentDescription: cd)
        output = internalEffect
        AKManager.sharedInstance.engine.attachNode(internalEffect)
        AKManager.sharedInstance.engine.connect(input.output!, to: internalEffect, format: nil)
        internalAU = internalEffect.audioUnit
    }
}