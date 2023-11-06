import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:theunion/components/custom_input_field.dart';
import 'package:theunion/models/user.dart';
import 'package:theunion/resources/app_config.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';
import 'package:theunion/services/common.dart';
import '../../services/functions_provider.dart';

class PatientInfo extends StatefulWidget {
  const PatientInfo({Key? key}) : super(key: key);

  @override
  State<PatientInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _townshipController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _regDateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _treatmentStartDateController =
      TextEditingController();
  final TextEditingController _VOTController = TextEditingController();

  bool isLoading = true;
  bool isDetailView = true;

  final _functionsProvider = FunctionsProvider();

// get votData from shared prefs
  VotData patient = VotData(
      address: '',
      age: 0,
      id: 0,
      name: '',
      password: '',
      regdate: '',
      serialNo: '',
      sex: '',
      township: '',
      treatmentStartDate: '',
      username: '',
      vot: true,
      votpatientid: '',
      votstatus: '');

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var tempPatientData = await _functionsProvider.getPatientInfo();
      debugPrint(tempPatientData);
      if (tempPatientData != null) {
        patient = VotData.fromRawJson(tempPatientData);

        var tempRegDate = DateTime.parse(patient.regdate);
        var formattedRegDate = DateFormat('MMM dd yyyy').format(tempRegDate);

        var tempTreatmentDate = DateTime.parse(patient.regdate);
        var formattedTreatmentDate = DateFormat('MMM dd yyyy').format(tempTreatmentDate);

        _townshipController.text = patient.township;
        _serialNumberController.text = patient.serialNo;
        _regDateController.text = formattedRegDate;
        _nameController.text = patient.name;
        _sexController.text = patient.sex;
        _ageController.text = patient.age.toString();
        _addressController.text = patient.address;
        _treatmentStartDateController.text = formattedTreatmentDate;
        _VOTController.text = patient.vot ? 'Yes' : 'No';
      }
    } catch (e) {
      showToast(ERROR_MESSAGE, ERROR_COLOR, WEB_ERROR_COLOR);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Information'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: size.width * 0.9,
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: MARGIN_MEDIUM_3),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        CustomInputField(
                            hintText: 'Township',
                            disable: isDetailView,
                            controller: _townshipController),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                          hintText: 'Serial Number',
                          controller: _serialNumberController,
                          disable: isDetailView,
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                          hintText: 'Registration Date',
                          controller: _regDateController,
                          disable: isDetailView,
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                          hintText: 'Name',
                          controller: _nameController,
                          disable: isDetailView,
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                          hintText: 'Sex',
                          controller: _sexController,
                          disable: isDetailView,
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                          hintText: 'Age',
                          controller: _ageController,
                          disable: isDetailView,
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                          hintText: 'Address',
                          controller: _addressController,
                          disable: isDetailView,
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                          hintText: 'Treatment Start Date',
                          controller: _treatmentStartDateController,
                          disable: isDetailView,
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                          hintText: 'VOT',
                          controller: _VOTController,
                          disable: isDetailView,
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
