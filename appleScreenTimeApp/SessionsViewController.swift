//import UIKit
//
//class SessionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FocusTimeDelegate {
//
//    let tableView = UITableView()
//    var schedules: [(time: String, days: String)] = []
//    let rules = ["4 Apps Blocked"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.view.backgroundColor = .black
//        self.title = "Sessions"
//
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.frame = self.view.bounds
//        tableView.backgroundColor = .black
//        tableView.separatorColor = .gray
//        self.view.addSubview(tableView)
//
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSchedule))
//        self.navigationItem.rightBarButtonItem = addButton
//    }
//
//    @objc func addSchedule() {
//        let focusTimeVC = FocusTimeViewController()
//        focusTimeVC.delegate = self
//        self.navigationController?.pushViewController(focusTimeVC, animated: true)
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return section == 0 ? schedules.count : rules.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.textColor = .white
//        cell.backgroundColor = .black
//        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        if indexPath.section == 0 {
//            let schedule = schedules[indexPath.row]
//            cell.textLabel?.text = "\(schedule.time) - \(schedule.days)"
//        } else {
//            cell.textLabel?.text = rules[indexPath.row]
//        }
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    func didSaveFocusTime(startTime: Date, endTime: Date, selectedDays: [String]) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "h:mm a"
//
//        let startTimeString = dateFormatter.string(from: startTime)
//        let endTimeString = dateFormatter.string(from: endTime)
//        let timeString = "\(startTimeString) - \(endTimeString)"
//
//        let daysString = selectedDays.joined(separator: " ")
//
//        schedules.append((time: timeString, days: daysString))
//        tableView.reloadData()
//    }
//}


import UIKit

//class SessionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FocusTimeDelegate {
//    func didSaveFocusTime(startTime: Date, endTime: Date, selectedDays: [String]) {
//        //
//    }
//
//
//    let tableView = UITableView()
//    var schedules: [(time: String, days: String)] = []
//    var rules: [String] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.view.backgroundColor = .black
//        self.title = "Sessions"
//
//        setupTableView()
//        setupNavigationBar()
//    }
//
//    func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(ScheduleCell.self, forCellReuseIdentifier: "ScheduleCell")
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RuleCell")
//        tableView.frame = self.view.bounds
//        tableView.backgroundColor = .black
//        tableView.separatorStyle = .none
//        self.view.addSubview(tableView)
//    }
//
//    func setupNavigationBar() {
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSchedule))
//        self.navigationItem.rightBarButtonItem = addButton
//    }
//
//    @objc func addSchedule() {
//        let focusTimeVC = FocusTimeViewController()
//        focusTimeVC.delegate = self
//        self.navigationController?.pushViewController(focusTimeVC, animated: true)
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return section == 0 ? schedules.count : rules.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! ScheduleCell
//            let schedule = schedules[indexPath.row]
//            cell.configure(with: schedule)
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "RuleCell", for: indexPath)
//            cell.textLabel?.textColor = .white
//            cell.backgroundColor = .black
//            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//            cell.textLabel?.text = "\(rules.joined(separator: ", ")) Apps Blocked"
//            return cell
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        // Implement further actions if needed
//    }
//}

import UIKit

class SessionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FocusTimeDelegate {
    
    let tableView = UITableView()
    var schedules: [(time: String, days: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.title = "Sessions"
        
        loadSchedules()
        setupTableView()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: "ScheduleCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RuleCell")
        tableView.frame = self.view.bounds
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
    }
    
    func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSchedule))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addSchedule() {
        let focusTimeVC = FocusTimeViewController()
        focusTimeVC.delegate = self
        self.navigationController?.pushViewController(focusTimeVC, animated: true)
    }
    
    func didSaveFocusTime(startTime: Date, endTime: Date, selectedDays: [String]) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        let timeString = "\(timeFormatter.string(from: startTime)) - \(timeFormatter.string(from: endTime))"
        
        let daysString = selectedDays.joined(separator: ", ")
        
        schedules.append((time: timeString, days: daysString))
        saveSchedules()
        tableView.reloadData()
    }
    
    func saveSchedules() {
        let schedulesData = schedules.map { [$0.time, $0.days] }
        UserDefaults.standard.set(schedulesData, forKey: "schedules")
    }
    
    func loadSchedules() {
        if let savedSchedules = UserDefaults.standard.array(forKey: "schedules") as? [[String]] {
            schedules = savedSchedules.map { (time: $0[0], days: $0[1]) }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? schedules.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! ScheduleCell
            let schedule = schedules[indexPath.row]
            cell.configure(with: schedule)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RuleCell", for: indexPath)
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .black
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            let rules = DataStore.shared.selectedCategories
            cell.textLabel?.text = "\(rules.joined(separator: ", ")) Apps Blocked"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Implement further actions if needed
    }
}

class ScheduleCell: UITableViewCell {
    let timeLabel = UILabel()
    let daysLabel = UILabel()
    let iconView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .black
        
        iconView.image = UIImage(systemName: "clock")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)
        
        timeLabel.textColor = .white
        timeLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(timeLabel)
        
        daysLabel.textColor = .white
        daysLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        daysLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(daysLabel)
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            timeLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            
            daysLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            daysLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10)
        ])
    }
    
    func configure(with schedule: (time: String, days: String)) {
        timeLabel.text = schedule.time
        daysLabel.text = schedule.days
    }
}



//class ScheduleCell: UITableViewCell {
//    let timeLabel = UILabel()
//    let daysLabel = UILabel()
//    let iconView = UIImageView()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupViews() {
//        backgroundColor = .black
//
//        iconView.image = UIImage(systemName: "clock")?.withTintColor(.white, renderingMode: .alwaysOriginal)
//        iconView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(iconView)
//
//        timeLabel.textColor = .white
//        timeLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        timeLabel.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(timeLabel)
//
//        daysLabel.textColor = .white
//        daysLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
//        daysLabel.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(daysLabel)
//
//        NSLayoutConstraint.activate([
//            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            iconView.widthAnchor.constraint(equalToConstant: 24),
//            iconView.heightAnchor.constraint(equalToConstant: 24),
//
//            timeLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
//            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
//
//            daysLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
//            daysLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10)
//        ])
//    }
//
//    func configure(with schedule: (time: String, days: String)) {
//        timeLabel.text = schedule.time
//        daysLabel.text = schedule.days
//    }
//}
