import '../../../../cores/data/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../cores/domain/usecase/base_use_case.dart';
import '../../domain/repository/watchlist_repository.dart';

class CheckIfItemAddedUseCase extends BaseUseCase<int, int> {
  final WatchlistRepository _watchlistRepository;

  CheckIfItemAddedUseCase(this._watchlistRepository);
  @override
  Future<Either<Failure, int>> call(int p) async {
    return await _watchlistRepository.checkIfItemAdded(p);
  }
}
