import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class FutoVoteException implements Exception {
  const FutoVoteException([this.message = defaultMsg]);

  final String message;

  static const String defaultMsg = 'Unknown error';

  factory FutoVoteException.fromAuthException(FirebaseAuthException e) {
    log(e.code);
    String msg = defaultMsg;
    switch (e.code) {
      case 'invalid-email':
        break;
      case 'auth/invalid-email':
        break;
      case 'user-disabled':
        break;
      case 'account-exists-with-different-credential':
        break;
      case 'user-not-found':
        msg = 'User does not exist';
        break;
      case 'email-already-in-use':
        msg = 'The Reg no already exists. Log in.';
        break;
      case 'weak-password':
        msg = 'Password is not strong. Try a stronger password';
        break;
      case 'requires-recent-login':
        msg = 'Please sign in again';
        break;
      case 'network-request-failed':
        msg = 'Check your internet connection';
        break;
      case 'wrong-password':
        msg = 'Wrong password';
        break;
      default:
        msg = e.message ?? defaultMsg;
        break;
    }

    return FutoVoteException(msg);
  }

  factory FutoVoteException.fromPlatformException(PlatformException e) {
    String msg = defaultMsg;
    switch (e.code) {
      case 'sign_in_cancelled':
        msg = 'Sign in cancelled';
        break;
      case 'network_error':
        msg = 'Check your internet connection';
        break;
      case 'sign_in_failed':
        msg = 'Sign in failed';
        break;
      default:
        msg = e.message ?? defaultMsg;
        break;
    }

    return FutoVoteException(msg);
  }

  factory FutoVoteException.fromFirebaseException(FirebaseException e) {
    String msg = defaultMsg;

    switch (e.code) {
      case 'storage/canceled':
        msg = 'Upload cancelled';
        break;
      case 'storage/cannot-slice-bob':
        msg = 'File not found';
        break;
      case 'storage/server-file-wrong-size':
        msg = 'Try again';
        break;
      case 'storage/quota-exceeded':
        msg = 'Try again later';
        break;
      case 'storage/unauthorized':
        break;
      case 'storage/unauthenticated':
        msg = 'User unauthenticated';
        break;

      default:
        msg = e.message ?? defaultMsg;
        break;
    }

    return FutoVoteException(msg);
  }
}
