import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../cores/domain/entities/media.dart';
import '../../../../cores/presentation/components/error_screen.dart';
import '../../../../cores/presentation/components/loading_indicator.dart';
import '../../../../cores/presentation/components/slider_card.dart';
import '../../../../cores/config/app_routes.dart';

import '../../../../cores/presentation/components/custom_slider.dart';
import '../../../../cores/presentation/components/section_listview_card.dart';
import '../../../../cores/presentation/components/section_header.dart';
import '../../../../cores/presentation/components/section_listview.dart';
import '../../../../cores/config/app_strings.dart';
import '../../../../cores/config/app_values.dart';
import '../../../../cores/services/service_locator.dart';
import '../../../../cores/utils/enums.dart';
import '../../presentation/controllers/movies_bloc/movies_bloc.dart';
import '../../presentation/controllers/movies_bloc/movies_event.dart';
import '../../presentation/controllers/movies_bloc/movies_state.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesBloc>(
      create: (context) => sl<MoviesBloc>()..add(GetMoviesEvent()),
      child: Scaffold(
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            switch (state.status) {
              case RequestStatus.loading:
                return const LoadingIndicator();
              case RequestStatus.loaded:
                return MoviesWidget(
                  nowPlayingMovies: state.movies[0],
                  popularMovies: state.movies[1],
                  topRatedMovies: state.movies[2],
                );
              case RequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context.read<MoviesBloc>().add(GetMoviesEvent());
                  },
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class MoviesWidget extends StatelessWidget {
  final List<Media> nowPlayingMovies;
  final List<Media> popularMovies;
  final List<Media> topRatedMovies;

  const MoviesWidget({
    super.key,
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSlider(
            itemBuilder: (context, itemIndex, _) {
              return SliderCard(
                media: nowPlayingMovies[itemIndex],
                itemIndex: itemIndex,
              );
            },
          ),
          SectionHeader(
            title: AppStrings.popularMovies,
            onSeeAllTap: () {
              context.goNamed(AppRoutes.popularMoviesRoute);
            },
          ),
          SectionListView(
            height: AppSize.s240,
            itemCount: popularMovies.length,
            itemBuilder: (context, index) {
              return SectionListViewCard(media: popularMovies[index]);
            },
          ),
          SectionHeader(
            title: AppStrings.topRatedMovies,
            onSeeAllTap: () {
              context.goNamed(AppRoutes.topRatedMoviesRoute);
            },
          ),
          SectionListView(
            height: AppSize.s240,
            itemCount: topRatedMovies.length,
            itemBuilder: (context, index) {
              return SectionListViewCard(media: topRatedMovies[index]);
            },
          ),
        ],
      ),
    );
  }
}
