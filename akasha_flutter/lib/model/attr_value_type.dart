enum AttributeValueType {
  text,
  number,
  boolean,
  date,
  dateTime,
}

extension AttributeValueTypeLabel on AttributeValueType {
  String get label {
    switch (this) {
      case AttributeValueType.text:
        return 'Text';
      case AttributeValueType.number:
        return 'Number';
      case AttributeValueType.boolean:
        return 'Boolean';
      case AttributeValueType.date:
        return 'Date';
      case AttributeValueType.dateTime:
        return 'DateTime';
    }
  }
}
