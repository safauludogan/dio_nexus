## 0.3.3

### Improvements

- Enhanced NetworkConnection with required BuildContext parameter
- Added custom logger with multiple log levels (Verbose, Debug, Info, Warning, Error, WTF)
- Improved SnackBar handling for network connectivity feedback
- Added retry functionality with timeout for network requests

### Dependencies

- Updated dio to ^5.8.0+1
- Added logger ^1.1.0 for better debugging

## 0.3.2

### Breaking Changes

- Removed NexusModel class - Use primitive request handling instead for non-JSON responses

## 0.3.1

### Testing

- Added comprehensive unit test suite
  - Primitive request handling tests
  - Network exception handling tests
  - Localization and translation tests
- Added test infrastructure with mockito
- Added test models and utilities
- Fixed delegate initialization issues in tests

## 0.3.0

### New Features

- Added comprehensive NetworkExceptions handling
- Added ResultState for network request state management
- Implemented TimeoutToast for connection timeout feedback
- Added NetworkConnection for internet connectivity monitoring
- Added NetworkModelParser for standardized response parsing

### Improvements

- Enhanced error handling with ErrorModel
- Improved response handling with ResponseModel
- Added InternetConnectionManager for better connectivity checks
- Enhanced internationalization support
- Added comprehensive interfaces (IResponseModel, IErrorModel, IDioNexusNetworkModel)

### Documentation

- Added detailed example implementation
- Added comprehensive documentation for all components
- Added usage examples with BLoC pattern

### Dependencies

- Updated dio to ^5.8.0+1
- Updated connectivity_plus to ^6.1.3
- Updated other utility packages

## 0.2.2

- Some bugs fixed

## 0.2.1

- Updated some packages

## 0.2.0

- Updated some packages
- very_good_analysis added

## 0.1.0

- Added Locale (en_US, tr_TR)
