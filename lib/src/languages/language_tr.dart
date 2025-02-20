import 'package:dio_nexus/src/languages/index.dart';

/// The `LanguageTr` class extends the `Languages` abstract class and provides the Turkish language translations.
class LanguageTr extends Languages {
  @override
  String get networkConnectionNoInternetConnection => 'İnternet bağlantısı yok';

  @override
  String get networkConnectionTryAgain => 'Tekrar Dene';

  @override
  String get notImplemented => 'Uygulanmadı';

  @override
  String get requestCancelled => 'İstek iptal edildi';

  @override
  String get internalServerError => 'Dahi̇li̇ sunucu hatası';

  @override
  String get notFound => 'Bulunamadı!';

  @override
  String get serviceUnavailable => 'Servis kullanılamıyor';

  @override
  String get methodNotAllowed => 'Yönteme izin verilmiyor';

  @override
  String get badRequest => 'Geçersiz istek';

  @override
  String get unauthorizedRequest => 'Yetkisiz istek';

  @override
  String get unexpectedError => 'Beklenmedik hata oluştu';

  @override
  String get requestTimeout =>
      'Bağlantı başarısız oldu. Zayıf internet bağlantısı';

  @override
  String get conflict => 'Bir çakışma nedeniyle hata oluştu';

  @override
  String get sendTimeout => 'Veri gönderme süresi aşımı';

  @override
  String get unableToProcess => 'Veriler işlenemiyor';

  @override
  String get formatException => 'Beklenmedik hata oluştu';

  @override
  String get notAcceptable => 'Kabul edilemez';

  @override
  String get badCertificate => 'Geçersiz, güvenilmeyen SSL/TLS sertifikası';

  @override
  String get connectionError => 'İstek için bağlantı kurulamadı';

  @override
  String get receiveTimeout => 'Sunucu yanıt vermiyor. Lütfen tekrar deneyiniz';

  @override
  String get forbiddenRequest => 'Yasak istek';

  @override
  String get rateLimitExceeded => 'İstek limiti aşıldı';

  @override
  String get badGateway => 'Hatalı Ağ Geçidi: Sunucu geçersiz yanıt aldı';

  @override
  String get gatewayTimeout =>
      'Ağ Geçidi Zaman Aşımı: Sunucu zamanında yanıt veremedi';
}
