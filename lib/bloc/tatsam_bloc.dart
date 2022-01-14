import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam/models/country.dart';
import 'package:tatsam/repositories/tatsam_repo.dart';

part 'tatsam_event.dart';
part 'tatsam_state.dart';

class TatsamBloc extends Bloc<TatsamEvent, TatsamState> {
  _mapTatsamGetAllCountriesEventToState(
      TatsamGetAllCountriesEvent event, Emitter<TatsamState> emit) async {
    try {
      final _countries = await TatsamRepo.loadAllCountries();
      _countries.sort(
          ((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())));
      emit(
          TatsamAllCountriesLoadedState(_countries, Random().nextInt(1000000)));
    } on SocketException {
      emit(TatsamInternetFailureState());
    } catch (e) {
      emit(TatsamFailureState(e.toString()));
    }
  }

  _mapTatsamAddToFavoritesEventToState(
      TatsamAddToFavoritesEvent event, Emitter<TatsamState> emit) async {
    try {
      await TatsamRepo.addToFavorites(event.country);

      var countries = event.countries;
      countries.remove((event.country));
      countries.add(event.country.copyWith(favorite: true));
      countries.sort(
          ((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())));

      emit(TatsamAddedToFavoritesState(countries, Random().nextInt(1000000)));
    } on SocketException {
      emit(TatsamInternetFailureState());
    } catch (e) {
      emit(TatsamFailureState(e.toString()));
    }
  }

  _mapTatsamRemoveFromFavoritesEventToState(
      TatsamRemoveFromFavoritesEvent event, Emitter<TatsamState> emit) async {
    try {
      await TatsamRepo.removeFromFavorites(event.country);

      var countries = event.countries;
      countries.remove((event.country));
      countries.add(event.country.copyWith(favorite: false));
      countries.sort(
          ((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())));

      emit(TatsamRemovedFromFavoritesState(
          countries, Random().nextInt(1000000)));
    } on SocketException {
      emit(TatsamInternetFailureState());
    } catch (e) {
      emit(TatsamFailureState(e.toString()));
    }
  }

  _mapTatsamGetAllFavoritesEventToState(
      TatsamGetAllFavoritesEvent event, Emitter<TatsamState> emit) {
    try {
      var countries = TatsamRepo.getAllFavorites();

      countries.sort(
          ((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())));

      emit(TatsamLoadedAllFavoritesState(countries, Random().nextInt(1000000)));
    } on SocketException {
      emit(TatsamInternetFailureState());
    } catch (e) {
      emit(TatsamFailureState(e.toString()));
    }
  }

  _mapTatsamRemoveAllFromFavoritesEventToState(
      TatsamRemoveAllFromFavoritesEvent event,
      Emitter<TatsamState> emit) async {
    try {
      await TatsamRepo.removeAllFromFavorites();

      add(TatsamGetAllCountriesEvent());
    } on SocketException {
      emit(TatsamInternetFailureState());
    } catch (e) {
      emit(TatsamFailureState(e.toString()));
    }
  }

  TatsamBloc() : super(TatsamInitial()) {
    on<TatsamGetAllCountriesEvent>(_mapTatsamGetAllCountriesEventToState);
    on<TatsamAddToFavoritesEvent>(_mapTatsamAddToFavoritesEventToState);
    on<TatsamRemoveFromFavoritesEvent>(
        _mapTatsamRemoveFromFavoritesEventToState);
    on<TatsamGetAllFavoritesEvent>(_mapTatsamGetAllFavoritesEventToState);
    on<TatsamRemoveAllFromFavoritesEvent>(
        _mapTatsamRemoveAllFromFavoritesEventToState);
  }
}
