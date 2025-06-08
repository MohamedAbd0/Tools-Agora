# Agora Token Generator - Flutter Web Example

A comprehensive Flutter web application that demonstrates the Dart implementation of Agora token generation. This example provides an interactive interface for generating various types of Agora tokens including RTC tokens, RTM tokens, and multi-service tokens.

## Features

- **Interactive Web Interface**: User-friendly form-based interface for token generation
- **Multiple Token Types**: Support for all token types:
  - RTC Token with UID (numeric user ID)
  - RTC Token with Account (string user account)
  - RTC Token with UID=0 (wildcard user)
  - RTM Token (Real-time Messaging)
  - Multi-Service Token (combined RTC + RTM)
- **Copy to Clipboard**: Easy token copying with one-click functionality
- **Pre-filled Test Data**: Default test credentials for quick testing
- **Token Information**: Built-in help explaining different token types
- **Responsive Design**: Works on desktop and mobile browsers

## Prerequisites

- Flutter SDK (3.6.1 or higher)
- Web browser with JavaScript enabled
- Agora App ID and App Certificate (for generating real tokens)

## Quick Start

### 1. Install Dependencies

```bash
cd /path/to/dart/example
flutter pub get
```

### 2. Run in Development Mode

```bash
flutter run -d web-server --web-port 8080
```

The app will be available at `http://localhost:8080`

### 3. Build for Production

```bash
flutter build web
```

Serve the built files from `build/web/` directory:

```bash
cd build/web
python3 -m http.server 8080
```

## Usage

### Configuration

1. **App ID**: Enter your Agora project's App ID
2. **App Certificate**: Enter your Agora project's App Certificate (keep this secret!)
3. **Channel Name**: The name of the channel/room
4. **UID**: Numeric user identifier (use 0 for wildcard)
5. **User Account**: String-based user identifier
6. **Expire Time**: Token expiration time in seconds

### Generating Tokens

1. Fill in the configuration form with your Agora credentials
2. Click "Generate Tokens" to create all token types
3. Select the desired token type from the dropdown
4. Click the copy icon to copy the token to clipboard

### Token Types Explained

- **RTC Token (UID)**: For video/audio calls with numeric user ID
- **RTC Token (Account)**: For video/audio calls with string user account
- **RTC Token (UID=0)**: For joining channels without specific user ID
- **RTM Token**: For real-time messaging features
- **Multi-Service Token**: Combined token supporting both RTC and RTM services

## Default Test Credentials

The app comes with pre-filled test credentials for quick testing:

- **App ID**: `970CA35de60c44645bbae8a215061b33`
- **App Certificate**: `5CFd2fd1755d40ecb72977518be15d3b`
- **Channel**: `testChannel`
- **UID**: `12345`
- **User Account**: `testUser`
- **Expire Time**: `3600` seconds (1 hour)

> **Note**: These are test credentials. Replace with your actual Agora project credentials for production use.

## Security Considerations

- **Never expose App Certificate**: The App Certificate should be kept secret and only used on your backend server
- **Token Generation Location**: In production, tokens should be generated on your backend server, not in client applications
- **HTTPS**: Always use HTTPS in production to protect sensitive data
- **Token Expiration**: Set appropriate expiration times for tokens based on your use case

## Project Structure

```
example/
├── lib/
│   └── main.dart           # Main Flutter web application
├── web/                    # Web-specific assets
├── pubspec.yaml           # Dependencies and configuration
└── README.md              # This file
```

## Development

### Code Structure

The main application (`lib/main.dart`) is organized into:

- **AgoraTokenGeneratorApp**: Root application widget
- **TokenGeneratorPage**: Main page with token generation interface
- **\_TokenGeneratorPageState**: State management for the page

### Key Components

- **Configuration Form**: Input fields for Agora credentials and parameters
- **Token Generation**: Uses the `agora_token_generator` package
- **Token Display**: Dropdown selection and display area with copy functionality
- **Information Panel**: Help text explaining different token types

### Adding New Features

To extend the example:

1. Add new form fields in the `_buildInputField` method calls
2. Implement token generation logic in `_generateTokens()`
3. Update the UI in the `build()` method
4. Add new token types to the `_tokenTypes` list

## Troubleshooting

### Common Issues

1. **Build Failures**: Run `flutter clean && flutter pub get`
2. **Import Errors**: Ensure the local dependency path is correct in `pubspec.yaml`
3. **Web Server Issues**: Try different ports if 8080 is in use
4. **Token Generation Errors**: Verify App ID and App Certificate are correct

### Debug Mode

For debugging, you can add print statements or use Flutter's debugging tools:

```bash
flutter run -d web-server --web-port 8080 --debug
```

## Related Documentation

- [Agora Token Documentation](https://docs.agora.io/en/video-calling/reference/authentication-workflow)
- [Flutter Web Documentation](https://docs.flutter.dev/platform-integration/web)
- [Dart Package Documentation](../README.md)
