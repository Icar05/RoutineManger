//
//  SoundUtil.swift
//  RS
//
//  Created by ICoon on 28.06.2022.
//

import Foundation
import AVFoundation


 enum SoundCaf: String{
    case OldRing          =  "OldRing"
    case StandartAlarm    =  "standart-alarm"
    case birdOne          =  "birdOne"
    case birdTwo          =  "birdTwo"
    
    case DoubleClick      =  "DoubleClick"
    case Tap              =  "Tap"
    case RecorderClick    =  "RecorderClick"
    
    case MouseOff         =  "MouseOff"
    case MouseOn          =  "MouseOn"
    case Response         =  "Response"
    case Ring             =  "Ring"
    case SimpleResponse   =  "SimpleResponse"
    case SwitchOff        =  "SwitchOff"
    case SwitchOn         =  "SwitchOn"
 
}

class SoundUtil{
    
        
    private let enable: Bool
    
    private let volume: Float
    
    private let sound: SoundCaf
    
    private var player: AVAudioPlayer? = nil
    
    
    init(sound: SoundCaf){
        self.enable = true
        self.volume = 1.0
        self.sound = sound
        self.initPlayer()
    }
    
    private func initPlayer(){
        if(enable){
                                    
            do {
                guard let path = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3") else {
                    print("Sound file not found")
                    return
                }
                
                let storedURL = URL(fileURLWithPath: path)
                self.player   = try AVAudioPlayer(contentsOf: storedURL, fileTypeHint: AVFileType.mp3.rawValue)
                self.player?.volume = volume
            } catch let error {
                print("Player: error: \(error) ")
            }
        }
    }
    
    func stop(){
        player?.stop()
    }
    
    func play(){
        guard let player = player else {
            return
        }

        player.play()
    }
    
}


extension SoundCaf{
    static func timerSound() -> SoundCaf{
        return  SoundCaf.StandartAlarm
    }
    
    static func sectionSound() -> SoundCaf{
        return .DoubleClick
    }
    
    static func rotationSound() -> SoundCaf{
        return .MouseOff
    }
    
    static func transitionSound() -> SoundCaf{
        return .Tap
    }
    
    static func responseSound() -> SoundCaf {
        return .SimpleResponse
    }
    
    static func actionSound() -> SoundCaf{
        return .SwitchOn
    }
}
