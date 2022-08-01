mixin DomainToDataMapper<InputType, OutputType> {
  OutputType convertToData(InputType inputType);

  List<OutputType>? convertListToData(List<InputType>? inputType) {
    return inputType?.map((e) => convertToData(e)).toList();
  }
}
