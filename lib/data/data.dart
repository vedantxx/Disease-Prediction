import 'package:doctor_booking_app/model/speciality.dart';
import 'package:flutter/cupertino.dart';

List<SpecialityModel> getSpeciality() {
  List<SpecialityModel> specialities = [];
  SpecialityModel specialityModel = new SpecialityModel();

  //1
  // specialityModel.noOfDoctors = 10;
  specialityModel.speciality = "Pneumonia/Chest pain";
  specialityModel.imgAssetPath = "assets/img1.png";
  specialityModel.backgroundColor = Color(0xffFBB97C);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();

  //2
  // specialityModel.noOfDoctors = 17;
  specialityModel.speciality = "Malaria Specialist";
  specialityModel.imgAssetPath = "assets/img2.png";
  specialityModel.backgroundColor = Color(0xffF69383);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();

  //3
  // specialityModel.noOfDoctors = 27;
  specialityModel.speciality = "Breast Cancer";
  specialityModel.imgAssetPath = "assets/breast_cancer.png";
  specialityModel.backgroundColor = Color(0xffEACBCB);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();

  return specialities;
}
