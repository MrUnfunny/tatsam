import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/models/country.dart';

import '../bloc/tatsam_bloc.dart';
import 'widgets/list_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Country> _countries = [];
  @override
  void initState() {
    context.read<TatsamBloc>().add(TatsamGetAllFavoritesEvent());
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
        ),
        body: SafeArea(
          minimum: const EdgeInsets.only(
            left: 12,
            top: 8,
            bottom: 8,
          ),
          child: BlocBuilder<TatsamBloc, TatsamState>(
            builder: (context, state) {
              if (state is TatsamLoadedAllFavoritesState) {
                _countries = state.countries;
                return ListWidget(
                  countries: state.countries,
                  showFavorite: false,
                );
              }
              if (_countries.isNotEmpty) {
                return ListWidget(
                  countries: _countries,
                  showFavorite: false,
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
