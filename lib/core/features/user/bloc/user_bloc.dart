import 'package:bloc/bloc.dart';
import 'package:ecohouse/core/features/auth/models/user.dart';
import 'package:ecohouse/core/features/user/repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<UserDataFetchEvent>(_mapUserDataFetchEventToState);
  }

  void _mapUserDataFetchEventToState(
      UserDataFetchEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      UserModule userData = await userRepository.fetchUsers();
      emit(UserLoadedState(userModule: userData));
    } catch (e) {
      emit(UserErrorState(error: e.toString()));
    }
  }
}
