import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mottu_marvel/app/core/theme/app_colors.dart';
import 'package:mottu_marvel/app/core/theme/text_syles.dart';
import 'package:mottu_marvel/app/core/widgets/default_app_bar.dart';
import 'package:mottu_marvel/app/core/widgets/default_screen.dart';
import 'package:mottu_marvel/app/presentation/home/bloc/home_bloc.dart';
import 'package:mottu_marvel/app/presentation/home/widgets/character_item_horizontal_card.dart';
import 'package:mottu_marvel/app/presentation/home/widgets/character_item_vertical_card.dart';
import 'package:mottu_marvel/app/presentation/home/widgets/list_shimer.dart';
import 'package:mottu_marvel/app/presentation/home/widgets/pagination_container.dart';
import 'package:mottu_marvel/app/presentation/home/widgets/view_mode_selector.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    return Scaffold(
      backgroundColor: AppColors.grey8,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeSuccess) {
              return DefaultScreen(
                child: Column(
                  children: [
                    const DefaultAppBar(
                      title: 'Heróis',
                      showBackButton: false,
                    ),
                    state.isLoading
                        ? const ListShimmer()
                        : state.characters.isEmpty
                            ? Center(
                                child: Text(
                                  'Nenum resultado encontrado',
                                  style: TextStyles.h5Style.copyWith(
                                    color: AppColors.grey3,
                                  ),
                                ),
                              )
                            : Expanded(
                                child: state.isGridView
                                    ? GridView.builder(
                                        //shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              2, // number of items in each row
                                          mainAxisSpacing:
                                              8.0, // spacing between rows
                                          crossAxisSpacing:
                                              8.0, // spacing between columns
                                        ),
                                        padding: const EdgeInsets.all(
                                            8.0), // padding around the grid
                                        itemCount: state.characters
                                            .length, // total number of items
                                        itemBuilder: (context, index) {
                                          final item = state.characters[index];
                                          return CharacterItemVerticalCard(
                                              character: item);
                                        },
                                      )
                                    : ListView.builder(
                                        itemCount: state.characters.length,
                                        //shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final item = state.characters[index];
                                          return CharacterItemHorizontalCard(
                                            character: item,
                                          );
                                        },
                                      ),
                              )
                  ],
                ),
              );
            }

            return Container();
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ViewModeSelector(
                    isGridView: state.isGridView,
                    onToggle: () {
                      homeBloc.add(ToggleGridViewEvent());
                    },
                  ),
                ),
                PaginationContainer(
                  atualPage: state.atualPage,
                  maxPage: state.maxPage,
                  isLoading: state.isLoading,
                  pagesInScreen: 5,
                  onChangePage: (page) => homeBloc.add(
                    GetCharactersEvent(page: page),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
