/// Singleton pelacak status autentikasi (guest / logged-in).
///
/// Fase UI belum punya state management, jadi status disimpan
/// sederhana di singleton. Saat backend masuk, ganti dengan
/// mekanisme yang lebih formal (Riverpod/Bloc).
class AuthState {
  AuthState._();

  static final AuthState _instance = AuthState._();

  factory AuthState() => _instance;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  bool get isGuest => !_isLoggedIn;

  void setLoggedIn() {
    _isLoggedIn = true;
  }

  void setLoggedOut() {
    _isLoggedIn = false;
  }
}