part of 'navbar_cubit.dart';

@immutable
abstract class NavbarState {}

class NavbarInitial extends NavbarState {}

class NavBarChangeIndex extends NavbarState {}

class ChangeFABIconState extends NavbarState {}

class ChangeDateAndTimeState extends NavbarState {}

class ChangeIsDateState extends NavbarState {}

class ChangeIsModalHistoryState extends NavbarState {}
