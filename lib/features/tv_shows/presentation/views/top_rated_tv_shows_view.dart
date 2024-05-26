import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cores/domain/entities/media.dart';
import '../../../../cores/presentation/components/custom_app_bar.dart';
import '../../../../cores/presentation/components/error_screen.dart';
import '../../../../cores/presentation/components/loading_indicator.dart';
import '../../../../cores/presentation/components/vertical_listview.dart';
import '../../../../cores/presentation/components/vertical_listview_card.dart';
import '../../../../cores/config/app_strings.dart';
import '../../../../cores/services/service_locator.dart';
import '../../../../cores/utils/enums.dart';
import '../../presentation/controllers/top_rated_tv_shows_bloc/top_rated_tv_shows_bloc.dart';

class TopRatedTVShowsView extends StatelessWidget {
  const TopRatedTVShowsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopRatedTVShowsBloc>(
      create: (context) =>
          sl<TopRatedTVShowsBloc>()..add(GetTopRatedTVShowsEvent()),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.topRatedShows,
        ),
        body: BlocBuilder<TopRatedTVShowsBloc, TopRatedTVShowsState>(
          builder: (context, state) {
            switch (state.status) {
              case GetAllRequestStatus.loading:
                return const LoadingIndicator();
              case GetAllRequestStatus.loaded:
                return TopRatedTVShowsWidget(tvShows: state.tvShows);
              case GetAllRequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<TopRatedTVShowsBloc>()
                        .add(GetTopRatedTVShowsEvent());
                  },
                );
              case GetAllRequestStatus.fetchMoreError:
                return TopRatedTVShowsWidget(tvShows: state.tvShows);
            }
          },
        ),
      ),
    );
  }
}

class TopRatedTVShowsWidget extends StatelessWidget {
  const TopRatedTVShowsWidget({
    super.key,
    required this.tvShows,
  });

  final List<Media> tvShows;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VerticalListView(
        itemCount: tvShows.length + 1,
        itemBuilder: (context, index) {
          if (index < tvShows.length) {
            return VerticalListViewCard(media: tvShows[index]);
          } else {
            return const LoadingIndicator();
          }
        },
        addEvent: () {
          context
              .read<TopRatedTVShowsBloc>()
              .add(FetchMoreTopRatedTVShowsEvent());
        },
      ),
    );
  }
}
