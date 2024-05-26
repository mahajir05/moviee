import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../cores/domain/entities/media_details.dart';
import '../../../../cores/presentation/components/error_screen.dart';
import '../../../../cores/presentation/components/section_listview.dart';
import '../../../../cores/config/app_strings.dart';
import '../../../../cores/config/app_values.dart';
import '../../../../cores/utils/enums.dart';
import '../../../../cores/utils/functions.dart';
import '../../../../cores/presentation/components/loading_indicator.dart';
import '../../../../cores/presentation/components/details_card.dart';
import '../../../../cores/presentation/components/section_title.dart';
import '../../../../cores/services/service_locator.dart';
import '../../domain/entities/cast.dart';
import '../../domain/entities/review.dart';
import '../../presentation/components/cast_card.dart';
import '../../presentation/components/movie_card_details.dart';
import '../../presentation/components/review_card.dart';
import '../../presentation/controllers/movie_details_bloc/movie_details_bloc.dart';

class MovieDetailsView extends StatelessWidget {
  final int movieId;

  const MovieDetailsView({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailsBloc>(
      create: (context) =>
          sl<MovieDetailsBloc>()..add(GetMovieDetailsEvent(movieId)),
      child: Scaffold(
        body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            switch (state.status) {
              case RequestStatus.loading:
                return const LoadingIndicator();
              case RequestStatus.loaded:
                return MovieDetailsWidget(movieDetails: state.movieDetails!);
              case RequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<MovieDetailsBloc>()
                        .add(GetMovieDetailsEvent(movieId));
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

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({
    required this.movieDetails,
    super.key,
  });

  final MediaDetails movieDetails;

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.movieDetails.trailerUrl) ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.pause();
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      _controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
          onReady: () {},
        ),
        builder: (context, player) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailsCard(
                  mediaDetails: widget.movieDetails,
                  detailsWidget:
                      MovieCardDetails(movieDetails: widget.movieDetails),
                ),
                if (widget.movieDetails.trailerUrl.isNotEmpty) player,
                getOverviewSection(widget.movieDetails.overview),
                _getCast(widget.movieDetails.cast),
                _getReviews(widget.movieDetails.reviews),
                getSimilarSection(widget.movieDetails.similar),
                const SizedBox(height: AppSize.s8),
              ],
            ),
          );
        });
  }
}

Widget _getCast(List<Cast>? cast) {
  if (cast != null && cast.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: AppStrings.cast),
        SectionListView(
          height: AppSize.s175,
          itemCount: cast.length,
          itemBuilder: (context, index) => CastCard(
            cast: cast[index],
          ),
        ),
      ],
    );
  } else {
    return const SizedBox();
  }
}

Widget _getReviews(List<Review>? reviews) {
  if (reviews != null && reviews.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: AppStrings.reviews),
        SectionListView(
          height: AppSize.s175,
          itemCount: reviews.length,
          itemBuilder: (context, index) => ReviewCard(
            review: reviews[index],
          ),
        ),
      ],
    );
  } else {
    return const SizedBox();
  }
}
