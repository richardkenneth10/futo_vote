import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futo_vote/models/futo_vote_exception.dart';
import 'package:futo_vote/widgets/loading.dart';
import 'package:get/get.dart';

class SafeRequest {
  static Future run(Future Function() function,
      {Function? onSuccess,
      Function(FutoVoteException e)? onError,
      VoidCallback? onBegin,
      VoidCallback? onFinally}) async {
    final errorHandler = onError ??
        (e) {
          debugPrint(e.message);
          if (onBegin == null) {
            Get.back();
          }
          Get.rawSnackbar(
            backgroundColor: Colors.red,
            animationDuration: 350.milliseconds,
            message: e.message,
          );
        };

    (onBegin ?? Loading.show).call();
    try {
      await function.call();
      if (onBegin == null) {
        Get.back();
      }
      onSuccess?.call();
      return;
    } on SocketException {
      const err = FutoVoteException('No internet connection');
      errorHandler(err);
    } on FirebaseAuthException catch (e) {
      final err = FutoVoteException.fromAuthException(e);
      errorHandler(err);
    } on FirebaseException catch (e) {
      final err = FutoVoteException.fromFirebaseException(e);
      errorHandler(err);
    } on PlatformException catch (e) {
      final err = FutoVoteException.fromPlatformException(e);
      errorHandler(err);
    } on FutoVoteException catch (e) {
      errorHandler(e);
    } finally {
      onFinally?.call();
    }
  }
}
