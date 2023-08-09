import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:game/common/constants/firebase_constants.dart';
import 'package:game/data/datasources/firebase_account_datasource.dart';
import 'package:game/data/models/account_model.dart';
import 'package:game/domain/repositories/images_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

@immutable
class FirebaseStorageImageRepository implements ImagesRepository {
  final FirebaseAccountDatasource _firebaseAccountDatasource;
  final Logger _logger;

  const FirebaseStorageImageRepository({
    required FirebaseAccountDatasource firebaseAccountDatasource,
    required Logger logger,
  })  : _firebaseAccountDatasource = firebaseAccountDatasource,
        _logger = logger;

  /// Selects image from the gallery and saves it in the Firebase Storage.
  /// Saves the uploaded image url inside current user account data in the Firebase Firestore.
  ///
  /// Returns if image was not selected.
  /// Rethrows any error that occurs.
  @override
  Future<void> setProfilePhoto() async {
    try {
      // Selects an image from the gallery.
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      log('selected image');

      // Returns if image was not selected
      if (image == null) return;

      // Converts image in the file.
      final File imageFile = File(image.path);

      log('converted image into file');

      // Retrieves a storage avatars reference.
      final Reference storageAvatarsRef =
          FirebaseStorage.instance.ref(FirebaseConstants.avatars);

      final String uid = const Uuid().v4();

      // Saves avatar.
      await storageAvatarsRef.child(uid).putFile(imageFile);

      log('saved image');

      // Retrieves saved avatar url.
      final String avatarUrl =
          await storageAvatarsRef.child(uid).getDownloadURL();
      
      log('loaded image url');

      // Retrieves a current user account model.
      AccountModel currentAccountModel =
          await _firebaseAccountDatasource.getCurrentAccountModel();

      // Adds an avatar url to the current user account data.
      currentAccountModel = currentAccountModel.copyWith(
        avatarLink: avatarUrl,
      );

      // Saves the updated current user account data.
      await _firebaseAccountDatasource.updateAccount(
        accountModel: currentAccountModel,
      );

      log('saved user image url');
    } catch (exeption) {
      _logger.e(exeption);
      rethrow;
    }
  }
}
