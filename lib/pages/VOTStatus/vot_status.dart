import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/custom_button.dart';
import '../../components/custom_dropdown.dart';
import '../../network/api.dart';
import '../../resources/app_config.dart';
import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../../services/common.dart';
import '../../services/functions_provider.dart';
import 'Components/validator.dart';

class VOTStatus extends StatefulWidget {
  const VOTStatus({super.key});

  @override
  State<VOTStatus> createState() => _VOTStatusState();
}

class _VOTStatusState extends State<VOTStatus> {
  final _functionsProvider = FunctionsProvider();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  RefreshController _refreshController = RefreshController();

  final SingleValueDropDownController _votStatusController =
      SingleValueDropDownController();

  bool isLoading = false;
  bool isRefreshing = false;

  String votStatus = '-';

  List<DropDownValueModel> votStatusList = [
    const DropDownValueModel(name: '-', value: ''),
    const DropDownValueModel(name: 'Successful', value: '001'),
    const DropDownValueModel(name: 'Unsuccessful', value: '002'),
  ];

  @override
  void initState() {
    super.initState();
    _getVOTStatus();
  }

  _getVOTStatus() async {
    var tempVOTStatus = await _functionsProvider.getVOTStatus();
    debugPrint('tempVOTStatus: $tempVOTStatus');
    votStatus = tempVOTStatus;
    if (tempVOTStatus == '001') {
      debugPrint('tempVOTStatus 1');
      _votStatusController.dropDownValue =
          const DropDownValueModel(name: 'Successful', value: '001');
    } else if (tempVOTStatus == '002') {
      debugPrint('tempVOTStatus 2');
      _votStatusController.dropDownValue =
          const DropDownValueModel(name: 'Unsuccessful', value: '002');
    } else {
      debugPrint('tempVOTStatus ---');
      _votStatusController.dropDownValue =
          const DropDownValueModel(name: '-', value: '');
    }
    setState(() {
      
    });
  }

  _submitBtnClick(context) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        await API().updateVOTStatus(votStatus);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var tempPatientData = await _functionsProvider.getPatientInfo();
        tempPatientData = jsonDecode(tempPatientData);
        tempPatientData['votstatus'] = votStatus;
        prefs.setString('info', jsonEncode(tempPatientData));

        showToast(SUCCESS_MESSAGE, SUCCESS_COLOR, WEB_SUCCESS_COLOR);
      } catch (e) {
        showToast(e.toString(), ERROR_COLOR, WEB_ERROR_COLOR);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VOT Status',
        ),
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
                        CustomDropdown(
                          label: 'Status',
                          selectedValue: votStatus,
                          itemsList: votStatusList,
                          onChange: (val) => {
                            setState(() {
                              votStatus = val.value;
                            })
                          },
                          controller: _votStatusController,
                          validator: (val) =>
                              Validator.validateDropdownField(votStatus),
                        ),
                        const SizedBox(
                          height: MARGIN_MEDIUM_4,
                        ),
                        CustomButton(
                          text: "Submit",
                          loading: isLoading,
                          press: () {
                            if (_key.currentState?.validate() == true) {
                              _submitBtnClick(context);
                            }
                          },
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
    ;
  }
}

class RefreshController {}
