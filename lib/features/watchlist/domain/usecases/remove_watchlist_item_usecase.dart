import 'package:dartz/dartz.dart';
import '../../../../cores/data/error/failure.dart';
import '../../../../cores/domain/usecase/base_use_case.dart';
import '../../domain/repository/watchlist_repository.dart';

class RemoveWatchlistItemUseCase extends BaseUseCase<Unit, int> {
  final WatchlistRepository _baseWatchListRepository;

  RemoveWatchlistItemUseCase(this._baseWatchListRepository);

  @override
  Future<Either<Failure, Unit>> call(int p) async {
    return await _baseWatchListRepository.removeWatchListItem(p);
  }
}
