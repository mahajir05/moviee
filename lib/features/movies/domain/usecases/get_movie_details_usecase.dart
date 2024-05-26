import '../../../../cores/data/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../cores/domain/entities/media_details.dart';
import '../../../../cores/domain/usecase/base_use_case.dart';
import '../../domain/repository/movies_repository.dart';

class GetMoviesDetailsUseCase extends BaseUseCase<MediaDetails, int> {
  final MoviesRespository _baseMoviesRespository;

  GetMoviesDetailsUseCase(this._baseMoviesRespository);

  @override
  Future<Either<Failure, MediaDetails>> call(int p) async {
    return await _baseMoviesRespository.getMovieDetails(p);
  }
}
