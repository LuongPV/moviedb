abstract class BaseMapper<InputType, OutputType> {
  OutputType convert(InputType inputType);

  List<OutputType>? convertList(List<InputType>? inputType) {
    return inputType?.map((e) => convert(e)).toList();
  }
}
