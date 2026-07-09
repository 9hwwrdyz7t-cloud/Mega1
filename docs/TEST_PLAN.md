# Flezen Link Player Test Plan

Use this plan after the app builds successfully in Xcode.

## Test environment

Record these before testing:

```text
Xcode version:
iOS version:
Device model:
Network: Wi-Fi / mobile data
Build number:
```

## Smoke tests

| Test | Expected result | Status |
| --- | --- | --- |
| Launch app | App opens quickly without crash | Not tested |
| Paste valid MP4 URL | Video starts playing | Not tested |
| Paste valid MP3 URL | Audio starts playing | Not tested |
| Paste valid HLS `.m3u8` URL | Stream starts playing | Not tested |
| Paste invalid URL | Friendly error appears | Not tested |
| Add favorite | Link appears in Favorites | Not tested |
| Delete favorite | Link is removed | Not tested |
| Play recent item | Recent link starts playing | Not tested |
| Clear recent history | Recent list is emptied | Not tested |
| Open full screen | Player opens in full screen sheet | Not tested |
| Rotate device | Layout remains usable | Not tested |
| Test iPad layout | App remains readable and responsive | Not tested |
| Send app to background during audio | Playback behavior matches expectation | Not tested |
| Try AirPlay | AirPlay route appears when available | Not tested |

## Edge cases

- Very long URL.
- URL with leading/trailing spaces.
- HTTP URL.
- HTTPS URL.
- Non-media webpage URL.
- Broken stream URL.
- Network disconnected during playback.
- App killed and reopened after saving favorites.

## App Store review risk checks

- The app must not advertise unauthorized streaming.
- Do not include copyrighted sample streams unless you have permission.
- Do not imply that Flezen links can bypass access controls.
- Explain clearly that users are responsible for only playing authorized media.
