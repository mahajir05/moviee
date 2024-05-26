import '../../../features/tv_shows/domain/usecases/get_season_details_usecase.dart';
import '../../config/environment.dart';

class ApiConstants {
  static const String baseBackdropUrl = 'https://image.tmdb.org/t/p/w1280';
  static const String basePosterUrl = 'https://image.tmdb.org/t/p/w500';
  static const String baseProfileUrl = 'https://image.tmdb.org/t/p/w300';
  static const String baseStillUrl = 'https://image.tmdb.org/t/p/w500';
  static const String baseAvatarUrl = 'https://image.tmdb.org/t/p/w185';
  static const String baseVideoUrl = 'https://www.youtube.com/watch?v=';

  static const String moviePlaceHolder =
      'https://davidkoepp.com/wp-content/themes/blankslate/images/Movie%20Placeholder.jpg';

  static const String castPlaceHolder =
      'https://palmbayprep.org/wp-content/uploads/2015/09/user-icon-placeholder.png';

  static const String avatarPlaceHolder =
      'https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049__480.png';

  static const String stillPlaceHolder =
      'https://popcornsg.s3.amazonaws.com/gallery/1577405144-six-year.png';

  // movies paths
  static String nowPlayingMoviesPath =
      '/movie/now_playing?api_key=${Environment.apiKey()}';

  static String popularMoviesPath =
      '/movie/popular?api_key=${Environment.apiKey()}';

  static String topRatedMoviesPath =
      '/movie/top_rated?api_key=${Environment.apiKey()}';

  static String getMovieDetailsPath(int movieId) {
    return '/movie/$movieId?api_key=${Environment.apiKey()}&append_to_response=videos,credits,reviews,similar';
  }

  static String getAllPopularMoviesPath(int page) {
    return '/movie/popular?api_key=${Environment.apiKey()}&page=$page';
  }

  static String getAllTopRatedMoviesPath(int page) {
    return '/movie/top_rated?api_key=${Environment.apiKey()}&page=$page';
  }

  // tv shows paths
  static String onAirTvShowsPath =
      '/tv/on_the_air?api_key=${Environment.apiKey()}&with_original_language=en';

  static String popularTvShowsPath =
      '/tv/popular?api_key=${Environment.apiKey()}&with_original_language=en';

  static String topRatedTvShowsPath =
      '/tv/top_rated?api_key=${Environment.apiKey()}&with_original_language=en';

  static String getTvShowDetailsPath(int tvShowId) {
    return '/tv/$tvShowId?api_key=${Environment.apiKey()}&append_to_response=similar,videos';
  }

  static String getSeasonDetailsPath(SeasonDetailsParams params) {
    return '/tv/${params.id}/season/${params.seasonNumber}?api_key=${Environment.apiKey()}';
  }

  static String getAllPopularTvShowsPath(int page) {
    return '/tv/popular?api_key=${Environment.apiKey()}&page=$page&with_original_language=en';
  }

  static String getAllTopRatedTvShowsPath(int page) {
    return '/tv/top_rated?api_key=${Environment.apiKey()}&page=$page&with_original_language=en';
  }

  // search paths
  static String getSearchPath(String title) {
    return '/search/multi?api_key=${Environment.apiKey()}&query=$title';
  }
}
