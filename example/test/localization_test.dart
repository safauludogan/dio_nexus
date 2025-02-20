import 'package:dio_nexus/dio_nexus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<IDioNexusManager>()])
import 'localization_test.mocks.dart';

void main() {
  late MockIDioNexusManager mockManager;

  setUp(() {
    mockManager = MockIDioNexusManager();
  });

  group('Localization Tests', () {
    test('should use English translations by default', () async {
      // Arrange
      when(mockManager.locale).thenReturn(const Locale('en'));
      await NexusLanguage.languageLoad(const Locale('en'));

      // Act & Assert
      expect(NexusLanguage.getLang.networkConnectionNoInternetConnection,
          equals('No internet connection'));
      expect(
          NexusLanguage.getLang.networkConnectionTryAgain, equals('Try Again'));
      expect(NexusLanguage.getLang.requestTimeout,
          equals('Connection failed. Weak internet connection'));
    });

    test('should use Turkish translations when TR locale is set', () async {
      // Arrange
      when(mockManager.locale).thenReturn(const Locale('tr'));
      await NexusLanguage.languageLoad(const Locale('tr'));

      // Act & Assert
      expect(NexusLanguage.getLang.networkConnectionNoInternetConnection,
          equals('İnternet bağlantısı yok'));
      expect(NexusLanguage.getLang.networkConnectionTryAgain,
          equals('Tekrar Dene'));
      expect(NexusLanguage.getLang.requestTimeout,
          equals('Bağlantı başarısız oldu. Zayıf internet bağlantısı'));
    });

    test('should translate network exceptions correctly in English', () async {
      // Arrange
      when(mockManager.locale).thenReturn(const Locale('en'));
      await NexusLanguage.languageLoad(const Locale('en'));

      final exceptions = [
        const NetworkExceptions.requestTimeout(),
        const NetworkExceptions.noInternetConnection(),
        const NetworkExceptions.badRequest('Invalid request'),
        const NetworkExceptions.unauthorizedRequest('Unauthorized'),
      ];

      // Act & Assert
      expect(
        NetworkExceptions.getErrorMessage(exceptions[0]),
        equals('Connection failed. Weak internet connection'),
      );
      expect(
        NetworkExceptions.getErrorMessage(exceptions[1]),
        equals('No internet connection'),
      );
      expect(
        NetworkExceptions.getErrorMessage(exceptions[2]),
        equals('Invalid request'),
      );
      expect(
        NetworkExceptions.getErrorMessage(exceptions[3]),
        equals('Unauthorized'),
      );
    });

    test('should translate network exceptions correctly in Turkish', () async {
      // Arrange
      when(mockManager.locale).thenReturn(const Locale('tr'));
      await NexusLanguage.languageLoad(const Locale('tr'));

      final exceptions = [
        const NetworkExceptions.requestTimeout(),
        const NetworkExceptions.noInternetConnection(),
        const NetworkExceptions.badRequest('Geçersiz istek'),
        const NetworkExceptions.unauthorizedRequest('Yetkisiz'),
      ];

      // Act & Assert
      expect(
        NetworkExceptions.getErrorMessage(exceptions[0]),
        equals('Bağlantı başarısız oldu. Zayıf internet bağlantısı'),
      );
      expect(
        NetworkExceptions.getErrorMessage(exceptions[1]),
        equals('İnternet bağlantısı yok'),
      );
      expect(
        NetworkExceptions.getErrorMessage(exceptions[2]),
        equals('Geçersiz istek'),
      );
      expect(
        NetworkExceptions.getErrorMessage(exceptions[3]),
        equals('Yetkisiz'),
      );
    });
  });
}
