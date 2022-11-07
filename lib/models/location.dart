import 'package:flutter/material.dart';

class LocationModel {
  /// Initialize the instance of the [Model] class.
  const LocationModel(this.state, this.color, this.stateCode);

  /// Represents the Australia state name.
  final String state;

  /// Represents the Australia state color.
  final Color color;

  /// Represents the Australia state code.
  final String stateCode;
}