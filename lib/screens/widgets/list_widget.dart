import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tatsam_bloc.dart';
import '../../models/country.dart';

class ListWidget extends StatelessWidget {
  final List<Country> _countries;
  final bool showFavorite;

  const ListWidget({
    Key? key,
    required countries,
    this.showFavorite = true,
  })  : _countries = countries,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _countries.length,
      itemBuilder: (context, index) => ListTile(
        leading: Text(_countries[index].short ?? ''),
        title: Text(
          _countries[index].name,
        ),
        subtitle: Text(
          _countries[index].region,
        ),
        trailing: IconButton(
          onPressed: () {
            context.read<TatsamBloc>().add(
                  _countries[index].favorite
                      ? TatsamRemoveFromFavoritesEvent(
                          _countries[index],
                          _countries,
                        )
                      : TatsamAddToFavoritesEvent(
                          _countries[index],
                          _countries,
                        ),
                );
          },
          icon: showFavorite
              ? _countries[index].favorite
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.pinkAccent,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      color: Colors.pinkAccent,
                    )
              : const Icon(null),
        ),
      ),
    );
  }
}
