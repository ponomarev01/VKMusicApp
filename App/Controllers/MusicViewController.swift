import UIKit
import VK_ios_sdk

class MusicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    private var tracks: [VKAudio] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadTracks()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(MusicCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadTracks() {
        VKApi.request(withMethod: "audio.get", parameters: ["count": "50"]).execute(
            resultBlock: { [weak self] response in
                guard let json = response?.json as? [String: Any],
                      let items = json["items"] as? [[String: Any]] else { return }
                self?.tracks = items.compactMap { VKAudio(json: $0) }
                self?.tableView.reloadData()
            },
            errorBlock: { error in
                print("Ошибка: \(error?.localizedDescription ?? "")")
            }
        )
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MusicCell
        cell.configure(with: tracks[indexPath.row])
        return cell
    }
}
