import 'package:flutter/material.dart';
import '../../../../cores/config/app_strings.dart';
import '../../../../cores/config/app_values.dart';

class EmptyWatchlistText extends StatelessWidget {
  const EmptyWatchlistText({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.watchlistIsEmpty,
          style: textTheme.titleMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppPadding.p6),
          child: Text(
            AppStrings.watchlistText,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
