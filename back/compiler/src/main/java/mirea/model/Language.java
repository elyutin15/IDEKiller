package mirea.model;

public enum Language {
    JAVA(".java"),
    CPLUSPLUS(".cpp"),
    C(".c"),
    PYTHON(".py");

    public final String end;

    Language(String end) {
        this.end = end;
    }

    public static Language parse(String language) {
        String lower = language.toLowerCase();
        switch (lower) {
            case "java":
                return JAVA;
            case "c++":
                return CPLUSPLUS;
            case "c":
                return C;
            case "python":
                return PYTHON;
            default:
                return null;
        }
    }
}
