import 'package:doctor_booking_app/model/doctors_model.dart';
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

List<DoctorsModel> getDoctorsList() {
  List<DoctorsModel> doctorsList = [];
  DoctorsModel doctorsModel = new DoctorsModel();

  //1
  // specialityModel.noOfDoctors = 10;
  doctorsModel.speciality = "Pneumonia/Chest pain";
  doctorsModel.imgAssetPath = "assets/doctor_images/doc4.png";
  doctorsModel.name = "Dr Avya Bansal";
  doctorsList.add(doctorsModel);

  doctorsModel = new DoctorsModel();

  //2
  // specialityModel.noOfDoctors = 17;
  doctorsModel.speciality = "Malaria Specialist";
  doctorsModel.imgAssetPath = "assets/doctor_images/doc1.png";
  doctorsModel.name = "Dr Sallah Qureshi ";
  doctorsList.add(doctorsModel);

  doctorsModel = new DoctorsModel();

  //3
  // specialityModel.noOfDoctors = 27;
  doctorsModel.speciality = "Breast Cancer";
  doctorsModel.imgAssetPath = "assets/doctor_images/doc3.png";
  doctorsModel.name = "Dr Shravan Shetty";
  doctorsList.add(doctorsModel);

  doctorsModel = new DoctorsModel();

  doctorsModel.speciality = "Skin Cancer";
  doctorsModel.imgAssetPath = "assets/doctor_images/doc2.png";
  doctorsModel.name = "Dr. Nikita Mehta";
  doctorsList.add(doctorsModel);

  return doctorsList;
}
