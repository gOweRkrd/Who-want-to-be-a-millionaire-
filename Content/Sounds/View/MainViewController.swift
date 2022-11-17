import UIKit




class MainViewController: UIViewController {
    
//    var customView: headerView = {
//        let detailView = headerView()
//        return detailView
//    }()
    let headerView = UIView()
    let footer = UIView ()
    
    
   
    
    let myTableView = UITableView(frame: .zero, style: .plain)
    
    var items: Items = [
        Item(value: "500,000", coin: "1.8T"),
        Item(value: "250,000", coin: "1.6T"),
        Item(value: "100,000", coin: "1.4T"),
        Item(value: "50,000" ,coin: "1.2T"),
        Item(value: "25,000", coin: "1T"),
        Item(value: "15,000", coin: "900"),
        Item(value: "12,500", coin: "800"),
        Item(value: "10,000", coin: "700"),
        Item(value: "7,500", coin: "600"),
        Item(value: "5,000", coin: "500"),
        Item(value: "3,000", coin: "400"),
        Item(value: "2,000", coin: "300"),
        Item(value: "1,000", coin: "200"),
        Item(value: "500", coin: "100"),
        
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view = customView
        
        setupTableView()
        setupConstraints()
        
        
        
    }
    
    private func setupTableView() {
        myTableView.backgroundColor = UIColor(red: 67/255, green: 32/255, blue: 166/255, alpha: 1)
        myTableView.register(MyOwnCell.self, forCellReuseIdentifier: "CellID")
        myTableView.dataSource = self
        myTableView.delegate = self
        headerView.backgroundColor = .red
        footer.backgroundColor = .green
        self.view.addSubview(myTableView)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? MyOwnCell  else {
            fatalError("Creating cell from HotelsListViewController failed")
        }
        cell.setupContent(model: items[indexPath.row])
        
        return cell
    }
     
  
}

extension MainViewController: UITableViewDelegate {
}

// MARK: - Setup Constraints
extension MainViewController {
    
    private func setupConstraints() {
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        footer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerView)
        view.addSubview(myTableView)
        view.addSubview(footer)
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.bottomAnchor.constraint(equalTo: myTableView.bottomAnchor)
            
            
        ])
        
        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 150),
            myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            footer.topAnchor.constraint(equalTo: myTableView.bottomAnchor),
            footer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        
        
    }
}


























