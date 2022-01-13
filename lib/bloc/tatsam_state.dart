part of 'tatsam_bloc.dart';

abstract class TatsamState extends Equatable {
  const TatsamState();

  @override
  List<Object> get props => [];
}

class TatsamInitial extends TatsamState {}

class TatsamAllCountriesLoadedState extends TatsamState {
  final List<Country> countries;
  final int random;

  const TatsamAllCountriesLoadedState(this.countries, this.random);

  @override
  List<Object> get props => [countries, random];
}

class TatsamAddedToFavoritesState extends TatsamState {
  final List<Country> countries;
  final int random;

  const TatsamAddedToFavoritesState(this.countries, this.random);

  @override
  List<Object> get props => [countries, random];
}

class TatsamRemovedFromFavoritesState extends TatsamState {
  final List<Country> countries;
  final int random;

  const TatsamRemovedFromFavoritesState(this.countries, this.random);

  @override
  List<Object> get props => [countries, random];
}

class TatsamLoadedAllFavoritesState extends TatsamState {
  final List<Country> countries;
  final int random;

  const TatsamLoadedAllFavoritesState(this.countries, this.random);

  @override
  List<Object> get props => [countries, random];
}

class TatsamInternetFailureState extends TatsamState {}

class TatsamFailureState extends TatsamState {
  final String errorMsg;

  const TatsamFailureState(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
