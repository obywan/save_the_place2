import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  TagsBloc() : super(TagsInitial()) {
    on<TagsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
