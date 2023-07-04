<!--

    Developer: Safa ULUDOĞAN
    Github: https://github.com/safauludogan/dio_nexus

-->

  

# Dio Nexus

[![Pub](https://img.shields.io/badge/pub-v0.0.1-blue)](https://pub.dev/packages/dio_nexus)   [![Pub](https://img.shields.io/badge/github-v0.0.1-blue%26logo%3Dgithub
)](https://github.com/safauludogan/dio_nexus)   


This library is a network management layer built on top of Dio.

- It automatically parses JSON data from the API and returns it to you as a model class.
- It converts generated exceptions into its own exception types and then returns these exceptions to you.
- It automatically sends a refresh token request using the refresh token.


## Getting started

  
### 🎉 Add dependency

 
You can use the command to add dio as a dependency with the latest stable version:

```dart

	$ dart pub add dio_nexus

```

Or you can manually add dio into the dependencies section in your pubspec.yaml:

```dart

	dio_nexus: '^replace-with-latest-version'

```

We start by initialize the library. Here you can give these features to your project by giving parameters such as `baseUrl`, `baseOptions` and `networkConnection`.

```dart

	import  'package:dio_nexus/dio_nexus.dart';
  
	IDioNexusManager networkManager =  DioNexusManager(
		printLogsDebugMode:  false,
		options:  BaseOptions(
			baseUrl:  "https://reqres.in/",
			headers: {'Content-type':  'application/json'},
			receiveTimeout:  const  Duration(seconds:  15),
			connectTimeout:  const  Duration(seconds:  15)));
		
```
 
### Model parser  

The `sendRequest` function in the library allows you to send requests to APIs. It takes generic types `R` and `T`.  

The `R` type specifies the return type of the request. Based on the `responseModel` provided within the library, the received data from the server is automatically parsed. You will receive the desired model within the `IResponseModel`. If an error occurs, the `IResponseModel` will not return a null `IErrorModel`, but instead provide the `statusCode`, `errorMessage`, and `NetworkExceptions`.


The `T` type indicates the model you want to parse. Your model class, representing the JSON data, should inherit from the `IDioNexusNetworkModel`. This allows the library to perform the parsing process.

  ```dart
  
	Future<IResponseModel<R?>?> sendRequest<T  extends  IDioNexusNetworkModel<T>, R>();
	
```


### Refresh token

Use refresh Token for expired token. In case of Authentication fail, the refresh token you have given will work.

```dart

	IDioNexusManager networkManager =  DioNexusManager(
		onRefreshFail: () {
			// Action to be taken when refresh Token fails.
			},
		onRefreshToken: (error, options) {
			// Write your refresh token code.
			},
		options:  BaseOptions(
			baseUrl:  "https://reqres.in/",
			headers: {NetworkHeadersEnum.ContentType.value:  "application/json"},
			receiveTimeout:  const  Duration(seconds:  15),
			connectTimeout:  const  Duration(seconds:  15)));
		
```

### Network connection
  
In situations where there is no internet connection, it displays a toast message to notify the user about the lack of internet. By clicking the `Retry` button, the user can send another request to the previous request.
  
`snackbarDuration` to set the visibility of the snackbar that appears.

```dart

	IDioNexusManager networkManager =  DioNexusManager(
		options:  BaseOptions(
			baseUrl:  "https://reqres.in/",
			headers: {NetworkHeadersEnum.ContentType.value:  "application/json"},
			receiveTimeout:  const  Duration(seconds:  15),
			connectTimeout:  const  Duration(seconds:  15)),
		networkConnection:  NetworkConnection(
		context: context,
		snackbarDuration:  const  Duration(seconds:  5)));
	
```
🎉 <b> Result:

<img src="https://raw.githubusercontent.com/safauludogan/dio_nexus/master/gif/no_internet_connection_gif.gif" width="338" height="600"/>

### Timeout request

When there is no response from the server or the server cannot be reached, a toast message is displayed by default, indicating a timeout. To use it, you only need to provide the constructor.

To utilize the functionality, simply instantiate the class by providing the necessary constructor:

```dart

	IDioNexusManager networkManager =  DioNexusManager(
		options:  BaseOptions(
			baseUrl:  "https://reqres.in/",
			headers: {NetworkHeadersEnum.ContentType.value:  "application/json"},
			receiveTimeout:  const  Duration(seconds:  15),
			connectTimeout:  const  Duration(seconds:  15)),
		timeoutToast:  TimeoutToast(showException:  true));
	
``` 

🎉 <b> Result:

<img src="https://github.com/safauludogan/dio_nexus/blob/master/gif/get_users_with_delay_gif.gif?raw=true" width="338" height="600"/>


### Custom interceptor

You can add your own custom interceptor.

```dart

	IDioNexusManager networkManager =  DioNexusManager(
		interceptor:  MyInterceptor(),
		options:  BaseOptions(
			baseUrl:  "https://reqres.in/",
			headers: {NetworkHeadersEnum.ContentType.value:  "application/json"},
			receiveTimeout:  const  Duration(seconds:  15),
			connectTimeout:  const  Duration(seconds:  15)));
			
```

## Examples

Return Users type:
  
  ```dart
  
	Future<IResponseModel<Users?>?> getUsers() async {
		IResponseModel<Users?>? response =  await nexusManager.sendRequest<Users, Users>(
			"api/users",
			requestType:  RequestType.GET,
			responseModel:  Users());
		return response;
	}

```  

Return Model type:

```dart

	Future<IResponseModel<List<Model>?>?> request() async {
		return  await nexusManager.sendRequest<Model, List<Model>>(
			'api/path',
			responseModel:  Model(),
			requestType:  RequestType.GET,
			queryParameters: {"key": value});
	}

```
<br>

When the server does not return JSON data as a response, this is handled by the `NexusModel`. Based on the data received from the server, you provide a `T` type. This `T` type can be String, int, bool, double, or dynamic. The response will be parsed and presented to you based on the T type you specify.  

```dart

	Future<IResponseModel<NexusModel<String>?>?> request() async {
		return  await nexusManager.sendRequest<NexusModel, NexusModel<String>>(
			'api/path',
			responseModel:  NexusModel<String>(),
			requestType:  RequestType.GET,
			queryParameters: {"key": value});
	}

```  

### Features
When initializing `DioNexusManager`, you can provide the following properties:

```dart

/// [onRefrestToken] when HttpStatus return unauthorized, you can call your refrestToken manager
Future  Function(DioException error, BaseOptions options)? onRefreshToken;

/// If [onRefrestToken] return fail, this metot will work.
///
/// Example: When refreshToken==fail, app will logout.
Function? onRefreshFail;

/// Set true to print requests or errors received.
final  bool? printLogsDebugMode;  

/// When no internet connection, request again to server
NetworkConnection? networkConnection;
  
/// Show toast when request or connection timeout.
/// Default value is false.
TimeoutToast? timeoutToast;
  
/// This variable is used for no internet connection.
/// You can modify this counter when initializing [DioNexusManager].
/// When your internet connection is lost, you can try re-requesting up to 5 times.
int maxNetworkTryCount;

/// Get all interceptors
Interceptors  get showInterceptors;

``` 

### Licence

[![Pub](https://img.shields.io/badge/licence-MIT-blue
)](https://github.com/LICENSE)   

Safa Uludoğan