part of 'pkbu_bloc.dart';

@immutable
abstract class PkbuEvent {}

class onGetCompanyData extends PkbuEvent {
  final int index;

  onGetCompanyData({required this.index});
}
