part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final UserModule userModule;

  const UserLoadedState({required this.userModule});
}

class UserErrorState extends UserState {
  final String error;

  const UserErrorState({required this.error});
}
