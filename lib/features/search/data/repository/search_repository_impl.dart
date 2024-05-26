import 'package:dio/dio.dart';
import '../../../../cores/data/error/exceptions.dart';
import '../../data/datasource/search_remote_data_source.dart';
import '../../domain/entities/search_result_item.dart';
import '../../../../cores/data/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource _baseSearchRemoteDataSource;

  SearchRepositoryImpl(this._baseSearchRemoteDataSource);

  @override
  Future<Either<Failure, List<SearchResultItem>>> search(String title) async {
    try {
      final result = await _baseSearchRemoteDataSource.search(title);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message ?? "-"));
    }
  }
}
