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
import '../../presentation/controllers/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';

class PopularTVShowsView extends StatelessWidget {
  const PopularTVShowsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PopularTVShowsBloc>(
      create: (context) =>
          sl<PopularTVShowsBloc>()..add(GetPopularTVShowsEvent()),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.popularShows,
        ),
        body: BlocBuilder<PopularTVShowsBloc, PopularTVShowsState>(
          builder: (context, state) {
            switch (state.status) {
              case GetAllRequestStatus.loading:
                return const LoadingIndicator();
              case GetAllRequestStatus.loaded:
                return PopularTVShowsWidget(tvShows: state.tvShows);
              case GetAllRequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<PopularTVShowsBloc>()
                        .add(GetPopularTVShowsEvent());
                  },
                );
              case GetAllRequestStatus.fetchMoreError:
                return PopularTVShowsWidget(tvShows: state.tvShows);
            }
          },
        ),
      ),
    );
  }
}

class PopularTVShowsWidget extends StatelessWidget {
  const PopularTVShowsWidget({
    super.key,
    required this.tvShows,
  });

  final List<Media> tvShows;

  @override
  Widget build(BuildContext context) {
    return VerticalListView(
      itemCount: tvShows.length + 1,
      itemBuilder: (context, index) {
        if (index < tvShows.length) {
          return VerticalListViewCard(media: tvShows[index]);
        } else {
          return const LoadingIndicator();
        }
      },
      addEvent: () {
        context.read<PopularTVShowsBloc>().add(FetchMorePopularTVShowsEvent());
      },
    );
  }
}
