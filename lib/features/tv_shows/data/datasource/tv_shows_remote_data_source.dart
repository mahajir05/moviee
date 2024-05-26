import '../../../../cores/config/environment.dart';
import '../../../../cores/data/error/exceptions.dart';
import '../../../../cores/data/network/api_constants.dart';
import '../../../../cores/data/network/error_message_model.dart';
import '../../../../cores/services/api_service.dart';
import '../../data/models/season_details_model.dart';
import '../../data/models/tv_show_details_model.dart';
import '../../data/models/tv_show_model.dart';
import '../../domain/usecases/get_season_details_usecase.dart';

abstract class TVShowsRemoteDataSource {
  Future<List<TVShowModel>> getOnAirTVShows();
  Future<List<TVShowModel>> getPopularTVShows();
  Future<List<TVShowModel>> getTopRatedTVShows();
  Future<List<List<TVShowModel>>> getTVShows();
  Future<TVShowDetailsModel> getTVShowDetails(int id);
  Future<SeasonDetailsModel> getSeasonDetails(SeasonDetailsParams params);
  Future<List<TVShowModel>> getAllPopularTVShows(int page);
  Future<List<TVShowModel>> getAllTopRatedTVShows(int page);
}

class TVShowsRemoteDataSourceImpl extends TVShowsRemoteDataSource {
  final ApiService apiService;

  TVShowsRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<TVShowModel>> getOnAirTVShows() async {
    final response = await apiService
        .baseUrl(Environment.baseUrlV3())
        .get(apiPath: ApiConstants.onAirTvShowsPath);
    if (response.statusCode == 200) {
      return List<TVShowModel>.from((response.data['results'] as List)
          .map((e) => TVShowModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TVShowModel>> getPopularTVShows() async {
    final response = await apiService
        .baseUrl(Environment.baseUrlV3())
        .get(apiPath: ApiConstants.popularTvShowsPath);
    if (response.statusCode == 200) {
      return List<TVShowModel>.from((response.data['results'] as List)
          .map((e) => TVShowModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TVShowModel>> getTopRatedTVShows() async {
    final response = await apiService
        .baseUrl(Environment.baseUrlV3())
        .get(apiPath: ApiConstants.topRatedTvShowsPath);
    if (response.statusCode == 200) {
      return List<TVShowModel>.from((response.data['results'] as List)
          .map((e) => TVShowModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<List<TVShowModel>>> getTVShows() async {
    final response = Future.wait(
      [
        getOnAirTVShows(),
        getPopularTVShows(),
        getTopRatedTVShows(),
      ],
      eagerError: true,
    );
    return response;
  }

  @override
  Future<TVShowDetailsModel> getTVShowDetails(int id) async {
    final response = await apiService
        .baseUrl(Environment.baseUrlV3())
        .get(apiPath: ApiConstants.getTvShowDetailsPath(id));
    if (response.statusCode == 200) {
      return TVShowDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<SeasonDetailsModel> getSeasonDetails(
      SeasonDetailsParams params) async {
    final response = await apiService
        .baseUrl(Environment.baseUrlV3())
        .get(apiPath: ApiConstants.getSeasonDetailsPath(params));
    if (response.statusCode == 200) {
      return SeasonDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TVShowModel>> getAllPopularTVShows(int page) async {
    final response = await apiService
        .baseUrl(Environment.baseUrlV3())
        .get(apiPath: ApiConstants.getAllPopularTvShowsPath(page));
    if (response.statusCode == 200) {
      return List<TVShowModel>.from((response.data['results'] as List)
          .map((e) => TVShowModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TVShowModel>> getAllTopRatedTVShows(int page) async {
    final response = await apiService
        .baseUrl(Environment.baseUrlV3())
        .get(apiPath: ApiConstants.getAllTopRatedTvShowsPath(page));
    if (response.statusCode == 200) {
      return List<TVShowModel>.from((response.data['results'] as List)
          .map((e) => TVShowModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
