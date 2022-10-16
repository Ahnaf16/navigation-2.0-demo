import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi();
});

class AuthApi {
  get login async {
    EasyLoading.show(status: 'Logging in');
    final cred = await auth.signInAnonymously();

    final User? user = cred.user;

    if (user == null) {
      EasyLoading.showError('Logging failed');
    } else {
      EasyLoading.showSuccess('Logging Success');
    }
  }

  get signInWithGoogle async {
    EasyLoading.show(status: 'Google Log in');
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    final cred = await auth.signInWithPopup(googleProvider);

    final User? user = cred.user;
    if (user == null) {
      EasyLoading.showError('Logging failed');
    } else {
      EasyLoading.showSuccess('Logging Success');
    }
  }

  emailLogIn(String email, String pass) async {
    EasyLoading.show(status: 'Email Log in');
    final cred = await auth.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );

    final User? user = cred.user;
    if (user == null) {
      EasyLoading.showError('Logging failed');
    } else {
      EasyLoading.showSuccess('Logging Success');
    }
  }

  get logOut async {
    EasyLoading.show(status: 'Logging Out');
    await auth.signOut();
    log('logged out');
    EasyLoading.showSuccess('Logged Out');
  }

  final auth = FirebaseAuth.instance;

  Stream<User?> get authState => auth.authStateChanges();
}

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final auth = FirebaseAuth.instance;

  return auth.authStateChanges();
});

final authStateProvider = Provider<AuthStateModel>((ref) {
  final auth = ref.watch(authStateChangesProvider);

  final AuthStateModel state = auth.when(
    data: (user) => user == null
        ? AuthStateModel(state: AuthState.unAuthenticated)
        : AuthStateModel(state: AuthState.authenticated),
    error: (error, st) => AuthStateModel(
      state: AuthState.error,
      error: error.toString(),
      stackTrace: st,
    ),
    loading: () => AuthStateModel(state: AuthState.loading),
  );

  return state;
});

enum AuthState {
  authenticated,
  unAuthenticated,
  loading,
  error;
}

class AuthStateModel {
  AuthStateModel({required this.state, this.error, this.stackTrace});

  final AuthState state;
  final String? error;
  final StackTrace? stackTrace;
}
