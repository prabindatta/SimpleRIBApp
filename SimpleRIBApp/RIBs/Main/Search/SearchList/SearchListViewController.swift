//  Copyright © T-Mobile USA Inc. All rights reserved.

import UIKit
import RIBs
import SimpleRIBCore

protocol SearchListPresentableListener: AnyObject {
    func searchEvents(with query: String)
    func didSelectItem(_ event: Event)
}

final class SearchListViewController: UIViewController, SearchListPresentable, SearchListViewControllable {

    weak var listener: SearchListPresentableListener?
    private var searchTextField: UITextField!
    private let tableViewCellId = "SearchListViewControllerItemCellId"
    private var events: [Event] = []
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        searchBar.layer.borderColor = #colorLiteral(red: 0.7490196078, green: 0.3529411765, blue: 0.9490196078, alpha: 1).cgColor
        searchBar.layer.borderWidth = 1
        return searchBar
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.3529411765, blue: 0.9490196078, alpha: 1)
        self.title = "Search Events"
        makeSearchBar()
        makeTableView()
        listener?.searchEvents(with: "")
    }
    
    func makeSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        setupTextField()
        setUpToolBar()
    }
    
    func setupTextField() {
        searchTextField = searchBar.searchTextField
        searchTextField.textAlignment = .left
        searchTextField.textColor = #colorLiteral(red: 0.7490196078, green: 0.3529411765, blue: 0.9490196078, alpha: 1)
        searchTextField.placeholder = "Search for City"
        searchTextField.clearButtonMode = .whileEditing
    }
    
    func setUpToolBar() {
        let toolBar = UIToolbar.accessoryToolBar(with: self, title: "Done", action: #selector(hideKeyboard))
        searchTextField.inputAccessoryView = toolBar
    }
    
    func makeTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = CGFloat(92.0)
        tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: tableViewCellId)
    }
}

extension SearchListViewController {
    
    @objc func hideKeyboard() {
        searchTextField.resignFirstResponder()
    }
}

extension SearchListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if let oldSearchQuery = searchBar.text,
           let newRange = Range(range, in: oldSearchQuery) {
            let newSearchQuery = oldSearchQuery.replacingCharacters(in: newRange, with: text)
            print("newSearchQuery \(newSearchQuery)")
            listener?.searchEvents(with: newSearchQuery)
        }
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      searchBar.text = nil
      searchBar.resignFirstResponder()
    }
}

// MARK: - ListPresentable

extension SearchListViewController {
    
    func showSearchResult(_ events: [Event]) {
        self.events = events

        tableView.reloadData()
    }
}

extension SearchListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        listener?.didSelectItem(events[indexPath.row])
    }
}

extension SearchListViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId) else { fatalError() }
        guard let itemCell = cell as? ItemCell else { fatalError() }

        itemCell.display(event: events[indexPath.row])

        return cell
    }
}

