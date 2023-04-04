//
//  SoundManager.swift
//  Pongoal
//
//  Created by Nik Cadez on 31/01/2023.
//

import Foundation
import AVFoundation

class SoundManager {
    var hit1: AVAudioPlayer!
    var hit2: AVAudioPlayer!
    var hit3: AVAudioPlayer!
    var hit4: AVAudioPlayer!
    var hit5: AVAudioPlayer!
    var hit6: AVAudioPlayer!
    var hit7: AVAudioPlayer!
    var hit8: AVAudioPlayer!
    
    var boost: AVAudioPlayer!
    var music: AVAudioPlayer!
    
    var siren1: AVAudioPlayer!
    var siren2: AVAudioPlayer!
    var siren3: AVAudioPlayer!
    var siren4: AVAudioPlayer!
    var siren5: AVAudioPlayer!
    var siren6: AVAudioPlayer!
    
    var bounce1: AVAudioPlayer!
    var bounce2: AVAudioPlayer!
    var bounce3: AVAudioPlayer!
    var bounce4: AVAudioPlayer!
    var bounce5: AVAudioPlayer!
    
    var click1: AVAudioPlayer!
    var click2: AVAudioPlayer!
    var click3: AVAudioPlayer!
    var click4: AVAudioPlayer!
    var click5: AVAudioPlayer!
    
    init() {
        hit1 = try! AVAudioPlayer(contentsOf: getUrl(name: "hit1"))
        hit2 = try! AVAudioPlayer(contentsOf: getUrl(name: "hit2"))
        hit3 = try! AVAudioPlayer(contentsOf: getUrl(name: "hit3"))
        hit4 = try! AVAudioPlayer(contentsOf: getUrl(name: "hit4"))
        hit6 = try! AVAudioPlayer(contentsOf: getUrl(name: "hit5"))
        hit5 = try! AVAudioPlayer(contentsOf: getUrl(name: "hit6"))
        hit7 = try! AVAudioPlayer(contentsOf: getUrl(name: "hit7"))
        hit8 = try! AVAudioPlayer(contentsOf: getUrl(name: "hit8"))
        
        boost = try! AVAudioPlayer(contentsOf: getUrl(name: "boost"))
        music = try! AVAudioPlayer(contentsOf: getUrl(name: "music"))
        music.numberOfLoops = -1
        siren1 = try! AVAudioPlayer(contentsOf: getUrl(name: "siren"))
        siren2 = try! AVAudioPlayer(contentsOf: getUrl(name: "siren"))
        siren3 = try! AVAudioPlayer(contentsOf: getUrl(name: "siren"))
        siren4 = try! AVAudioPlayer(contentsOf: getUrl(name: "siren"))
        siren5 = try! AVAudioPlayer(contentsOf: getUrl(name: "siren"))
        siren6 = try! AVAudioPlayer(contentsOf: getUrl(name: "siren"))
        
        bounce1 = try! AVAudioPlayer(contentsOf: getUrl(name: "bounce1"))
        bounce2 = try! AVAudioPlayer(contentsOf: getUrl(name: "bounce2"))
        bounce3 = try! AVAudioPlayer(contentsOf: getUrl(name: "bounce3"))
        bounce4 = try! AVAudioPlayer(contentsOf: getUrl(name: "bounce4"))
        bounce5 = try! AVAudioPlayer(contentsOf: getUrl(name: "bounce5"))
        
        click1 = try! AVAudioPlayer(contentsOf: getUrl(name: "click"))
        click2 = try! AVAudioPlayer(contentsOf: getUrl(name: "click"))
        click3 = try! AVAudioPlayer(contentsOf: getUrl(name: "click"))
        click4 = try! AVAudioPlayer(contentsOf: getUrl(name: "click"))
        click5 = try! AVAudioPlayer(contentsOf: getUrl(name: "click"))
        
        volumeEdit()
    }
    
    func playSiren() {
        let random1: Int = Int.random(in: 1...6)
        switch(random1) {
        case 1:
            siren1.play()
            break
        case 2:
            siren2.play()
            break
        case 3:
            siren3.play()
            break
        case 4:
            siren4.play()
            break
        case 5:
            siren5.play()
            break
        default:
            siren6.play()
            break
        }
    }
    
    func playHit() {
        let random1: Int = Int.random(in: 1...5)
        switch(random1) {
        case 1:
            click1.play()
            break
        case 2:
            click2.play()
            break
        case 3:
            click3.play()
            break
        case 4:
            click4.play()
            break
        case 5:
            click5.play()
            break
        default:
            break
        }
        
    }
    
    func playClick() {
        let random1: Int = Int.random(in: 1...5)
        switch(random1) {
        case 1:
            click1.play()
            break
        case 2:
            click2.play()
            break
        case 3:
            click3.play()
            break
        case 4:
            click4.play()
            break
        case 5:
            click5.play()
            break
        default:
            break
        }
        
    }
    
    func playBounce() {
        let random1: Int = Int.random(in: 1...5)
        switch(random1) {
        case 1:
            bounce1.play()
            break
        case 2:
            bounce2.play()
            break
        case 3:
            bounce3.play()
            break
        case 4:
            bounce4.play()
            break
        case 5:
            bounce5.play()
            break
        default:
            break
        }
    }
    
    
    func getPercentigeSFX()->Float {
            if let point = UserDefaults.standard.object(forKey: "slider1") as? CGFloat {
                let pos:Float = Float(point)
                let maxMin: Float = 150 + 125
                let to100: Float = (pos + 125) / maxMin
                return to100
            } else {
                return 0.5
            }
    }
    
    func getPercentigeS()->Float {
        if let point = UserDefaults.standard.object(forKey: "slider2") as? CGFloat {
            let pos:Float = Float(point)
            let maxMin: Float = 150 + 125
            let to100: Float = (pos + 125) / maxMin
            return to100
        } else {
            return 0.5
        }
    }
    
    func volumeEdit() {
        correctVolumeForSound(volumePercent: getPercentigeS())
        correctVolumeForSoundFX(volumePercent: getPercentigeSFX())
        
    }
    
    func correctVolumeForSoundFX(volumePercent: Float) {
        hit1.volume = volumePercent
        hit2.volume = volumePercent
        hit3.volume = volumePercent
        hit4.volume = volumePercent
        hit5.volume = volumePercent
        hit6.volume = volumePercent
        hit7.volume = volumePercent
        hit8.volume = volumePercent
        boost.volume = volumePercent
        click1.volume = volumePercent
        click2.volume = volumePercent
        click3.volume = volumePercent
        click4.volume = volumePercent
        click5.volume = volumePercent
        siren1.volume = volumePercent
        siren2.volume = volumePercent
        siren3.volume = volumePercent
        siren4.volume = volumePercent
        siren5.volume = volumePercent
        siren6.volume = volumePercent
        bounce1.volume = volumePercent
        bounce2.volume = volumePercent
        bounce3.volume = volumePercent
        bounce4.volume = volumePercent
        bounce5.volume = volumePercent
    }
    
    func correctVolumeForSound(volumePercent: Float) {
        music.volume = volumePercent
    }
    
    private func getUrl(name:String) -> URL {
        let extensionWav = "wav"
        let url = Bundle.main.url(forResource: name, withExtension: extensionWav)!
        return url
    }
}
