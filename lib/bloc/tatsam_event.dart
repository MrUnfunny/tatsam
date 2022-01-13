part of 'tatsam_bloc.dart';

abstract class TatsamEvent extends Equatable {
  const TatsamEvent();

  @override
  List<Object> get props => [];
}

class TatsamGetAllCountriesEvent extends TatsamEvent {}

class TatsamAddToFavoritesEvent extends TatsamEvent {
  final Country country;
  final List<Country> countries;

  const TatsamAddToFavoritesEvent(this.country, this.countries);

  @override
  List<Object> get props => [countries, country];
}

class TatsamRemoveFromFavoritesEvent extends TatsamEvent {
  final Country country;
  final List<Country> countries;

  const TatsamRemoveFromFavoritesEvent(this.country, this.countries);

  @override
  List<Object> get props => [countries, country];
}

class TatsamGetAllFavoritesEvent extends TatsamEvent {}
