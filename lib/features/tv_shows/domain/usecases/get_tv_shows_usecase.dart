import '../../../../cores/data/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../cores/domain/entities/media.dart';
import '../../../../cores/domain/usecase/base_use_case.dart';
import '../../domain/repository/tv_shows_repository.dart';

class GetTVShowsUseCase extends BaseUseCase<List<List<Media>>, NoParameters> {
  final TVShowsRepository _baseTVShowsRepository;

  GetTVShowsUseCase(this._baseTVShowsRepository);

  @override
  Future<Either<Failure, List<List<Media>>>> call(NoParameters p) async {
    return await _baseTVShowsRepository.getTVShows();
  }
}
