# Build and Signing Guide

Use this guide to open, sign, build, and run Flezen Link Player from Xcode.

## Requirements

- A Mac with Xcode installed.
- An Apple ID signed in to Xcode.
- An iPhone or iPad for real-device testing.
- Apple Developer Program membership is required for App Store distribution. A free Apple ID can usually run apps on a personal device for testing, but not submit to the App Store.

## 1. Clone the repository

```bash
git clone https://github.com/9hwwrdyz7t-cloud/Mega1.git
cd Mega1
open FlezenLinkPlayer.xcodeproj
```

If you downloaded the ZIP from GitHub instead, unzip it and open `FlezenLinkPlayer.xcodeproj`.

## 2. Select the project and target

1. In Xcode, click the blue project icon in the left sidebar.
2. Select the `FlezenLinkPlayer` target.
3. Open the **Signing & Capabilities** tab.

## 3. Set signing

1. Tick **Automatically manage signing**.
2. Select your Apple Developer Team.
3. Change the Bundle Identifier to one you control, for example:

```text
com.yourname.flezenlinkplayer
```

Do not leave a generic bundle ID if you plan to submit to the App Store.

## 4. Confirm background audio

The project already includes this in `Info.plist`:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>audio</string>
</array>
```

This supports background audio behavior for compatible playback. Picture in Picture also depends on using compatible video playback and device/iOS support.

## 5. Build and run

1. Select an iPhone simulator or a connected iPhone.
2. Press **Command + B** to build.
3. Press **Command + R** to run.

## 6. Test links

Test with media URLs you are legally authorized to play:

- Direct `.mp4`
- Direct `.mp3`
- HLS `.m3u8`
- Other AVPlayer-compatible network streams

## 7. Common fixes

### Signing error

Select your Apple Developer Team again, then change the Bundle Identifier to something unique.

### App installs but media does not play

Check that the URL is direct media or an AVPlayer-compatible stream. A normal web page URL may not play unless it directly points to media.

### Background playback does not work

Confirm the `UIBackgroundModes` audio entry is present and test on a real device. Some behavior may differ in Simulator.

### App Store upload error

Check Bundle Identifier, version number, build number, app icon, privacy answers, and signing certificate.
