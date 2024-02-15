import 'package:flutter/material.dart';

import '../models/movie_video_model.dart';
import '../repositories/movie_repository_impl.dart';

class MovieGetVideosProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetVideosProvider(this._movieRepository);

  MovieVideosModel? _videos;
  MovieVideosModel? get videos => _videos;

  void getVideos(BuildContext context, {required int id}) async {
    _videos = null;
    notifyListeners();
    final result = await _movieRepository.getVideos(id: id);
    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _videos = null;
        notifyListeners();
        return;
      },
      (response) {
        _videos = response;
        notifyListeners();
        return;
      },
    );
  }
}
