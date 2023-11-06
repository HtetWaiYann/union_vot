import 'dart:convert';

class UserResponse {
    String returncode;
    String message;
    Data? data;

    UserResponse({
        required this.returncode,
        required this.message,
        this.data,
    });

    factory UserResponse.fromRawJson(String str) => UserResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        returncode: json["returncode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "returncode": returncode,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String token;
    String userid;
    VotData? votData;

    Data({
        required this.token,
        required this.userid,
        this.votData,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        userid: json["userid"],
        votData: json["votData"] == null ? null : VotData.fromJson(json["votData"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "userid": userid,
        "votData": votData?.toJson(),
    };
}


class VotData {
    int id;
    String votpatientid;
    String name;
    int age;
    String sex;
    String township;
    String address;
    String regdate;
    String serialNo;
    String treatmentStartDate;
    bool vot;
    String username;
    String password;
    String votstatus;

    VotData({
        required this.id,
        required this.votpatientid,
        required this.name,
        required this.age,
        required this.sex,
        required this.township,
        required this.address,
        required this.regdate,
        required this.serialNo,
        required this.treatmentStartDate,
        required this.vot,
        required this.username,
        required this.password,
        required this.votstatus,
    });

    factory VotData.fromRawJson(String str) => VotData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VotData.fromJson(Map<String, dynamic> json) => VotData(
        id: json["id"],
        votpatientid: json["votpatientid"],
        name: json["name"],
        age: json["age"],
        sex: json["sex"],
        township: json["township"],
        address: json["address"],
        regdate: json["regdate"],
        serialNo: json["serialNo"],
        treatmentStartDate: json["treatmentStartDate"],
        vot: json["vot"],
        username: json["username"],
        password: json["password"],
        votstatus: json["votstatus"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "votpatientid": votpatientid,
        "name": name,
        "age": age,
        "sex": sex,
        "township": township,
        "address": address,
        "regdate": regdate,
        "serialNo": serialNo,
        "treatmentStartDate": treatmentStartDate,
        "vot": vot,
        "username": username,
        "password": password,
        "votstatus":votstatus,
    };
}