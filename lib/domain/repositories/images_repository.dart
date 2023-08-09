import 'package:flutter/foundation.dart';

@immutable
abstract class ImagesRepository {
  const ImagesRepository();

  /// Selects image from the gallery and saves it.
  /// Saves the uploaded image url inside current user account data.
  ///
  /// Returns if image was not selected.
  /// Rethrows any error that occurs.
  Future<void> setProfilePhoto();
}
