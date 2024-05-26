import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cores/domain/entities/media.dart';
import '../../../../cores/presentation/components/error_screen.dart';
import '../../../../cores/presentation/components/loading_indicator.dart';
import '../../../../cores/presentation/components/custom_app_bar.dart';
import '../../../../cores/presentation/components/vertical_listview_card.dart';
import '../../../../cores/config/app_strings.dart';

import '../../../../cores/presentation/components/vertical_listview.dart';
import '../../../../cores/services/service_locator.dart';
import '../../../../cores/utils/enums.dart';
import '../../presentation/controllers/top_rated_movies_bloc/top_rated_movies_bloc.dart';

class TopRatedMoviesView extends StatelessWidget {
  const TopRatedMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopRatedMoviesBloc>(
      create: (context) =>
          sl<TopRatedMoviesBloc>()..add(GetTopRatedMoviesEvent()),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.topRatedMovies,
        ),
        body: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
          builder: (context, state) {
            switch (state.status) {
              case GetAllRequestStatus.loading:
                return const LoadingIndicator();
              case GetAllRequestStatus.loaded:
                return TopRatedMoviesWidget(movies: state.movies);
              case GetAllRequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<TopRatedMoviesBloc>()
                        .add(GetTopRatedMoviesEvent());
                  },
                );
              case GetAllRequestStatus.fetchMoreError:
                return TopRatedMoviesWidget(movies: state.movies);
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class TopRatedMoviesWidget extends StatelessWidget {
  const TopRatedMoviesWidget({
    required this.movies,
    super.key,
  });

  final List<Media> movies;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
      builder: (context, state) {
        return VerticalListView(
          itemCount: movies.length + 1,
          itemBuilder: (context, index) {
            if (index < movies.length) {
              return VerticalListViewCard(media: movies[index]);
            } else {
              return const LoadingIndicator();
            }
          },
          addEvent: () {
            context
                .read<TopRatedMoviesBloc>()
                .add(FetchMoreTopRatedMoviesEvent());
          },
        );
      },
    );
  }
}
