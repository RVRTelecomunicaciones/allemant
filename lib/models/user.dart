import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/* class User extends Equatable {
  final String id;
  const User(this.id);

  @override
  List<Object> get props => [id];
}
 */
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class User extends Equatable {
  User({
    this.usuId,
    this.usuNombre,
  });

  String usuId;
  String usuNombre;

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [usuId, usuNombre];
}
