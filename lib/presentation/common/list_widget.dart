import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tatsam_bloc.dart';
import '../../models/country.dart';

class ListWidget extends StatelessWidget {
  final List<Country> _countries;
  final bool showFavoriteIcon;

  const ListWidget({
    Key? key,
    required countries,
    this.showFavoriteIcon = true,
  })  : _countries = countries,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _countries.length,
      itemBuilder: (context, index) {
        if (!showFavoriteIcon) {
          if (_countries[index].favorite) {
            return Dismissible(
              background: Container(
                color: Colors.red,
                child: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.white,
                ),
              ),
              key: UniqueKey(),
              onDismissed: (direction) {
                context.read<TatsamBloc>().add(
                      TatsamRemoveFromFavoritesEvent(
                        _countries[index],
                        _countries,
                      ),
                    );
                _countries.removeAt(index);
              },
              child: CustomListTile(
                countries: _countries,
                showFavorite: showFavoriteIcon,
                index: index,
              ),
            );
          } else {
            return Container();
          }
        } else {
          return CustomListTile(
            countries: _countries,
            showFavorite: showFavoriteIcon,
            index: index,
          );
        }
      },
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required List<Country> countries,
    required this.showFavorite,
    required this.index,
  })  : _countries = countries,
        super(key: key);

  final List<Country> _countries;
  final bool showFavorite;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
                ? const Tooltip(
                    message: 'Remove from favorites',
                    child: Icon(
                      Icons.favorite,
                      color: Colors.pinkAccent,
                    ),
                  )
                : const Tooltip(
                    message: 'Add to favorites',
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.pinkAccent,
                    ),
                  )
            : const Icon(null),
      ),
    );
  }
}
