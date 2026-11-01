import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_app_dashboard/core/usecase/login/login_usecase.dart';

class LoginRepo {
  final _loginUseCase = LoginUsecase();

  Future<Either<String, bool>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _loginUseCase.signIn(email, password);
      if (FirebaseAuth.instance.currentUser == null) {
        return const Left('Access denied: Admin privileges required.');
      }
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Authentication failed.');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
