import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/models/complaint/complaint_model.dart';

class ComplaintsController extends GetxController {
  var complaintsPerPage = 4;
  var currentPage = 1.obs;
  var selectedPage = 1.obs;
  var complaints = <ComplaintModel>[].obs;

  List<ComplaintModel> initialComplaints = [
    ComplaintModel(
        tenant: 'Ramesh D',
        description: 'Water tank leackage',
        sevierity: Colors.green),
    ComplaintModel(
        tenant: 'Cabin K',
        description: 'Elivator shaking',
        sevierity: Colors.purpleAccent),
    ComplaintModel(
        tenant: 'Tylor S',
        description: 'Parking area is',
        sevierity: Colors.orange),
    ComplaintModel(
        tenant: 'Micheal J',
        description: 'No water since mon',
        sevierity: Colors.red),
    ComplaintModel(
        tenant: 'Cabin D',
        description: 'Water tank leackage',
        sevierity: Colors.green),
    ComplaintModel(
        tenant: 'Cabin K',
        description: 'Elivator shaking',
        sevierity: Colors.purpleAccent),
    ComplaintModel(
        tenant: 'Tylor S',
        description: 'Parking area is',
        sevierity: Colors.orange),
    ComplaintModel(
        tenant: 'Micheal J',
        description: 'No water since mon',
        sevierity: Colors.red),
    ComplaintModel(
        tenant: 'Taylor D',
        description: 'Water tank leackage',
        sevierity: Colors.green),
    ComplaintModel(
        tenant: 'Cabin K',
        description: 'Elivator shaking',
        sevierity: Colors.purpleAccent),
    ComplaintModel(
        tenant: 'Tylor S',
        description: 'Parking area is',
        sevierity: Colors.orange),
    ComplaintModel(
        tenant: 'Micheal J',
        description: 'No water since mon',
        sevierity: Colors.red),
    ComplaintModel(
        tenant: 'Micheal D',
        description: 'Water tank leackage',
        sevierity: Colors.green),
    ComplaintModel(
        tenant: 'Cabin K',
        description: 'Elivator shaking',
        sevierity: Colors.purpleAccent),
    ComplaintModel(
        tenant: 'Tylor S',
        description: 'Parking area is',
        sevierity: Colors.orange),
    ComplaintModel(
        tenant: 'Micheal J',
        description: 'No water since mon',
        sevierity: Colors.red),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }

  void fetchData() {
    final start = (currentPage.value - 1) * complaintsPerPage;
    final end = start + complaintsPerPage;
    // final data = List.generate(totalComplaints, (index) => 'rian complaint $index');
    complaints.value = initialComplaints.getRange(start, end).toList();
  }

  void goToPage(int page) {
    currentPage.value = page;
    selectedPage.value = page;
    fetchData();
  }
}
