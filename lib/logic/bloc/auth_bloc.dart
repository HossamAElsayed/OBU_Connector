import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/user.dart';
import '../../services/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required var box, required AuthRepo authRepo})
      : super(const AuthLoggedOut(User.empty)) {
    on<AuthStatus>((event, emit) {
      dynamic uid = box.get('uid');
      if (uid == null) {
        emit(const AuthLoggedOut(User.empty));
      } else {
        final String name = box.get('name');
        emit(AuthLoggedIn(User(uid, name)));
      }
    });
    on<AuthLogIn>((event, emit) async {
      emit(const AuthInitial(User.empty));
      var res = await authRepo.loginWithNameAndPassword(
          event.userName, event.password);

      if (res != '-1') {
        box.put('uid', res);
        box.put('name', event.userName);
        // final String imgUrl = box.put('name', event.password);
        final User user = User(res, event.userName);
        emit(AuthLoggedIn(user));
      } else {
        emit(const AuthError(User.empty));
      }
    });
    on<AuthLogOut>((event, emit) {
      box.delete('uid');
      box.delete('name');
      // box.put('uid', "");
      // box.put('name', "");
      // box.put('imgUrl', null);
      emit(const AuthLoggedOut(User.empty));
    });
  }
  get isLogged => (state.user.uid.isNotEmpty) ? true : false;
}
