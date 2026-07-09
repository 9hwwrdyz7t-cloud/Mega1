# Flezen Link Player

Flezen Link Player is a native SwiftUI iOS/iPadOS app for opening and playing media links supported by AVPlayer, including direct MP4, MP3, HLS `.m3u8`, and other compatible streams.

## Current features

- Paste a media URL and play it
- Save links to Favorites
- Recent playback history
- Full-screen player sheet
- Background audio mode configured in `Info.plist`
- AirPlay-friendly AVAudioSession configuration
- Local-only storage using `UserDefaults`
- Privacy manifest declaring no tracking and no collected data
- iPhone and iPad target support

## Open in Xcode

1. Clone or download this repository.
2. Open `FlezenLinkPlayer.xcodeproj` in Xcode.
3. Select the `FlezenLinkPlayer` scheme.
4. Open **Signing & Capabilities**.
5. Select your Apple Developer Team.
6. Build and run on an iPhone simulator or physical device.

## Signing note

The project uses automatic code signing, but `DEVELOPMENT_TEAM` is intentionally blank because each Apple Developer account has a private Team ID. Xcode will fill this when you select your team.

## App Store notes

Before App Store submission, complete these items in Xcode/App Store Connect:

- Set a unique bundle identifier you control.
- Add production app icons in `Assets.xcassets`.
- Test playback only with links you are legally authorized to access.
- Complete App Privacy answers in App Store Connect as local-only/no tracking unless you add analytics, accounts, ads, or server collection later.
- Confirm all sample streams, if added later, are legal and publicly playable.

## Important legal note

This app should only play media that the user owns, has permission to access, or is otherwise authorized to stream. Do not use it to bypass access controls, DRM, paywalls, or copyright restrictions.
