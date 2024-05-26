import 'package:dartz/dartz.dart';
import '../../../../cores/data/error/failure.dart';
import '../../domain/entities/search_result_item.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchResultItem>>> search(String title);
}
