import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var fLabel: UILabel!
    @IBOutlet weak var cLabel: UILabel!

    let urlString = "https://api.openweathermap.org/data/2.5/weather"
    let appId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        fLabel.text = ""
        cLabel.text = ""
        textField.becomeFirstResponder()
    }

    @IBAction func updateTapped(_ sender: Any) {
        textField.resignFirstResponder()
        fLabel.text = ""
        cLabel.text = ""

        let urlString = "\(self.urlString)?zip=\(textField.text ?? "")&appid=\(appId)"
        guard let url = URL(string: urlString) else {
            presentAlert("Bad URL")
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                guard let data = data,
                    let weatherResponse = try? JSONDecoder().decode(WeatherReponse.self, from: data) else {
                    self?.presentAlert("Service error")
                    return
                }
                self?.cLabel.text = "\(weatherResponse.cTemp)°C"
                self?.fLabel.text = "\(weatherResponse.fTemp)°F"
            }
        }
        task.resume()
    }

    func presentAlert(_ title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }

}

struct WeatherReponse: Codable {
    let name: String
    let main: WeatherMain
    struct WeatherMain: Codable {
        let temp: Double
    }

    var cTemp: Int { get {
        return Int(main.temp - 273.15)
    }}

    var fTemp: Int { get {
        return Int((main.temp - 273.15) * 9/5 + 32)
    }}
}
