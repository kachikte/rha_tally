import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class UserImageController extends GetxController {

  String imagePath = "";
  Rx<File?> pickedImage = File('/').obs;
  RxBool isPicker = false.obs;
  RxBool isFirstImage = true.obs;
  late File userImageFile;

  fileFromImageUrl(String imageUrl) async {
    print("entering file from image");
    final response = await http.get(Uri.parse(imageUrl));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, 'imagetest.png'));

    file.writeAsBytesSync(response.bodyBytes);
    print("leaving file from image");

    return file;
  }

  void imagePickerCamera() async {
    isPicker.value = true;
    isFirstImage.value = false;

    var imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    final lostFile = await imagePicker.retrieveLostData();

    if (lostFile.file != null) {

      pickedImage.value = File(lostFile.file!.path);

      pickedImageFunc(File(lostFile.file!.path));

      return;
    }

    if (!pickedImageFile.isNull) {
      pickedImage.value = File(pickedImageFile!.path);

      pickedImageFunc(File(pickedImageFile.path));

      return;
    }
  }

  void imagePickerGallery() async {
    isPicker.value = true;
    isFirstImage.value = false;

    final pickedImageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (!pickedImageFile.isNull) {
      pickedImage.value = File(pickedImageFile!.path);

      pickedImageFunc(File(pickedImageFile.path));
    }
  }

  File imageNotChanged(File image) {
    pickedImageFunc(image);
    return image;
  }

  void clearImage() {
    isFirstImage.value = false;
    pickedImage.value = File("");
    // widget.url = "";
    pickedImageFunc(File(""));
  }

  void pickedImageFunc(File image) {
    print('I should be entering here === ${image.path}');
    imagePath = image.path;
    userImageFile = image;
    print('I should be outing here === ${userImageFile.path}');
  }

}