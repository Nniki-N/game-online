import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/common/errors/profile_avatar_error.dart';
import 'package:game/domain/repositories/images_repository.dart';
import 'package:game/presentation/bloc/profile_avatar_bloc/profile_avatar_event.dart';
import 'package:game/presentation/bloc/profile_avatar_bloc/profile_avatar_state.dart';

class ProfileAvatarBloc extends Bloc<ProfileAvatarEvent, ProfileAvatarState> {
  final ImagesRepository _imagesRepository;

  ProfileAvatarBloc({required ImagesRepository imagesRepository})
      : _imagesRepository = imagesRepository,
        super(const InitialProfileAvatarState()) {
    on<SetNewPhotoProfileAvatarEvent>(_setNewPhoto);
  }

  /// Sets a new profile photo.
  Future<void> _setNewPhoto(
    SetNewPhotoProfileAvatarEvent event,
    Emitter<ProfileAvatarState> emit,
  ) async {
    try {
      emit(const SelectingPictureProfileAvatarState());

      // final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

      // if (image == null) return;

      // final File imageTemp = File(image.path);

      await _imagesRepository.setProfilePhoto();

      emit(const InitialProfileAvatarState());
    } on PlatformException {
      emit(const ErrorProfileAvatarState(
        profileAvatarError: ProfileAvatarErrorSelectingPhoto(),
      ));
    } catch (exeption) {
      emit(const ErrorProfileAvatarState(
        profileAvatarError: ProfileAvatarErrorSelectingPhoto(),
      ));
    }
  }
}
