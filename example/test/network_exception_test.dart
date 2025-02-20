import 'package:dio_nexus/dio_nexus.dart';
import 'package:dio_nexus/src/model/error_model.dart';
import 'package:dio_nexus/src/model/response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<IDioNexusManager>()])
import 'network_exception_test.mocks.dart';

// Test model that implements IDioNexusNetworkModel
class TestModel implements IDioNexusNetworkModel<TestModel> {
  final String data;

  TestModel([this.data = '']);

  @override
  TestModel fromJson(Map<String, dynamic> json) {
    return TestModel(json['data'] as String? ?? '');
  }

  @override
  Map<String, dynamic> toJson() {
    return {'data': data};
  }
}

void main() {
  late MockIDioNexusManager mockManager;

  setUp(() {
    mockManager = MockIDioNexusManager();
  });

  group('Network Exception Tests', () {
    test('should handle timeout exception', () async {
      // Arrange
      final errorModel = ErrorModel(
        408,
        'Request Timeout',
        const NetworkExceptions.requestTimeout(),
      );

      when(mockManager.sendRequest<TestModel, TestModel>(
        any,
        requestType: anyNamed('requestType'),
        responseModel: anyNamed('responseModel'),
      )).thenAnswer((_) async => ResponseModel<TestModel>(null, errorModel));

      // Act
      final response = await mockManager.sendRequest<TestModel, TestModel>(
        'api/test',
        requestType: RequestType.GET,
        responseModel: TestModel(),
      );

      // Assert
      expect(response?.data, isNull);
      expect(response?.errorModel?.statusCode, equals(408));
      expect(
        response?.errorModel?.networkException,
        isA<NetworkExceptions>(),
      );
      expect(
        NetworkExceptions.getErrorMessage(
          response?.errorModel?.networkException ??
              const NetworkExceptions.unexpectedError(),
        ),
        equals('Connection failed. Weak internet connection'),
      );
    });

    test('should handle unauthorized exception', () async {
      // Arrange
      final errorModel = ErrorModel(
        401,
        'Unauthorized',
        const NetworkExceptions.unauthorizedRequest('Token expired'),
      );

      when(mockManager.sendRequest<TestModel, TestModel>(
        any,
        requestType: anyNamed('requestType'),
        responseModel: anyNamed('responseModel'),
      )).thenAnswer((_) async => ResponseModel<TestModel>(null, errorModel));

      // Act
      final response = await mockManager.sendRequest<TestModel, TestModel>(
        'api/test',
        requestType: RequestType.GET,
        responseModel: TestModel(),
      );

      // Assert
      expect(response?.data, isNull);
      expect(response?.errorModel?.statusCode, equals(401));
      expect(
        NetworkExceptions.getErrorMessage(
          response?.errorModel?.networkException ??
              const NetworkExceptions.unexpectedError(),
        ),
        equals('Token expired'),
      );
    });

    test('should handle no internet connection', () async {
      // Arrange
      final errorModel = ErrorModel(
        0,
        'No Internet Connection',
        const NetworkExceptions.noInternetConnection(),
      );

      when(mockManager.sendRequest<TestModel, TestModel>(
        any,
        requestType: anyNamed('requestType'),
        responseModel: anyNamed('responseModel'),
      )).thenAnswer((_) async => ResponseModel<TestModel>(null, errorModel));

      // Act
      final response = await mockManager.sendRequest<TestModel, TestModel>(
        'api/test',
        requestType: RequestType.GET,
        responseModel: TestModel(),
      );

      // Assert
      expect(response?.data, isNull);
      expect(response?.errorModel?.statusCode, equals(0));
      expect(
        NetworkExceptions.getErrorMessage(
          response?.errorModel?.networkException ??
              const NetworkExceptions.unexpectedError(),
        ),
        equals('No internet connection'),
      );
    });

    test('should handle bad request', () async {
      // Arrange
      final errorModel = ErrorModel(
        400,
        'Bad Request',
        const NetworkExceptions.badRequest('Invalid parameters'),
      );

      when(mockManager.sendRequest<TestModel, TestModel>(
        any,
        requestType: anyNamed('requestType'),
        responseModel: anyNamed('responseModel'),
      )).thenAnswer((_) async => ResponseModel<TestModel>(null, errorModel));

      // Act
      final response = await mockManager.sendRequest<TestModel, TestModel>(
        'api/test',
        requestType: RequestType.GET,
        responseModel: TestModel(),
      );

      // Assert
      expect(response?.data, isNull);
      expect(response?.errorModel?.statusCode, equals(400));
      expect(
        NetworkExceptions.getErrorMessage(
          response?.errorModel?.networkException ??
              const NetworkExceptions.unexpectedError(),
        ),
        equals('Invalid parameters'),
      );
    });
  });
}
