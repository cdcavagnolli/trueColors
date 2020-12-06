import UIKit

protocol SlidersViewDelegate: AnyObject {
    func didChangeValue(_ slider: UISlider, _ view: SlidersView)
    func editingChanged(_ textField: UITextField, _ view: SlidersView)
    func editingDidEndOnExit(_ textField: UITextField, _ view: SlidersView)
}

class SlidersView: UIView {
    
    weak var delegate: SlidersViewDelegate?
    
    private var red = UserSettings.red
    private var green = UserSettings.green
    private var blue = UserSettings.blue
    
    let redSlider = UISlider()
    let greenSlider = UISlider()
    let blueSlider = UISlider()
    
    let hexValueLabel = UITextField()
    let redSliderLabel = UILabel()
    let greenSliderLabel = UILabel()
    let blueSliderLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let color = UserSettings.lastColor
        UserSettings.sessionlastColor = color
        hexValueLabel.text = color
        hexValueLabel.font = .systemFont(ofSize: 35, weight: .bold)
        hexValueLabel.textAlignment = .center
        hexValueLabel.textColor = .black
        hexValueLabel.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        hexValueLabel.addTarget(self, action: #selector(editingDidEndOnExit(_:)), for: .editingDidEndOnExit)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let labels = [redSliderLabel, greenSliderLabel, blueSliderLabel]
        labels.forEach({
            $0.font = .systemFont(ofSize: 15, weight: .semibold)
            $0.textColor = .black
            switch $0 {
            case redSliderLabel: $0.text = "R \(red)"
            case greenSliderLabel: $0.text = "G \(green)"
            default: $0.text = "B \(blue)"
            }
        })
        
        let sliders = [redSlider, greenSlider, blueSlider]
        sliders.forEach({
            $0.addTarget(self, action: #selector(didChangeValue(_:)), for: .valueChanged)
            $0.maximumValue = 255
            $0.minimumValue = 0
            $0.minimumTrackTintColor = .black
            $0.maximumTrackTintColor = .black
            $0.thumbTintColor = .black
            switch $0 {
            case redSlider:
                $0.tintColor = .red
                stackView.addArrangedSubview(hexValueLabel)
                stackView.addArrangedSubview(redSliderLabel)
                $0.value = Float(red)
            case greenSlider:
                $0.tintColor = .green
                stackView.addArrangedSubview(greenSliderLabel)
                $0.value = Float(green)
            default:
                $0.tintColor = .blue
                stackView.addArrangedSubview(blueSliderLabel)
                $0.value = Float(blue)
            }
            stackView.addArrangedSubview($0)
        })
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func didChangeValue(_ sender: UISlider) {
        delegate?.didChangeValue(sender, self)
    }
    
    @objc private func editingChanged(_ sender: UITextField) {
        delegate?.editingChanged(sender, self)
    }
    
    @objc private func editingDidEndOnExit(_ sender: UITextField) {
        delegate?.editingDidEndOnExit(sender, self)
    }
}


