import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quic_notes_event.dart';
part 'quic_notes_state.dart';

class QuicNotesBloc extends Bloc<QuicNotesEvent, QuicNotesState> {
  QuicNotesBloc() : super(QuicNotesInitial());

  @override
  Stream<QuicNotesState> mapEventToState(
    QuicNotesEvent event,
  ) async* {}
}
