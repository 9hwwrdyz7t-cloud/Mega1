import Foundation

struct MediaLink: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var urlString: String
    var createdAt: Date

    init(id: UUID = UUID(), title: String? = nil, urlString: String, createdAt: Date = Date()) {
        self.id = id
        self.urlString = urlString
        self.title = title?.isEmpty == false ? title! : URL(string: urlString)?.host ?? "Media Link"
        self.createdAt = createdAt
    }
}

@MainActor
final class LibraryStore: ObservableObject {
    @Published var favorites: [MediaLink] = [] {
        didSet { save(favorites, key: favoritesKey) }
    }

    @Published var recents: [MediaLink] = [] {
        didSet { save(recents, key: recentsKey) }
    }

    @Published var incomingURL: URL?

    private let favoritesKey = "flezen.favorites"
    private let recentsKey = "flezen.recents"

    init() {
        favorites = load(key: favoritesKey)
        recents = load(key: recentsKey)
    }

    func handleIncomingURL(_ url: URL) {
        incomingURL = url
        addRecent(url.absoluteString)
    }

    func addFavorite(_ urlString: String) {
        let cleaned = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        guard isValidURL(cleaned), favorites.contains(where: { $0.urlString == cleaned }) == false else { return }
        favorites.insert(MediaLink(urlString: cleaned), at: 0)
    }

    func removeFavorite(_ item: MediaLink) {
        favorites.removeAll { $0.id == item.id }
    }

    func addRecent(_ urlString: String) {
        let cleaned = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        guard isValidURL(cleaned) else { return }
        recents.removeAll { $0.urlString == cleaned }
        recents.insert(MediaLink(urlString: cleaned), at: 0)
        recents = Array(recents.prefix(20))
    }

    func clearRecents() {
        recents.removeAll()
    }

    func isValidURL(_ value: String) -> Bool {
        guard let url = URL(string: value), let scheme = url.scheme?.lowercased() else { return false }
        return ["http", "https", "file"].contains(scheme)
    }

    private func save(_ items: [MediaLink], key: String) {
        guard let data = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }

    private func load(key: String) -> [MediaLink] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([MediaLink].self, from: data) else {
            return []
        }
        return decoded
    }
}
