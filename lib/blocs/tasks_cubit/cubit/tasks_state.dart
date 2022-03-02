part of 'tasks_cubit.dart';

@immutable
abstract class TasksState {}

class TasksInitial extends TasksState {}

class TaskUpdated extends TasksState {}

class TaskRemoved extends TasksState {}

class CreateDb extends TasksState {}

class GetDataFromDB extends TasksState {}

class UpdateDataDb extends TasksState {}

class DeleteDataFromDB extends TasksState {}

class SaveToDB extends TasksState {}

class OpenAppState extends TasksState {}

class LoadFromPrefState extends TasksState {}

class TaskAdded extends TasksState {}

class LoadingState extends TasksState {}
