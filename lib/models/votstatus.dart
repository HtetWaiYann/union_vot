import 'dart:convert';

class VotStatus {
    String returncode;
    String message;

    VotStatus({
        required this.returncode,
        required this.message,
    });

    factory VotStatus.fromRawJson(String str) => VotStatus.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VotStatus.fromJson(Map<String, dynamic> json) => VotStatus(
        returncode: json["returncode"],
        message: json["message"],
        
    );

    Map<String, dynamic> toJson() => {
        "returncode": returncode,
        "message": message,
    };
}

class Data {
    Data();

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
    );

    Map<String, dynamic> toJson() => {
    };
}
