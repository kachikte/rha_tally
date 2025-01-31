import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rha/src/config/app_colors.dart';
import 'package:rha/src/data/data.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/domain/models/app_user_model.dart';
import 'package:rha/src/domain/models/user_profile_model.dart';
import 'package:rha/src/presentation/controllers/user_image_controller.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:rha/src/utils/stored_keys.dart';
import 'package:rha/src/utils/util_functions.dart';

class ProfileController extends GetxController {
  InitDb initDb = InitDb();

  RxBool modeSwitch = false.obs;
  Rx<double> userLat = 0.0.obs;
  Rx<double> userLng = 0.0.obs;

  UserImageController userImageController = Get.put(UserImageController());

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();

  // TextEditingController usernameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController genderController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController documentUrlController = TextEditingController();
  TextEditingController documentCategoryController = TextEditingController();

  //User data
  UserProfileImpl userProfileImpl = UserProfileImpl();

  // Rx<AppUserModel> appUserModel = AppUserModel.empty().obs;
  AppUserModel appUserModel = AppUserModel.empty();

  late PackageInfo packageInfo;
  GeneralStorage rememberMeGeneralStorage =
      GeneralStorage(StoredKeys.REMEMBERME);

  // GeneralStorage usernameGeneralStorage = GeneralStorage(StoredKeys.USERNAME);
  GeneralStorage emailGeneralStorage = GeneralStorage(StoredKeys.EMAIL);
  GeneralStorage firstNameGeneralStorage = GeneralStorage(StoredKeys.FIRSTNAME);
  GeneralStorage lastNameGeneralStorage = GeneralStorage(StoredKeys.LASTNAME);
  GeneralStorage phoneGeneralStorage = GeneralStorage(StoredKeys.PHONE);
  GeneralStorage userImageGeneralStorage = GeneralStorage(StoredKeys.IMAGE);
  GeneralStorage genderGeneralStorage = GeneralStorage(StoredKeys.GENDER);

  GeneralStorage roleGeneralStorage = GeneralStorage(StoredKeys.ROLE);
  GeneralStorage brandGeneralStorage = GeneralStorage(StoredKeys.BRAND);
  GeneralStorage modelGeneralStorage = GeneralStorage(StoredKeys.MODEL);
  GeneralStorage yearGeneralStorage = GeneralStorage(StoredKeys.YEAR);
  GeneralStorage colorGeneralStorage = GeneralStorage(StoredKeys.COLOR);
  GeneralStorage plateNumberGeneralStorage =
      GeneralStorage(StoredKeys.PLATENUMBER);
  GeneralStorage documentCategoryGeneralStorage =
      GeneralStorage(StoredKeys.DOCUMENTCATEGORY);

  // GeneralStorage uniqueTokenGeneralStorage =
  //     GeneralStorage(StoredKeys.UNIQUETOKEN);
  // GeneralStorage subscriptionStatusGeneralStorage =
  //     GeneralStorage(StoredKeys.UNIQUETOKEN);

  initEditProfile() {
    // firstNameController.text = appUserModel.value.firstName;
    // lastNameController.text = appUserModel.value.lastName;
    // emailAddressController.text = appUserModel.value.email;
    // usernameController.text = appUserModel.value.username;
    // phoneNumberController.text = appUserModel.value.phone;
    //
    // countryCodeController.text = appUserModel.value.countryCode;
    // streetNumberController.text = appUserModel.value.streetNumber;
    // streetNameController.text = appUserModel.value.streetName;
    // mapController.text = appUserModel.value.map;
    // cityController.text = appUserModel.value.city;
    // stateController.text = appUserModel.value.state;
    // countryController.text = appUserModel.value.country;
    firstNameController.text = appUserModel.firstName.value;
    lastNameController.text = appUserModel.lastName.value;
    emailAddressController.text = appUserModel.email.value;
    roleController.text = appUserModel.roleId.value;
    phoneNumberController.text = appUserModel.phone.value;

    genderController.text = appUserModel.gender.value;
    brandController.text = appUserModel.brand.value;
    modelController.text = appUserModel.model.value;
    yearController.text = appUserModel.year.value;
    colorController.text = appUserModel.color.value;
    plateNumberController.text = appUserModel.plateNumber.value;
    documentCategoryController.text = appUserModel.documentCategory.value;
    documentUrlController.text = appUserModel.imageUrl.value;
  }

  disposeEditProfile() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailAddressController.dispose();
    roleController.dispose();
    phoneNumberController.dispose();

    genderController.dispose();
    brandController.dispose();
    modelController.dispose();
    yearController.dispose();
    colorController.dispose();
    plateNumberController.dispose();
    documentUrlController.dispose();
    documentCategoryController.dispose();
  }

  getFullName() {
    // String fullName = "${appUserModel.value.firstName} ${appUserModel.value.lastName}";
    String fullName =
        "${appUserModel.firstName.value} ${appUserModel.lastName.value}";

    return fullName;
  }

  getProfile(
      {required String authorization, required String accessToken}) async {
    ResponseModel responseModel = await userProfileImpl.getProfile(
        authorization: authorization, accessToken: accessToken);
    return responseModel;
  }

  setProfileValues(
      {required UserProfileModel userProfileModel,
      // required String userImage,
      required String uniqueKey}) {
    // uniqueTokenGeneralStorage.writeToBox(
    //     storageModel:
    //         StorageModel(key: StoredKeys.UNIQUETOKEN, value: uniqueKey));
    roleGeneralStorage.writeToBox(
        storageModel:
            StorageModel(key: StoredKeys.ROLE, value: userProfileModel.roleId));
    emailGeneralStorage.writeToBox(
        storageModel:
            StorageModel(key: StoredKeys.EMAIL, value: userProfileModel.email));
    firstNameGeneralStorage.writeToBox(
        storageModel: StorageModel(
            key: StoredKeys.FIRSTNAME, value: userProfileModel.firstName));
    lastNameGeneralStorage.writeToBox(
        storageModel: StorageModel(
            key: StoredKeys.LASTNAME, value: userProfileModel.lastName));
    phoneGeneralStorage.writeToBox(
        storageModel:
            StorageModel(key: StoredKeys.PHONE, value: userProfileModel.phone));
    genderGeneralStorage.writeToBox(
        storageModel: StorageModel(
            key: StoredKeys.GENDER, value: userProfileModel.gender));
    userImageGeneralStorage.writeToBox(
        storageModel: StorageModel(
            key: StoredKeys.IMAGE, value: userProfileModel.documentUrl ?? ""));

    brandGeneralStorage.writeToBox(
        storageModel:
            StorageModel(key: StoredKeys.BRAND, value: userProfileModel.brand));
    modelGeneralStorage.writeToBox(
        storageModel:
            StorageModel(key: StoredKeys.MODEL, value: userProfileModel.model));
    yearGeneralStorage.writeToBox(
        storageModel:
            StorageModel(key: StoredKeys.YEAR, value: userProfileModel.year));
    colorGeneralStorage.writeToBox(
        storageModel:
            StorageModel(key: StoredKeys.COLOR, value: userProfileModel.color));
    plateNumberGeneralStorage.writeToBox(
        storageModel: StorageModel(
            key: StoredKeys.PLATENUMBER, value: userProfileModel.plateNumber));
    documentCategoryGeneralStorage.writeToBox(
        storageModel: StorageModel(
            key: StoredKeys.DOCUMENTCATEGORY,
            value: userProfileModel.documentCategory ?? ''));
    // image.writeToBox(
    //     storageModel: StorageModel(
    //         key: StoredKeys.STATUS, value: userProfileModel.status));
    // subscriptionStatusGeneralStorage.writeToBox(
    //     storageModel: StorageModel(
    //         key: StoredKeys.SUBSCRIPTIONSTATUS,
    //         value: userProfileModel.subscriptionStatus));
  }

  deleteLocalStorage({required bool isRememberMe}) {
    if (!isRememberMe) {
      emailGeneralStorage.deleteBox();
      // ticketController.openTicketGeneralStorage.deleteBox();
      // ticketController.openTicketCountGeneralStorage.deleteBox();
    }
    // uniqueTokenGeneralStorage.removeBox(key: StoredKeys.UNIQUETOKEN);
    // emailGeneralStorage.removeBox(key: StoredKeys.EMAIL);
    firstNameGeneralStorage.removeBox(key: StoredKeys.FIRSTNAME);
    lastNameGeneralStorage.removeBox(key: StoredKeys.LASTNAME);
    phoneGeneralStorage.removeBox(key: StoredKeys.PHONE);
    roleGeneralStorage.removeBox(key: StoredKeys.ROLE);
    userImageGeneralStorage.removeBox(key: StoredKeys.IMAGE);

    genderGeneralStorage.removeBox(key: StoredKeys.GENDER);
    brandGeneralStorage.removeBox(key: StoredKeys.BRAND);
    modelGeneralStorage.removeBox(key: StoredKeys.MODEL);
    yearGeneralStorage.removeBox(key: StoredKeys.YEAR);
    colorGeneralStorage.removeBox(key: StoredKeys.COLOR);
    plateNumberGeneralStorage.removeBox(key: StoredKeys.PLATENUMBER);
    documentCategoryGeneralStorage.removeBox(key: StoredKeys.DOCUMENTCATEGORY);
    // subscriptionStatusGeneralStorage.removeBox(
    //     key: StoredKeys.SUBSCRIPTIONSTATUS);
  }

  deleteSecuredStorage({required bool isRememberMe}) async {
    if (!isRememberMe) {
      await SecuredStorage.deleteAll();
    } else {
      await SecuredStorage.delete(key: StoredKeys.TOKEN);
      await SecuredStorage.delete(key: StoredKeys.AUTH);
    }
  }

  logout({required bool isRememberMe}) async {
    String? token = await SecuredStorage.readData(key: StoredKeys.TOKEN);
    String? auth = await SecuredStorage.readData(key: StoredKeys.AUTH);

    ResponseModel responseModel =
        await userProfileImpl.logout(authorization: auth!, accessToken: token!);

    if (responseModel.isError) {
      return false;
    } else {
      deleteLocalStorage(isRememberMe: isRememberMe);
      await deleteSecuredStorage(isRememberMe: isRememberMe);
      await initDb.closeDB();
      return true;
    }
  }

  delete() async {
    String? token = await SecuredStorage.readData(key: StoredKeys.TOKEN);
    String? auth = await SecuredStorage.readData(key: StoredKeys.AUTH);

    ResponseModel responseModel =
        await userProfileImpl.delete(authorization: auth!, accessToken: token!);

    if (responseModel.isError) {
      return false;
    } else {
      deleteLocalStorage(isRememberMe: false);
      await deleteSecuredStorage(isRememberMe: false);
      await initDb.closeDB();
      return true;
    }
  }

  getRememberMeValue() {
    bool rememberMe =
        rememberMeGeneralStorage.readFromBox(key: StoredKeys.REMEMBERME) == null
            ? false
            : true;
    return rememberMe;
  }

  getUsernameValue() {
    String username =
        emailGeneralStorage.readFromBox(key: StoredKeys.EMAIL) ?? "";
    return username;
  }

  getProfileValues() {
    bool rememberMe =
        rememberMeGeneralStorage.readFromBox(key: StoredKeys.REMEMBERME) == null
            ? false
            : true;
    log('This is the remember me -- $rememberMe');
    String role = roleGeneralStorage.readFromBox(key: StoredKeys.ROLE);
    // log('This is the email -- $email');
    String phone = phoneGeneralStorage.readFromBox(key: StoredKeys.PHONE);
    String email = emailGeneralStorage.readFromBox(key: StoredKeys.EMAIL);
    String imageUrl =
        userImageGeneralStorage.readFromBox(key: StoredKeys.IMAGE);
    String lastName =
        lastNameGeneralStorage.readFromBox(key: StoredKeys.LASTNAME);
    String firstName =
        firstNameGeneralStorage.readFromBox(key: StoredKeys.FIRSTNAME);
    String gender = genderGeneralStorage.readFromBox(key: StoredKeys.GENDER);

    String brand = brandGeneralStorage.readFromBox(key: StoredKeys.BRAND);
    String model = modelGeneralStorage.readFromBox(key: StoredKeys.MODEL);
    String year = yearGeneralStorage.readFromBox(key: StoredKeys.YEAR);
    String color = colorGeneralStorage.readFromBox(key: StoredKeys.COLOR);
    String plateNumber =
        plateNumberGeneralStorage.readFromBox(key: StoredKeys.PLATENUMBER);
    String documentCategory = documentCategoryGeneralStorage.readFromBox(
        key: StoredKeys.DOCUMENTCATEGORY);

    // AppUserModel appUserModel = AppUserModel(
    //     firstName: firstName,
    //     lastName: lastName,
    //     username: username,
    //     email: email,
    //     phone: phone,
    //     countryCode: countryCode,
    //     status: status,
    //     isFibreCustomer: true,
    //     streetNumber: streetNumber,
    //     streetName: streetName,
    //     city: city,
    //     country: country,
    //     state: state,
    //     rememberMe: rememberMe,
    //     imageUrl: imageUrl,
    //     uniqueToken: uniqueToken,
    //     map: map);

    AppUserModel appUserModel = AppUserModel(
      firstName: firstName.obs,
      lastName: lastName.obs,
      email: email.obs,
      phone: phone.obs,
      imageUrl: imageUrl.obs,
      color: color.obs,
      plateNumber: plateNumber.obs,
      brand: brand.obs,
      documentCategory: documentCategory.obs,
      gender: gender.obs,
      model: model.obs,
      roleId: role.obs,
      year: year.obs,
    );

    // this.appUserModel = appUserModel.obs;
    this.appUserModel = appUserModel;
  }

  getAppInfo() async {
    packageInfo = await UtilFunctions.getAppInfo();
  }

  copyButton({required String username, required Size size}) {
    return ElevatedButton(
      onPressed: () {
        UtilFunctions.copyToClipBoard(data: username);
        UtilFunctions.getSnack(
            title: "Copied",
            message: "Username copied",
            colorText: AppColors.lightBackgroundColor,
            backgroundColor: AppColors.tallyColor);
      },
      style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.width * 0.07))),
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(38, 35, 36, 1))),
      child: Text(username),
    );
  }

  changePassword(
      {required String oldPassword, required String newPassword}) async {
    String? token = await SecuredStorage.readData(key: StoredKeys.TOKEN);
    String? auth = await SecuredStorage.readData(key: StoredKeys.AUTH);

    ResponseModel responseModel = await userProfileImpl.changePassword(
        authorization: auth!,
        accessToken: token!,
        newPassword: newPassword,
        oldPassword: oldPassword);

    return responseModel;
  }

// editProfile(BuildContext context) async {
  //   var imageUrl = '';
  //
  //   // if (context.mounted) {
  //   //   UtilFunctions.showOverLay(context);
  //   // }
  //
  //   try {
  //     if (userImageController.userImageFile.path.isNotEmpty) {
  //       print("this is the image path === ${userImageController.imagePath}");
  //       ResponseModel responseModel = await firebaseResourceImpl
  //           .uploadUserImage(userImageFile: userImageController.userImageFile);
  //
  //       if (responseModel.isError) {
  //         UtilFunctions.getSnack(
  //             title: "Error",
  //             message: "Error Uploading Image",
  //             colorText: AppColors.lightBackgroundColor,
  //             backgroundColor: AppColors.tallyColor);
  //         return;
  //       }
  //
  //       imageUrl = responseModel.data;
  //     }
  //
  //     print('This is the url === $imageUrl');
  //
  //     ResponseModel responseModelUpdateImage =
  //         await firebaseResourceImpl.updateUserImage(imageUrl: imageUrl);
  //
  //     if (responseModelUpdateImage.isError) {
  //       UtilFunctions.getSnack(
  //           title: "Error",
  //           message: "Error Updating Image",
  //           colorText: AppColors.lightBackgroundColor,
  //           backgroundColor: AppColors.tallyColor);
  //       return;
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  //
  //   String? authorization = await SecuredStorage.readData(key: StoredKeys.AUTH);
  //   String? accessToken = await SecuredStorage.readData(key: StoredKeys.TOKEN);
  //
  //   UserProfileDto userProfileDto = UserProfileDto(
  //     phoneNumber: phoneNumberController.text,
  //     countryCode: countryCodeController.text,
  //     firstName: firstNameController.text,
  //     lastName: lastNameController.text,
  //     streetNumber: streetNumberController.text,
  //     streetName: streetNameController.text,
  //     city: cityController.text,
  //     map: mapController.text,
  //     state: stateController.text,
  //     country: countryController.text,
  //   );
  //
  //   ResponseModel responseModel = await userProfileImpl.updateProfile(
  //       authorization: authorization!,
  //       accessToken: accessToken!,
  //       userProfileDto: userProfileDto);
  //
  //   if (context.mounted) {
  //     UtilFunctions.hideOverLay(context);
  //   }
  //
  //   if (responseModel.isError) {
  //     UtilFunctions.getSnack(
  //         title: "Error Updating Profile",
  //         message: responseModel.data.toString(),
  //         colorText: AppColors.lightBackgroundColor,
  //         backgroundColor: AppColors.tallyColor);
  //   } else {
  //     // UserProfileModel userProfileModel = UserProfileModel(
  //     //     firstName: firstNameController.text,
  //     //     lastName: lastNameController.text,
  //     //     username: usernameController.text,
  //     //     email: emailAddressController.text,
  //     //     phone: phoneNumberController.text,
  //     //     countryCode: countryCodeController.text,
  //     //     status: appUserModel.value.status,
  //     //     isFibreCustomer: appUserModel.value.isFibreCustomer,
  //     //     streetNumber: streetNumberController.text,
  //     //     streetName: streetNumberController.text,
  //     //     city: cityController.text,
  //     //     map: mapController.text,
  //     //     country: countryController.text,
  //     //     state: stateController.text);
  //     UserProfileModel userProfileModel = UserProfileModel(
  //         firstName: firstNameController.text,
  //         lastName: lastNameController.text,
  //         username: usernameController.text,
  //         email: emailAddressController.text,
  //         phone: phoneNumberController.text,
  //         countryCode: countryCodeController.text,
  //         status: appUserModel.status.value,
  //         isFibreCustomer: appUserModel.isFibreCustomer.value,
  //         streetNumber: streetNumberController.text,
  //         streetName: streetNumberController.text,
  //         city: cityController.text,
  //         map: mapController.text,
  //         country: countryController.text,
  //         state: stateController.text,
  //         subscriptionStatus: appUserModel.subscriptionStatus.value);
  //
  //     // setProfileValues(userProfileModel: userProfileModel, userImage: imageUrl, uniqueKey: appUserModel.value.uniqueToken);
  //     setProfileValues(
  //         userProfileModel: userProfileModel,
  //         uniqueKey: ""
  //         // userImage: imageUrl,
  //         // uniqueKey: appUserModel.uniqueToken.value
  //     );
  //
  //     getProfileValues();
  //     print('This is the url 222 === $imageUrl');
  //     Get.off(() => ProfileScreen());
  //     UtilFunctions.getSnack(
  //         title: "Successful!",
  //         message: "Profile Updated",
  //         colorText: AppColors.lightBackgroundColor,
  //         backgroundColor: AppColors.lightGrey);
  //   }
  // }

  editOnline(BuildContext context) async {

    String? accessToken = await SecuredStorage.readData(key: StoredKeys.TOKEN);

    ResponseModel responseModel = await userProfileImpl.updateOnline(
        accessToken: accessToken!,
        isOnline: modeSwitch.value);

    if (context.mounted) {
      UtilFunctions.hideOverLay(context);
    }

    if (responseModel.isError) {
      UtilFunctions.getSnack(
          title: "Error Updating Online status",
          message: responseModel.data.toString(),
          colorText: AppColors.lightBackgroundColor,
          backgroundColor: AppColors.tallyColor);
    } else {
      UtilFunctions.getSnack(
          title: "Successful!",
          message: "Online status Updated",
          colorText: AppColors.lightBackgroundColor,
          backgroundColor: AppColors.appGreen);
    }
  }

  editLocation(BuildContext context) async {

    String? accessToken = await SecuredStorage.readData(key: StoredKeys.TOKEN);

    ResponseModel responseModel = await userProfileImpl.updateLocation(
        accessToken: accessToken!,
        lat: userLat.value,
        lng: userLng.value);

    if (context.mounted) {
      UtilFunctions.hideOverLay(context);
    }

    if (responseModel.isError) {
      UtilFunctions.getSnack(
          title: "Error Updating Location",
          message: responseModel.data.toString(),
          colorText: AppColors.lightBackgroundColor,
          backgroundColor: AppColors.tallyColor);
    } else {
      // UtilFunctions.getSnack(
      //     title: "Successful!",
      //     message: "Location Updated",
      //     colorText: AppColors.lightBackgroundColor,
      //     backgroundColor: AppColors.appGreen);
    }
  }
}
