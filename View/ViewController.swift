import UIKit

class ViewController: UIViewController {
    var startBackgroundView = UIImageView()
    var startButton = UIButton()
    var rulesButton = UIButton()
    let moneyBackgraundImage = UIImage(named: "moneyAndLogo")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startBackgroundView = UIImageView(frame: self.view.bounds)
        startBackgroundView.contentMode = .scaleAspectFill
        startBackgroundView.image = moneyBackgraundImage
        startBackgroundView.center = view.center
        view.addSubview(startBackgroundView)
        
        startButton = UIButton(type: .roundedRect)
        startButton.setBackgroundImage(UIImage.init(named: "PlayButton"), for: .normal)
        startButton.frame = CGRect(x: 50, y: 650, width: 150, height: 70)
        //startButton.setTitle("Играть", for: .normal)
        view.addSubview(startButton)
        
        rulesButton = UIButton(type: .roundedRect)
        rulesButton.setBackgroundImage(UIImage.init(named: "RulesButton"), for: .normal)
        rulesButton.frame = CGRect(x: 220, y: 650, width: 150, height: 70)
        view.addSubview(rulesButton)
        
    }
}
