import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../cores/domain/entities/media.dart';
import '../../../../cores/presentation/components/custom_slider.dart';
import '../../../../cores/presentation/components/error_screen.dart';
import '../../../../cores/presentation/components/section_listview_card.dart';
import '../../../../cores/presentation/components/loading_indicator.dart';
import '../../../../cores/presentation/components/section_header.dart';
import '../../../../cores/presentation/components/section_listview.dart';
import '../../../../cores/presentation/components/slider_card.dart';
import '../../../../cores/config/app_routes.dart';
import '../../../../cores/config/app_strings.dart';
import '../../../../cores/config/app_values.dart';
import '../../../../cores/services/service_locator.dart';
import '../../../../cores/utils/enums.dart';
import '../../presentation/controllers/tv_shows_bloc/tv_shows_bloc.dart';

class TVShowsView extends StatelessWidget {
  const TVShowsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TVShowsBloc>(
      create: (context) => sl<TVShowsBloc>()..add(GetTVShowsEvent()),
      child: Scaffold(
        body: BlocBuilder<TVShowsBloc, TVShowsState>(
          builder: (context, state) {
            switch (state.status) {
              case RequestStatus.loading:
                return const LoadingIndicator();
              case RequestStatus.loaded:
                return TVShowsWidget(
                  onAirTvShows: state.tvShows[0],
                  popularTvShows: state.tvShows[1],
                  topRatedTvShows: state.tvShows[2],
                );
              case RequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context.read<TVShowsBloc>().add(GetTVShowsEvent());
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

class TVShowsWidget extends StatelessWidget {
  const TVShowsWidget({
    super.key,
    required this.onAirTvShows,
    required this.popularTvShows,
    required this.topRatedTvShows,
  });

  final List<Media> onAirTvShows;
  final List<Media> popularTvShows;
  final List<Media> topRatedTvShows;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CustomSlider(
            itemBuilder: (context, itemIndex, _) {
              return SliderCard(
                media: onAirTvShows[itemIndex],
                itemIndex: itemIndex,
              );
            },
          ),
          SectionHeader(
            title: AppStrings.popularShows,
            onSeeAllTap: () {
              context.goNamed(AppRoutes.popularTvShowsRoute);
            },
          ),
          SectionListView(
            height: AppSize.s240,
            itemCount: popularTvShows.length,
            itemBuilder: (context, index) {
              return SectionListViewCard(media: popularTvShows[index]);
            },
          ),
          SectionHeader(
            title: AppStrings.topRatedShows,
            onSeeAllTap: () {
              context.goNamed(AppRoutes.topRatedTvShowsRoute);
            },
          ),
          SectionListView(
            height: AppSize.s240,
            itemCount: topRatedTvShows.length,
            itemBuilder: (context, index) {
              return SectionListViewCard(media: topRatedTvShows[index]);
            },
          ),
        ],
      ),
    );
  }
}
