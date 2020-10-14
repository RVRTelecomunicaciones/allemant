import 'package:business/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'useresponse.g.dart';

@JsonSerializable(explicitToJson: true)
class Useresponse {
  bool status;
  String message;
  User user;

  Useresponse({
    this.status,
    this.message,
    this.user,
  });

  factory Useresponse.fromJson(Map<String, dynamic> data) =>
      _$UseresponseFromJson(data);

  Map<String, dynamic> toJson() => _$UseresponseToJson(this);
}
