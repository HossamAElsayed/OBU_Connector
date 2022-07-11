import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String name;
  final String? imgUrl;

  const User(this.uid, this.name, [this.imgUrl]);
  static const empty = User('', '', '');
  get isEmpty => uid.isEmpty && name.isEmpty;

  @override
  List<Object?> get props => [uid, name, imgUrl];

  Map<String, dynamic> toMap() {
    return {
      'id': uid,
      'name': name,
      'imgUrl': imgUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['id'] ?? '',
      map['name'] ?? '',
      map['imgUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? imgUrl,
  }) {
    return User(
      id ?? uid,
      name ?? this.name,
      imgUrl ?? this.imgUrl,
    );
  }

  @override
  String toString() => 'User(id: $uid, name: $name, imgUrl: $imgUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.uid == uid &&
        other.name == name &&
        other.imgUrl == imgUrl;
  }

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ imgUrl.hashCode;
}
