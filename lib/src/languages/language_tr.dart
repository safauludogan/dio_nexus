import 'abstract/languages.dart';

class LanguageTr extends Languages {
  @override
  String get networkConnectionNoInternetConnection => "İnternet bağlantısı yok";

  @override
  String get networkConnectionTryAgain => "Tekrar Dene";

  @override
  String get notImplemented => "Uygulanmadı";

  @override
  String get requestCancelled => "İstek İptal Edildi";

  @override
  String get internalServerError => "Dahi̇li̇ sunucu hatası";

  @override
  String get notFound => "Bulunamadı!";

  @override
  String get serviceUnavailable => "Servis kullanılamıyor";

  @override
  String get methodNotAllowed => "Yönteme izin verilmiyor";

  @override
  String get badRequest => "Geçersiz istek";

  @override
  String get unauthorisedRequest => "Yetkisiz istek";

  @override
  String get unexpectedError => "Beklenmedik hata oluştu";

  @override
  String get requestTimeout =>
      "Bağlantı başarısız oldu. Zayıf internet bağlantısı";

  @override
  String get conflict => "Bir çakışma nedeniyle hata oluştu";

  @override
  String get sendTimeout => "Veri Gönderme Süresi Aşımı";
  
  @override
  String get unableToProcess => "Veriler işlenemiyor";
  
  @override
  String get formatException => "Beklenmedik hata oluştu";
  
  @override
  String get notAcceptable => "Kabul edilemez";
  
  @override
  String get badCertificate => "Geçersiz veya Güvenilmeyen SSL/TLS sertifikası";
  
  @override
  String get connectionError => "İstek için bağlantı kurulamadı";
  
  @override
  String get receiveTimeout => "Sunucu yanıt vermiyor. Lütfen tekrar deneyiniz";
  
  @override
  String get forbiddenRequest => "Yasak İstek";
}
