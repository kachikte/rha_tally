import 'package:get_storage/get_storage.dart';
import 'package:rha/src/domain/domain.dart';

class GeneralStorage {
  late String name;

  GetStorage box = GetStorage();

  GeneralStorage(this.name) {
    box = GetStorage(name);
  }

  // final box = GetStorage();

  writeToBox({required StorageModel storageModel}) {
    box.write(storageModel.key, storageModel.value);
  }

  readFromBox({required String key}) {
    return box.read(key);
  }

  changesToBox({required String key}) {
    box.listenKey(key, (value) {
      print('new key is $value');
      writeToBox(storageModel: StorageModel(key: key, value: value));
    });
  }

  removeBox({required String key}) {
    box.remove(key);
  }

  deleteBox() {
    box.erase();
  }
}
