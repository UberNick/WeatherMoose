import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var fLabel: UILabel!
    @IBOutlet weak var cLabel: UILabel!

    let url = "https://samples.openweathermap.org/data/2.5/weather?zip=94040,us&appid=b6907d289e10d714a6e88b30761fae22"

    override func viewDidLoad() {
        super.viewDidLoad()

        fLabel.text = ""
        cLabel.text = ""
    }

    @IBAction func updateTapped(_ sender: Any) {
        print("tapped")
    }

}

