import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

abstract class BaseBloc<EventType, StateType>
    extends Bloc<EventType, StateType> {
  BaseBloc(StateType initialState) : super(initialState);

  void processEvent<SubEventType extends EventType>(
      EventHandler<SubEventType, StateType> handler,
      {EventTransformer<SubEventType>? transformer}) {
    // Events processed as sequential by default. Other values can be parallel, drop, ...
    transformer = transformer ?? sequential();
    on<SubEventType>(handler, transformer: transformer);
  }
}
