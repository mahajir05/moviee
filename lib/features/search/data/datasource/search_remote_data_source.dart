import '../../../../cores/config/environment.dart';
import '../../../../cores/data/error/exceptions.dart';
import '../../../../cores/data/network/api_constants.dart';
import '../../../../cores/data/network/error_message_model.dart';
import '../../../../cores/services/api_service.dart';
import '../../data/models/search_result_item_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchResultItemModel>> search(String title);
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final ApiService apiService;

  SearchRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<SearchResultItemModel>> search(String title) async {
    final response = await apiService
        .baseUrl(Environment.baseUrlV3())
        .get(apiPath: ApiConstants.getSearchPath(title));
    if (response.statusCode == 200) {
      return List<SearchResultItemModel>.from((response.data['results'] as List)
          .where((e) => e['media_type'] != 'person')
          .map((e) => SearchResultItemModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
