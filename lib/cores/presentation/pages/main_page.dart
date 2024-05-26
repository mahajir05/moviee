import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_colors.dart';
import '../../config/app_router.dart';
import '../../config/app_strings.dart';

import '../../config/app_routes.dart';
import '../../config/app_values.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      onPopInvoked: (value) async {
        final String location = GoRouterState.of(context).fullPath ?? "";
        if (!location.startsWith(moviesPath)) {
          _onItemTapped(0, context);
          return;
        }
        context.pop();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Netplix"),
          actions: [
            IconButton(
              onPressed: () {
                context.goNamed(AppRoutes.searchRoute);
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: widget.child,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                ),
                child: SizedBox(),
              ),
              ListTile(
                leading: const Icon(
                  Icons.movie_creation_rounded,
                  size: AppSize.s20,
                  color: AppColors.primaryText,
                ),
                title: Text(
                  AppStrings.movies,
                  style: textTheme.bodyMedium,
                ),
                onTap: () => _onItemTapped(0, context),
              ),
              ListTile(
                leading: const Icon(
                  Icons.tv_rounded,
                  size: AppSize.s20,
                  color: AppColors.primaryText,
                ),
                title: Text(
                  AppStrings.shows,
                  style: textTheme.bodyMedium,
                ),
                onTap: () => _onItemTapped(1, context),
              ),
              ListTile(
                leading: const Icon(
                  Icons.search_rounded,
                  size: AppSize.s20,
                  color: AppColors.primaryText,
                ),
                title: Text(
                  AppStrings.search,
                  style: textTheme.bodyMedium,
                ),
                onTap: () => _onItemTapped(2, context),
              ),
              ListTile(
                leading: const Icon(
                  Icons.bookmark_rounded,
                  size: AppSize.s20,
                  color: AppColors.primaryText,
                ),
                title: Text(
                  AppStrings.watchlist,
                  style: textTheme.bodyMedium,
                ),
                onTap: () => _onItemTapped(3, context),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const [
        //     BottomNavigationBarItem(
        //       label: AppStrings.movies,
        //       icon: Icon(
        //         Icons.movie_creation_rounded,
        //         size: AppSize.s20,
        //       ),
        //     ),
        //     BottomNavigationBarItem(
        //       label: AppStrings.shows,
        //       icon: Icon(
        //         Icons.tv_rounded,
        //         size: AppSize.s20,
        //       ),
        //     ),
        //     BottomNavigationBarItem(
        //       label: AppStrings.search,
        //       icon: Icon(
        //         Icons.search_rounded,
        //         size: AppSize.s20,
        //       ),
        //     ),
        //     BottomNavigationBarItem(
        //       label: AppStrings.watchlist,
        //       icon: Icon(
        //         Icons.bookmark_rounded,
        //         size: AppSize.s20,
        //       ),
        //     ),
        //   ],
        //   currentIndex: _getSelectedIndex(context),
        //   onTap: (index) => _onItemTapped(index, context),
        // ),
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).fullPath ?? "";
    if (location.startsWith(moviesPath)) {
      return 0;
    }
    if (location.startsWith(tvShowsPath)) {
      return 1;
    }
    if (location.startsWith(searchPath)) {
      return 2;
    }
    if (location.startsWith(watchlistPath)) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.moviesRoute);
        context.pop();
        break;
      case 1:
        context.goNamed(AppRoutes.tvShowsRoute);
        context.pop();
        break;
      case 2:
        context.goNamed(AppRoutes.searchRoute);
        context.pop();
        break;
      case 3:
        context.goNamed(AppRoutes.watchlistRoute);
        context.pop();
        break;
    }
  }
}
