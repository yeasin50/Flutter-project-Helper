import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'contact_profile.model.freezed.dart';
part 'contact_profile.model.g.dart';

@freezed
class ContactProfile with _$ContactProfile {
  @JsonSerializable(explicitToJson: true)
  factory ContactProfile({
    @ContactConverter() @JsonKey(name: "contact") required Contact contact,
    bool? isChecked,
  }) = _ContactProfile;

  factory ContactProfile.empty() => ContactProfile(
        contact: Contact(),
        isChecked: false,
      );

  factory ContactProfile.fromJson(Map<String, dynamic> json) =>
      _$ContactProfileFromJson(json);
}

class ContactConverter
    implements JsonConverter<Contact, Map<dynamic, dynamic>> {
  const ContactConverter();

  @override
  Contact fromJson(Map<dynamic, dynamic> json) {
    return Contact.fromMap(json);
  }

  @override
  Map<dynamic, dynamic> toJson(Contact object) {
    //TODO:: later
    return object.toMap();
  }
}
