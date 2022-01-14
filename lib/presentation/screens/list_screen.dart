import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/routing/route_paths.dart';

import '../../bloc/tatsam_bloc.dart';
import '../../models/country.dart';
import '../common/list_widget.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  var _countries = <Country>[];

  @override
  void initState() {
    context.read<TatsamBloc>().add(TatsamGetAllCountriesEvent());
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<TatsamBloc>()
                        .add(TatsamGetAllCountriesEvent());
                  },
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
            'Tatsam',
            style: TextStyle(
              color: Colors.black,
              fontSize: 36,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                RoutePaths.favoriteScreen,
                arguments: _countries,
              ),
              padding: const EdgeInsets.only(right: 24),
              icon: const Tooltip(
                message: 'View all favorite items',
                child: Icon(
                  Icons.favorite,
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
                log('called all');
                _countries = state.countries;
                return ListWidget(countries: state.countries);
              }
              if (state is TatsamAddedToFavoritesState) {
                log('called added');
                _countries = state.countries;
                return ListWidget(countries: state.countries);
              }
              if (state is TatsamRemovedFromFavoritesState) {
                log('called removed');
                _countries = state.countries;
                return ListWidget(countries: state.countries);
              }
              if (_countries.isNotEmpty) {
                log('called not empty');
                return ListWidget(countries: _countries);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
