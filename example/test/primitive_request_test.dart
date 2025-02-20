import 'package:dio_nexus/dio_nexus.dart';
import 'package:dio_nexus/src/model/error_model.dart';
import 'package:dio_nexus/src/model/response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<IDioNexusManager>()])
import 'primitive_request_test.mocks.dart';

void main() {
  late MockIDioNexusManager mockManager;

  setUp(() {
    mockManager = MockIDioNexusManager();
  });

  group('Primitive Request Tests', () {
    test('should return String response successfully', () async {
      // Arrange
      const expectedResponse = 'test response';
      when(mockManager.sendPrimitiveRequest<String>(
        any,
        requestType: anyNamed('requestType'),
      )).thenAnswer((_) async => ResponseModel<String>(expectedResponse, null));

      // Act
      final response = await mockManager.sendPrimitiveRequest<String>(
        'api/string',
        requestType: RequestType.GET,
      );

      // Assert
      expect(response?.data, equals(expectedResponse));
      expect(response?.errorModel, isNull);
    });

    test('should return List<int> response successfully', () async {
      // Arrange
      final expectedResponse = [1, 2, 3, 4, 5];
      when(mockManager.sendPrimitiveRequest<List<int>>(
        any,
        requestType: anyNamed('requestType'),
      )).thenAnswer(
          (_) async => ResponseModel<List<int>>(expectedResponse, null));

      // Act
      final response = await mockManager.sendPrimitiveRequest<List<int>>(
        'api/numbers',
        requestType: RequestType.GET,
      );

      // Assert
      expect(response?.data, equals(expectedResponse));
      expect(response?.errorModel, isNull);
    });

    test('should return bool response successfully', () async {
      // Arrange
      const expectedResponse = true;
      when(mockManager.sendPrimitiveRequest<bool>(
        any,
        requestType: anyNamed('requestType'),
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => ResponseModel<bool>(expectedResponse, null));

      // Act
      final response = await mockManager.sendPrimitiveRequest<bool>(
        'api/status',
        requestType: RequestType.GET,
        queryParameters: {'id': 123},
      );

      // Assert
      expect(response?.data, equals(expectedResponse));
      expect(response?.errorModel, isNull);
    });

    test('should handle error response', () async {
      // Arrange
      final errorModel = ErrorModel(
        400,
        'Bad Request',
        const NetworkExceptions.badRequest('Invalid request'),
      );

      when(mockManager.sendPrimitiveRequest<String>(
        any,
        requestType: anyNamed('requestType'),
      )).thenAnswer((_) async => ResponseModel<String>(null, errorModel));

      // Act
      final response = await mockManager.sendPrimitiveRequest<String>(
        'api/error',
        requestType: RequestType.GET,
      );

      // Assert
      expect(response?.data, isNull);
      expect(response?.errorModel?.statusCode, equals(400));
      expect(response?.errorModel?.errorMessage, equals('Bad Request'));
      expect(
        response?.errorModel?.networkException,
        isA<NetworkExceptions>(),
      );
    });
  });
}
