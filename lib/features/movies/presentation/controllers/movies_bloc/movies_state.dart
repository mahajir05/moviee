import 'package:equatable/equatable.dart';
import '../../../../../cores/domain/entities/media.dart';
import '../../../../../cores/utils/enums.dart';

class MoviesState extends Equatable {
  final List<List<Media>> movies;
  final RequestStatus status;
  final String message;

  const MoviesState({
    this.movies = const [],
    this.status = RequestStatus.loading,
    this.message = '',
  });

  MoviesState copyWith({
    List<List<Media>>? movies,
    RequestStatus? status,
    String? message,
  }) {
    return MoviesState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        movies,
        status,
        message,
      ];
}
