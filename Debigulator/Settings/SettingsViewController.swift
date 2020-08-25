//  Created by Geoff Pado on 4/27/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class SettingsViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(SceneViewController.dismissHelp))
        navigationItem.title = SettingsViewController.navigationTitle

        activeObserver = NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { [weak self] _ in
            self?.deselectSelectedRows()
        }

        sectionsObserver = NotificationCenter.default.addObserver(forName: SettingsContentProvider.didChangeContent, object: contentProvider, queue: .main) { [weak self] notification in
            guard let sectionIndexSet = (notification.userInfo?[SettingsContentProvider.sectionIndexSetKey] as? IndexSet) else {
                self?.tableView?.reloadData()
                return
            }

            self?.tableView?.reloadSections(sectionIndexSet, with: .automatic)
        }
    }

    override func loadView() {
        let tableView = SettingsTableView()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.register(SettingsHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: SettingsHeaderFooterView.identifier)
        view = tableView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectSelectedRows()
    }

    // MARK: User Interface

    @objc func displayAlert(_ sender: Any, event: AlertEvent) {
        present(event.alert, animated: true)
    }

    @objc func reloadSettingsSection() {
        tableView?.reloadData()
    }

    private func deselectSelectedRows() {
        guard let tableView = tableView,
          let selectedRowIndex = tableView.indexPathForSelectedRow
        else { return }

        tableView.deselectRow(at: selectedRowIndex, animated: true)
    }

    // MARK: Boilerplate

    private static let navigationTitle = NSLocalizedString("SettingsViewController.navigationTitle", comment: "Navigation title for the settings view controller")

    private var activeObserver: Any?
    private var sectionsObserver: Any?
    private lazy var contentProvider = SettingsContentProvider()
    private lazy var dataSource = SettingsTableViewDataSource(contentProvider: contentProvider)
    private var tableView: SettingsTableView? { return view as? SettingsTableView }

    deinit {
        activeObserver.map(NotificationCenter.default.removeObserver)
        sectionsObserver.map(NotificationCenter.default.removeObserver)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
