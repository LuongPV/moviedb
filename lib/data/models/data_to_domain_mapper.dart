mixin DataToDomainMapper<InputType, OutputType> {
  OutputType convertToDomain(InputType inputType);

  List<OutputType>? convertListToDomain(List<InputType>? inputType) {
    return inputType?.map((e) => convertToDomain(e)).toList();
  }
}
