import Foundation
import AVFoundation

class MusicModel {
    var player: AVAudioPlayer?
    
    func playSound(nameOfMusic: String) {
        
        DispatchQueue.global().async {
            guard let path = Bundle.main.path(forResource: nameOfMusic, ofType: "mp3") else { return }
            let url = URL(fileURLWithPath: path)

            do {
                self.player = try AVAudioPlayer(contentsOf: url)
                self.player?.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
