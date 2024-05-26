import '../../../../cores/data/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../cores/domain/entities/media.dart';
import '../../../../cores/domain/usecase/base_use_case.dart';
import '../../domain/repository/movies_repository.dart';

class GetMoviesUseCase extends BaseUseCase<List<List<Media>>, NoParameters> {
  final MoviesRespository _baseMoviesRespository;

  GetMoviesUseCase(this._baseMoviesRespository);

  @override
  Future<Either<Failure, List<List<Media>>>> call(NoParameters p) async {
    return await _baseMoviesRespository.getMovies();
  }
}
