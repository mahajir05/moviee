import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cores/domain/entities/media.dart';
import '../../../../cores/presentation/components/custom_app_bar.dart';
import '../../../../cores/presentation/components/error_screen.dart';
import '../../../../cores/presentation/components/loading_indicator.dart';
import '../../../../cores/presentation/components/vertical_listview_card.dart';
import '../../../../cores/config/app_strings.dart';
import '../../../../cores/config/app_values.dart';
import '../../../../cores/services/service_locator.dart';
import '../../presentation/components/empty_watchlist_text.dart';
import '../../presentation/controllers/watchlist_bloc/watchlist_bloc.dart';

class WatchlistView extends StatelessWidget {
  const WatchlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WatchlistBloc>(
      create: (context) => sl<WatchlistBloc>()..add(GetWatchListItemsEvent()),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.watchlist,
        ),
        body: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            if (state.status == WatchlistRequestStatus.loading) {
              return const LoadingIndicator();
            } else if (state.status == WatchlistRequestStatus.loaded) {
              return WatchlistWidget(items: state.items);
            } else if (state.status == WatchlistRequestStatus.empty) {
              return const EmptyWatchlistText();
            } else {
              return ErrorScreen(
                onTryAgainPressed: () {
                  context.read<WatchlistBloc>().add(GetWatchListItemsEvent());
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class WatchlistWidget extends StatelessWidget {
  const WatchlistWidget({
    super.key,
    required this.items,
  });

  final List<Media> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p6,
      ),
      itemBuilder: (context, index) {
        return VerticalListViewCard(media: items[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: AppSize.s10),
    );
  }
}
