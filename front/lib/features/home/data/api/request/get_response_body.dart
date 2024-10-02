class GetResponseBody {
  final Code code;
  final Input input;

  GetResponseBody({
    required this.code,
    required this.input
  });

  Map<String, dynamic> toApi() {
    return {
      'code': code.toApi(),
      'input': input.toApi(),
    };
  }
}

class Code {
  final String code;
  final String language;

  Code(this.code, this.language);

  Map<String, dynamic> toApi() {
    return {
      'code': code,
      'language': language,
    };
  }
}

class Input {
  final String words;

  Input(this.words);

  Map<String, dynamic> toApi() {
    return {
      'words': words,
    };
  }
}