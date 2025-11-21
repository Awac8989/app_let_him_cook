import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user.dart';
import '../services/firebase_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthState _authState = const AuthState(status: AuthStatus.unauthenticated);
  
  AuthState get authState => _authState;
  User? get currentUser => _authState.user;
  bool get isAuthenticated => _authState.isAuthenticated;
  bool get isLoading => _authState.isLoading;

  AuthProvider() {
    _initAuth();
  }

  void _initAuth() {
    FirebaseService.auth.authStateChanges().listen((firebase_auth.User? firebaseUser) {
      if (firebaseUser != null) {
        _authState = AuthState(
          status: AuthStatus.authenticated,
          user: User(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            username: firebaseUser.displayName ?? firebaseUser.email?.split('@').first ?? '',
            displayName: firebaseUser.displayName,
            profileImageUrl: firebaseUser.photoURL,
            createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
            lastActiveAt: DateTime.now(),
            isEmailVerified: firebaseUser.emailVerified,
          ),
        );
      } else {
        _authState = const AuthState(status: AuthStatus.unauthenticated);
      }
      notifyListeners();
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      _authState = _authState.copyWith(status: AuthStatus.loading);
      notifyListeners();

      await FirebaseService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      _authState = AuthState(
        status: AuthStatus.unauthenticated,
        errorMessage: _getErrorMessage(e.code),
      );
      notifyListeners();
      rethrow;
    } catch (e) {
      _authState = const AuthState(
        status: AuthStatus.unauthenticated,
        errorMessage: 'Đã xảy ra lỗi không mong muốn',
      );
      notifyListeners();
      rethrow;
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password, String username) async {
    try {
      _authState = _authState.copyWith(status: AuthStatus.loading);
      notifyListeners();

      final credential = await FirebaseService.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user display name
      await credential.user?.updateDisplayName(username);
      await credential.user?.reload();
    } on firebase_auth.FirebaseAuthException catch (e) {
      _authState = AuthState(
        status: AuthStatus.unauthenticated,
        errorMessage: _getErrorMessage(e.code),
      );
      notifyListeners();
      rethrow;
    } catch (e) {
      _authState = const AuthState(
        status: AuthStatus.unauthenticated,
        errorMessage: 'Đã xảy ra lỗi không mong muốn',
      );
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseService.auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('Error signing out: $e');
      }
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseService.auth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Exception(_getErrorMessage(e.code));
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'Không tìm thấy tài khoản với email này';
      case 'wrong-password':
        return 'Mật khẩu không đúng';
      case 'invalid-email':
        return 'Địa chỉ email không hợp lệ';
      case 'user-disabled':
        return 'Tài khoản đã bị vô hiệu hóa';
      case 'too-many-requests':
        return 'Quá nhiều yêu cầu. Vui lòng thử lại sau';
      case 'operation-not-allowed':
        return 'Phương thức đăng nhập này không được phép';
      case 'weak-password':
        return 'Mật khẩu quá yếu';
      case 'email-already-in-use':
        return 'Email đã được sử dụng bởi tài khoản khác';
      default:
        return 'Đã xảy ra lỗi không mong muốn';
    }
  }

  void clearError() {
    _authState = _authState.copyWith(errorMessage: null);
    notifyListeners();
  }
}