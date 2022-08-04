import 'package:bloc/bloc.dart';

abstract class BaseBloc<EventType, StateType> extends Bloc<EventType, StateType> {
  
  BaseBloc(StateType initialState) : super(initialState);

}