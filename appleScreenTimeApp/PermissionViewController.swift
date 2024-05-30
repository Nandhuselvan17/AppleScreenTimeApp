import UIKit
import FamilyControls
import DeviceActivity

class PermissionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color
        view.backgroundColor = .black
        
        // Create and set up the title label
        let titleLabel = UILabel()
        titleLabel.text = "Sessions"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Create and set up the schedules label
        let schedulesLabel = UILabel()
        schedulesLabel.text = "Schedules"
        schedulesLabel.font = UIFont.systemFont(ofSize: 20)
        schedulesLabel.textColor = .white
        schedulesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(schedulesLabel)
        
        // Create and set up the "Add Schedule" button
        let addScheduleButton = UIButton(type: .system)
        addScheduleButton.setTitle("Add Schedule", for: .normal)
        addScheduleButton.setTitleColor(.white, for: .normal)
        addScheduleButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        addScheduleButton.layer.cornerRadius = 10
        addScheduleButton.backgroundColor = UIColor(hex: "#9B5BEF")
        addScheduleButton.layer.masksToBounds = true
        addScheduleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addScheduleButton)
        
        // Create and set up the rules label
        let rulesLabel = UILabel()
        rulesLabel.text = "Rules"
        rulesLabel.font = UIFont.systemFont(ofSize: 20)
        rulesLabel.textColor = .white
        rulesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rulesLabel)
        
        // Create and set up the "Select Distracting Apps" button
        let selectAppsButton = UIButton(type: .system)
        selectAppsButton.setTitle("Select Distracting Apps", for: .normal)
        selectAppsButton.setTitleColor(.white, for: .normal)
        selectAppsButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        selectAppsButton.backgroundColor = UIColor(hex: "#9B5BEF")
        selectAppsButton.layer.cornerRadius = 10
        selectAppsButton.translatesAutoresizingMaskIntoConstraints = false
        
        addScheduleButton.addTarget(self, action: #selector(navigateToFocusTimeViewController), for: .touchUpInside)
        selectAppsButton.addTarget(self, action: #selector(navigateToRulesVc), for: .touchUpInside)
        view.addSubview(selectAppsButton)
        
        // Add gradient backgrounds to the buttons
        addGradientToButton(button: addScheduleButton, colors: [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor])
        addGradientToButton(button: selectAppsButton, colors: [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor])
        
        // Add constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            schedulesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            schedulesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addScheduleButton.topAnchor.constraint(equalTo: schedulesLabel.bottomAnchor, constant: 10),
            addScheduleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addScheduleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addScheduleButton.heightAnchor.constraint(equalToConstant: 50),
            rulesLabel.topAnchor.constraint(equalTo: addScheduleButton.bottomAnchor, constant: 30),
            rulesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectAppsButton.topAnchor.constraint(equalTo: rulesLabel.bottomAnchor, constant: 10),
            selectAppsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectAppsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selectAppsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Adjust the title alignment to the right
        addScheduleButton.contentHorizontalAlignment = .left
        addScheduleButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        selectAppsButton.contentHorizontalAlignment = .left
        selectAppsButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    @objc private func navigateToFocusTimeViewController() {
           let focusTimeViewController = FocusTimeViewController()
           navigationController?.pushViewController(focusTimeViewController, animated: true)
       }
    @objc private func navigateToRulesVc() {
           let focusTimeViewController = RulesViewController()
           navigationController?.pushViewController(focusTimeViewController, animated: true)
       }
    
   
    private func addGradientToButton(button: UIButton, colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        button.layer.insertSublayer(gradientLayer, at: 0)
    }
}

 

extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        assert(hexString.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
