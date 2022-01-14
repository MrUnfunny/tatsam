import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/models/country.dart';

import '../bloc/tatsam_bloc.dart';
import 'widgets/list_widget.dart';

class FavoriteScreen extends StatefulWidget {
  final List<Country> countries;
  const FavoriteScreen({Key? key, required this.countries}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Country> countries = [];

  @override
  void initState() {
    countries = widget.countries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TatsamBloc, TatsamState>(
      listener: (context, state) {
        if (state is TatsamFailureState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }

        if (state is TatsamInternetFailureState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('Please Check your internet Connectivity'),
              actions: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Favorites',
            style: TextStyle(
              color: Colors.black,
              fontSize: 36,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => context
                  .read<TatsamBloc>()
                  .add(TatsamRemoveAllFromFavoritesEvent()),
              padding: const EdgeInsets.only(right: 24),
              icon: const Tooltip(
                message: 'Remove all favorite items',
                child: Icon(
                  Icons.delete,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          minimum: const EdgeInsets.only(
            left: 12,
            top: 8,
            bottom: 8,
          ),
          child: BlocBuilder<TatsamBloc, TatsamState>(
            builder: (context, state) {
              if (state is TatsamAllCountriesLoadedState) {
                countries = state.countries;
                return ListWidget(
                  countries: state.countries,
                  showFavoriteIcon: false,
                );
              }
              if (state is TatsamLoadedAllFavoritesState) {
                countries = state.countries;
                return ListWidget(
                  countries: state.countries,
                  showFavoriteIcon: false,
                );
              }
              if (countries.isNotEmpty) {
                return ListWidget(
                  countries: countries,
                  showFavoriteIcon: false,
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
