import SwiftUI
import AVKit

struct RootView: View {
    @EnvironmentObject private var store: LibraryStore

    @State private var urlText = ""
    @State private var player: AVPlayer?
    @State private var errorMessage: String?
    @State private var showingPlayer = false

    var body: some View {
        NavigationStack {
            List {
                Section("Play media link") {
                    TextField("Paste MP4, MP3, HLS, or AVPlayer link", text: $urlText)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.URL)

                    Button {
                        play(urlText)
                    } label: {
                        Label("Play", systemImage: "play.circle.fill")
                    }
                    .disabled(urlText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

                    Button {
                        store.addFavorite(urlText)
                    } label: {
                        Label("Add to Favorites", systemImage: "star")
                    }
                    .disabled(urlText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }

                if let errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }

                if player != nil {
                    Section("Now Playing") {
                        VideoPlayer(player: player)
                            .frame(minHeight: 240)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                        Button {
                            showingPlayer = true
                        } label: {
                            Label("Open Full Screen", systemImage: "arrow.up.left.and.arrow.down.right")
                        }
                    }
                }

                if store.favorites.isEmpty == false {
                    Section("Favorites") {
                        ForEach(store.favorites) { item in
                            linkRow(item)
                        }
                        .onDelete { offsets in
                            offsets.map { store.favorites[$0] }.forEach(store.removeFavorite)
                        }
                    }
                }

                if store.recents.isEmpty == false {
                    Section("Recent") {
                        ForEach(store.recents) { item in
                            linkRow(item)
                        }

                        Button("Clear Recent History", role: .destructive) {
                            store.clearRecents()
                        }
                    }
                }
            }
            .navigationTitle("Flezen Link Player")
            .sheet(isPresented: $showingPlayer) {
                NavigationStack {
                    Group {
                        if let player {
                            VideoPlayer(player: player)
                                .ignoresSafeArea()
                        } else {
                            ContentUnavailableView("No Media Loaded", systemImage: "play.slash")
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Done") {
                                showingPlayer = false
                            }
                        }
                    }
                }
            }
            .onChange(of: store.incomingURL) { _, newValue in
                guard let newValue else { return }
                urlText = newValue.absoluteString
                play(newValue.absoluteString)
            }
        }
    }

    private func linkRow(_ item: MediaLink) -> some View {
        Button {
            urlText = item.urlString
            play(item.urlString)
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                Text(item.urlString)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
    }

    private func play(_ value: String) {
        let cleaned = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard store.isValidURL(cleaned), let url = URL(string: cleaned) else {
            errorMessage = "Please enter a valid media URL. Supported links include direct MP4, MP3, HLS .m3u8, and other AVPlayer-compatible streams."
            return
        }

        errorMessage = nil
        let newPlayer = AVPlayer(url: url)
        player = newPlayer
        store.addRecent(cleaned)
        newPlayer.play()
    }
}

#Preview {
    RootView()
        .environmentObject(LibraryStore())
}
