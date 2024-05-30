import UIKit

class RulesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let categories = ["All Apps & Categories", "Social", "Games", "Entertainment", "Creativity", "Education", "Health & Fitness", "Information & Reading"]
    let categoryIcons = ["icon_all_apps", "icon_social", "icon_games", "icon_entertainment", "icon_creativity", "icon_education", "icon_health_fitness", "icon_information_reading"]
    
    var selectedCategories: [String] {
        get {
            return DataStore.shared.selectedCategories
        }
        set {
            DataStore.shared.selectedCategories = newValue
        }
    }

    let tableView = UITableView()
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = UIColor(red: 0.24, green: 0.31, blue: 0.86, alpha: 1.00)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        // Set up the title
        let titleLabel = UILabel()
        titleLabel.text = "Rules"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // Set up the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .black
        tableView.separatorColor = .darkGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])

        // Set up the save button
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.backgroundColor = .black
        cell.categoryLabel.text = categories[indexPath.row]
        cell.iconImageView.image = UIImage(named: categoryIcons[indexPath.row])
        
        let isSelected = selectedCategories.contains(categories[indexPath.row])
        cell.checkmarkImageView.image = isSelected ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        if let index = selectedCategories.firstIndex(of: selectedCategory) {
            selectedCategories.remove(at: index)
        } else {
            selectedCategories.append(selectedCategory)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @objc func saveButtonTapped() {
        // Save data but do not pop the view controller
        print("Selected categories saved: \(DataStore.shared.selectedCategories)")
    }
}

class CategoryCell: UITableViewCell {
    let categoryLabel = UILabel()
    let iconImageView = UIImageView()
    let checkmarkImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        categoryLabel.textColor = .white
        categoryLabel.font = UIFont.systemFont(ofSize: 18)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.tintColor = .white
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        checkmarkImageView.tintColor = .white
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(checkmarkImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            categoryLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15),
            categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            checkmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            checkmarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
