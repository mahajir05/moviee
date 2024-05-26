import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/movies/data/datasource/movies_remote_data_source.dart';
import '../../features/movies/data/repository/movies_repository_impl.dart';
import '../../features/movies/domain/repository/movies_repository.dart';
import '../../features/movies/domain/usecases/get_all_popular_movies_usecase.dart';
import '../../features/movies/domain/usecases/get_all_top_rated_movies_usecase.dart';
import '../../features/movies/domain/usecases/get_movie_details_usecase.dart';
import '../../features/movies/domain/usecases/get_movies_usecase.dart';
import '../../features/movies/presentation/controllers/movie_details_bloc/movie_details_bloc.dart';
import '../../features/movies/presentation/controllers/movies_bloc/movies_bloc.dart';
import '../../features/movies/presentation/controllers/popular_movies_bloc/popular_movies_bloc.dart';
import '../../features/movies/presentation/controllers/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import '../../features/search/data/datasource/search_remote_data_source.dart';
import '../../features/search/data/repository/search_repository_impl.dart';
import '../../features/search/domain/repository/search_repository.dart';
import '../../features/search/domain/usecases/search_usecase.dart';
import '../../features/search/presentation/controllers/search_bloc/search_bloc.dart';
import '../../features/tv_shows/data/datasource/tv_shows_remote_data_source.dart';
import '../../features/tv_shows/data/repository/tv_shows_repository_impl.dart';
import '../../features/tv_shows/domain/repository/tv_shows_repository.dart';
import '../../features/tv_shows/domain/usecases/get_all_popular_tv_shows_usecase.dart';
import '../../features/tv_shows/domain/usecases/get_all_top_rated_tv_shows_usecase.dart';
import '../../features/tv_shows/domain/usecases/get_season_details_usecase.dart';
import '../../features/tv_shows/domain/usecases/get_tv_show_details_usecase.dart';
import '../../features/tv_shows/domain/usecases/get_tv_shows_usecase.dart';
import '../../features/tv_shows/presentation/controllers/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';
import '../../features/tv_shows/presentation/controllers/top_rated_tv_shows_bloc/top_rated_tv_shows_bloc.dart';
import '../../features/tv_shows/presentation/controllers/tv_show_details_bloc/tv_show_details_bloc.dart';
import '../../features/tv_shows/presentation/controllers/tv_shows_bloc/tv_shows_bloc.dart';
import '../../features/watchlist/data/datasource/watchlist_local_data_source.dart';
import '../../features/watchlist/data/repository/watchlist_repository_impl.dart';
import '../../features/watchlist/domain/repository/watchlist_repository.dart';
import '../../features/watchlist/domain/usecases/add_watchlist_item_usecase.dart';
import '../../features/watchlist/domain/usecases/check_if_item_added_usecase.dart';
import '../../features/watchlist/domain/usecases/get_watchlist_items_usecase.dart';
import '../../features/watchlist/domain/usecases/remove_watchlist_item_usecase.dart';
import '../../features/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';
import 'api_service.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    sl.registerFactory(() => Dio());
    sl.registerFactory(() => ApiService(dio: sl()));

    // Data source
    sl.registerLazySingleton<MoviesRemoteDataSource>(
        () => MoviesRemoteDataSourceImpl(apiService: sl()));
    sl.registerLazySingleton<TVShowsRemoteDataSource>(
        () => TVShowsRemoteDataSourceImpl(apiService: sl()));
    sl.registerLazySingleton<SearchRemoteDataSource>(
        () => SearchRemoteDataSourceImpl(apiService: sl()));
    sl.registerLazySingleton<WatchlistLocalDataSource>(
        () => WatchlistLocalDataSourceImpl());

    // Repository
    sl.registerLazySingleton<MoviesRespository>(
        () => MoviesRepositoryImpl(sl()));
    sl.registerLazySingleton<TVShowsRepository>(
        () => TVShowsRepositoryImpl(sl()));
    sl.registerLazySingleton<SearchRepository>(
        () => SearchRepositoryImpl(sl()));
    sl.registerLazySingleton<WatchlistRepository>(
        () => WatchListRepositoryImpl(sl()));

    // Use Cases
    sl.registerLazySingleton(() => GetMoviesDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetAllPopularMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetAllTopRatedMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetTVShowsUseCase(sl()));
    sl.registerLazySingleton(() => GetTVShowDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetSeasonDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetAllPopularTVShowsUseCase(sl()));
    sl.registerLazySingleton(() => GetAllTopRatedTVShowsUseCase(sl()));
    sl.registerLazySingleton(() => SearchUseCase(sl()));
    sl.registerLazySingleton(() => GetWatchlistItemsUseCase(sl()));
    sl.registerLazySingleton(() => AddWatchlistItemUseCase(sl()));
    sl.registerLazySingleton(() => RemoveWatchlistItemUseCase(sl()));
    sl.registerLazySingleton(() => CheckIfItemAddedUseCase(sl()));

    // Bloc
    sl.registerFactory(() => MoviesBloc(sl()));
    sl.registerFactory(() => MovieDetailsBloc(sl()));
    sl.registerFactory(() => PopularMoviesBloc(sl()));
    sl.registerFactory(() => TopRatedMoviesBloc(sl()));
    sl.registerFactory(() => TVShowsBloc(sl()));
    sl.registerFactory(() => TVShowDetailsBloc(sl(), sl()));
    sl.registerFactory(() => PopularTVShowsBloc(sl()));
    sl.registerFactory(() => TopRatedTVShowsBloc(sl()));
    sl.registerFactory(() => SearchBloc(sl()));
    sl.registerFactory(() => WatchlistBloc(sl(), sl(), sl(), sl()));
  }
}
