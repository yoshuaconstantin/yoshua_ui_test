part of 'pkbu_bloc.dart';

@immutable
abstract class PkbuState {}

class PkbuInitial extends PkbuState {}

class onGetDataLoading extends PkbuState {}

class onGetDataSuccess extends PkbuState {
  final PkbuResponse data;
  final int nextIndex;

  onGetDataSuccess({required this.data, required this.nextIndex});
}

class onGetDataFailed extends PkbuState {
  final String message;

  onGetDataFailed({required this.message});
}

class onGetDataFinished extends PkbuState {}
