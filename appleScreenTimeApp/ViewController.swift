import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    let hourglassImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "hourglass")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Allow Access to Screen Time"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Providing "App" access to Screen Time allows it to see your activity data, restrict content, and limit the usage of apps and websites.

        You can control which apps access your own in Screen Time Options in Settings.
        """
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let allowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Allow with Face ID", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(allowButtonTapped), for: .touchUpInside)
        return button
    }()

    let dontAllowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't Allow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dontAllowButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        
      
        // Set the navigation controller as the window's root view controller or present it modally

        setupViews()
    }
    private func navigateToPermissionViewController() {
        print("Inside navigateToPermissionViewController()") // Add this print statement for debugging
        let permissionViewController = PermissionViewController()
        navigationController?.pushViewController(permissionViewController, animated: true)
    }
    
    func promptForScreenTimeAccess() {
        // Create a black semi-transparent background view
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        // Present the background view
        self.view.addSubview(backgroundView)
        
        let alert = UIAlertController(
            title: "Screen Time Access Required",
            message: "This app needs Screen Time access to function properly. Please enable it in the Settings.",
            preferredStyle: .alert
        )
        
        // Customize the background color of the alert
        if let backgroundView = alert.view.subviews.first,
           let contentView = backgroundView.subviews.first {
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            contentView.backgroundColor = UIColor.black
        }
        
        // "Continue" action
        alert.addAction(UIAlertAction(title: "Continue", style: .default) { _ in
            // Remove the background view
            backgroundView.removeFromSuperview()
            
            // Perform any action needed when the user selects "Continue"
            // For example, moving to the next view controller
            self.navigateToPermissionViewController()
        })
        
        // "Don't Allow" action
        alert.addAction(UIAlertAction(title: "Don't Allow", style: .cancel) { _ in
            // Remove the background view
            backgroundView.removeFromSuperview()
        })

        // Use the current view controller to present the alert
        self.present(alert, animated: true, completion: nil)
    }

     



    private func setupViews() {
        view.addSubview(hourglassImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(allowButton)
        view.addSubview(dontAllowButton)

        NSLayoutConstraint.activate([
            hourglassImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hourglassImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            hourglassImageView.widthAnchor.constraint(equalToConstant: 60),
            hourglassImageView.heightAnchor.constraint(equalToConstant: 60),

            titleLabel.topAnchor.constraint(equalTo: hourglassImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            allowButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            allowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            allowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            allowButton.heightAnchor.constraint(equalToConstant: 50),

            dontAllowButton.topAnchor.constraint(equalTo: allowButton.bottomAnchor, constant: 10),
            dontAllowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dontAllowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dontAllowButton.heightAnchor.constraint(equalToConstant: 50),
            dontAllowButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc private func allowButtonTapped() {
        authenticateWithFaceID()
    }

    @objc private func dontAllowButtonTapped() {
        // Handle don't allow action
        print("Don't Allow tapped")
    }

    private func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to allow access to Screen Time") { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
//                        self.navigateToPermissionViewController()
                        self.promptForScreenTimeAccess()
                    } else {
                        // Handle failed authentication
                        let alert = UIAlertController(title: "Authentication Failed", message: "Face ID authentication failed. Please try again.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        } else {
            // Face ID/Touch ID not available
            let alert = UIAlertController(title: "Face ID Not Available", message: "Face ID is not available on this device.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

//    private func navigateToPermissionViewController() {
//        let permissionViewController = PermissionViewController()
//        navigationController?.pushViewController(permissionViewController, animated: true)
//    }


    private func navigateToNextViewController() {
        print("Navigating to next view controller...") // Add this for debugging
        let nextViewController = PermissionViewController() // Check if PermissionViewController is correctly initialized
        guard let navigationController = self.navigationController else {
            print("Navigation controller is nil.")
            return
        }
        navigationController.pushViewController(nextViewController, animated: true)
    }

}

 
