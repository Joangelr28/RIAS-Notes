part of 'quic_notes_bloc.dart';

abstract class QuicNotesState extends Equatable {
  const QuicNotesState();
  
  @override
  List<Object> get props => [];
}

class QuicNotesInitial extends QuicNotesState {}
