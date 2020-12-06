import UIKit

class ViewController: UIViewController {
    
    private var red = UserSettings.red
    private var green = UserSettings.green
    private var blue = UserSettings.blue
    
    private let slidersView = SlidersView()
    private let backgroundView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: red, green: green, blue: blue)
        slidersView.delegate = self
        setup()
    }
    
    private func setup() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.image = UIImage(named: "background")
        
        slidersView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slidersView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            slidersView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            slidersView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            slidersView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
    
    private func colors() -> String {
        let hexValue = String(format:"%02X", Int(red)) + String(format:"%02X", Int(green)) + String(format:"%02X", Int(blue))
        
        return hexValue
    }
    
    private func setProperties(view: SlidersView, color: (color: UIColor, red: Int, green: Int, blue: Int)) {
        view.redSlider.value = Float(color.red)
        view.greenSlider.value = Float(color.green)
        view.blueSlider.value = Float(color.blue)
        view.redSliderLabel.text = "R \(color.red)"
        view.greenSliderLabel.text = "G \(color.green)"
        view.blueSliderLabel.text = "B \(color.blue)"
        self.view.backgroundColor = color.color
        red = color.red
        green = color.green
        blue = color.blue
    }
    
    private func setSessionValues(color: (color: String, red: Int, green: Int, blue: Int)) {
        UserSettings.sessionlastColor = "#\(colors())"
        UserSettings.sessionRed = color.red
        UserSettings.sessionGreen = color.green
        UserSettings.sessionBlue = color.blue
    }
}

// MARK: SlidersViewDelegate
extension ViewController: SlidersViewDelegate {
    func editingChanged(_ textField: UITextField, _ view: SlidersView) {
        if textField.text?.first != "#" {
            textField.text?.insert("#", at: textField.text!.startIndex)
        }
        if textField.text!.count > 7 {
            textField.deleteBackward()
        }
        textField.text = textField.text?.uppercased()
    }
    
    func editingDidEndOnExit(_ textField: UITextField, _ view: SlidersView) {
        if textField.text?.count != 7 {
            textField.text = UserSettings.sessionlastColor
        }
        if let color = UIColor().hexColor(hex: textField.text!) {
            setProperties(view: view, color: color)
            setSessionValues(color: (color: colors(), red: red, green: green, blue: blue))
        } else {
            textField.text = UserSettings.sessionlastColor
        }
        textField.endEditing(true)
    }
    
    func didChangeValue(_ slider: UISlider, _ view: SlidersView) {
        let value = Int(round(slider.value))
        switch slider.tintColor {
        case UIColor.red :
            red = value
            view.redSliderLabel.text = "R \(value)"
        case UIColor.green:
            green = value
            view.greenSliderLabel.text = "G \(value)"
        default:
            blue = value
            view.blueSliderLabel.text = "B \(value)"
        }
        
        self.view.backgroundColor = UIColor(red: red, green: green, blue: blue)
        view.hexValueLabel.text = "#\(colors())"

        setSessionValues(color: (color: colors(), red: red, green: green, blue: blue))
    }
}
