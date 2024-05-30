import UIKit

protocol FocusTimeDelegate: AnyObject {
    func didSaveFocusTime(startTime: Date, endTime: Date, selectedDays: [String])
}

class FocusTimeViewController: UIViewController {

    let startTimePicker = UIDatePicker()
    let endTimePicker = UIDatePicker()
    let daysStackView = UIStackView()
    let saveButton = UIButton(type: .system)
    
    var selectedDays = Set<String>()
    weak var delegate: FocusTimeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.title = "Focus Time"
        
        setupTimePickers()
        setupDaysButtons()
        setupSaveButton()
    }

    func setupTimePickers() {
        startTimePicker.datePickerMode = .time
        startTimePicker.tintColor = .white
        startTimePicker.backgroundColor = .darkGray
        startTimePicker.setValue(UIColor.white, forKey: "textColor")
        
        endTimePicker.datePickerMode = .time
        endTimePicker.tintColor = .white
        endTimePicker.backgroundColor = .darkGray
        endTimePicker.setValue(UIColor.white, forKey: "textColor")
        
        self.view.addSubview(startTimePicker)
        self.view.addSubview(endTimePicker)
        
        startTimePicker.translatesAutoresizingMaskIntoConstraints = false
        endTimePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startTimePicker.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            startTimePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            startTimePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            endTimePicker.topAnchor.constraint(equalTo: startTimePicker.bottomAnchor, constant: 20),
            endTimePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            endTimePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
    }

    func setupDaysButtons() {
        let days = ["M", "T", "W", "T", "F", "S", "S"]
        
        daysStackView.axis = .horizontal
        daysStackView.distribution = .fillEqually
        daysStackView.spacing = 10
        self.view.addSubview(daysStackView)
        
        daysStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            daysStackView.topAnchor.constraint(equalTo: endTimePicker.bottomAnchor, constant: 20),
            daysStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            daysStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        for day in days {
            let button = UIButton(type: .system)
            button.setTitle(day, for: .normal)
            button.backgroundColor = .darkGray
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 5
            button.addTarget(self, action: #selector(dayButtonTapped(_:)), for: .touchUpInside)
            daysStackView.addArrangedSubview(button)
        }
    }

    @objc func dayButtonTapped(_ sender: UIButton) {
        guard let day = sender.title(for: .normal) else { return }
        
        if selectedDays.contains(day) {
            selectedDays.remove(day)
            sender.backgroundColor = .darkGray
        } else {
            selectedDays.insert(day)
            sender.backgroundColor = .systemBlue
        }
    }

    func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = UIColor(red: 85/255, green: 98/255, blue: 255/255, alpha: 1)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        self.view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: daysStackView.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func saveButtonTapped() {
        let startTime = startTimePicker.date
        let endTime = endTimePicker.date
        let selectedDaysArray = Array(selectedDays)
        
        delegate?.didSaveFocusTime(startTime: startTime, endTime: endTime, selectedDays: selectedDaysArray)
        
        // Initialize and configure a new SessionsViewController
        let sessionsViewController = SessionsViewController()
        sessionsViewController.schedules.append((time: formatTimeRange(startTime: startTime, endTime: endTime), days: formatDays(selectedDaysArray)))
        
        navigationController?.pushViewController(sessionsViewController, animated: true)
    }

    func formatTimeRange(startTime: Date, endTime: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let startTimeString = dateFormatter.string(from: startTime)
        let endTimeString = dateFormatter.string(from: endTime)
        return "\(startTimeString) - \(endTimeString)"
    }

    func formatDays(_ days: [String]) -> String {
        return days.joined(separator: " ")
    }

}
