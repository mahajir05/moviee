import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cores/domain/entities/media_details.dart';
import '../../../../cores/presentation/components/details_card.dart';
import '../../../../cores/presentation/components/error_screen.dart';
import '../../../../cores/presentation/components/loading_indicator.dart';
import '../../../../cores/presentation/components/section_title.dart';
import '../../../../cores/config/app_strings.dart';
import '../../../../cores/config/app_values.dart';
import '../../../../cores/services/service_locator.dart';
import '../../../../cores/utils/enums.dart';
import '../../../../cores/utils/functions.dart';
import '../../presentation/components/episode_card.dart';
import '../../presentation/components/seasons_section.dart';
import '../../presentation/components/tv_show_card_details.dart';

import '../../presentation/controllers/tv_show_details_bloc/tv_show_details_bloc.dart';

class TVShowDetailsView extends StatelessWidget {
  const TVShowDetailsView({
    super.key,
    required this.tvShowId,
  });

  final int tvShowId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TVShowDetailsBloc>(
      create: (context) =>
          sl<TVShowDetailsBloc>()..add(GetTVShowDetailsEvent(tvShowId)),
      child: Scaffold(
        body: BlocBuilder<TVShowDetailsBloc, TVShowDetailsState>(
          builder: (context, state) {
            switch (state.tvShowDetailsStatus) {
              case RequestStatus.loading:
                return const LoadingIndicator();
              case RequestStatus.loaded:
                return TVShowDetailsWidget(tvShowDetails: state.tvShowDetails!);
              case RequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<TVShowDetailsBloc>()
                        .add(GetTVShowDetailsEvent(tvShowId));
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

class TVShowDetailsWidget extends StatelessWidget {
  const TVShowDetailsWidget({
    super.key,
    required this.tvShowDetails,
  });

  final MediaDetails tvShowDetails;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsCard(
            mediaDetails: tvShowDetails,
            detailsWidget: TVShowCardDetails(
              genres: tvShowDetails.genres,
              lastEpisode: tvShowDetails.lastEpisodeToAir!,
              seasons: tvShowDetails.seasons!,
            ),
          ),
          getOverviewSection(tvShowDetails.overview),
          const SectionTitle(title: AppStrings.lastEpisodeOnAir),
          EpisodeCard(episode: tvShowDetails.lastEpisodeToAir!),
          const SectionTitle(title: AppStrings.seasons),
          SeasonsSection(
            tmdbID: tvShowDetails.tmdbID,
            seasons: tvShowDetails.seasons!,
          ),
          getSimilarSection(tvShowDetails.similar),
          const SizedBox(height: AppSize.s8),
        ],
      ),
    );
  }
}
