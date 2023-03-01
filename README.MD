Для запроса на бекенд используется cUrl (семпл выводящий hello, world)
```
curl -X POST -H 'Content-Type: application/json' -d "{\"code\": \"public class Main{public static void main(String[] args) {System.out.println(\\\"Hello World\\\");}}\"}" http://localhost:8080
```
Для запроса на бэкэнд с вводом

Считывается одна строка, вводится "kek"

```
curl -X POST -H 'Content-Type: application/json' -d "{\"code\": {\"code\": \"import java.util.Scanner; public class Main{public static void main(String[] args){Scanner sc = new Scanner(System.in);System.out.println(sc.nextLine());}}\"},\"input\": {\"words\": \"kek\"}}" http://localhost:8080
```
Структура запроса следующая
```
json
{
  "code": {
    "code": "source code ... "
  },
  "input": {
    "words": "some data ..."
  }
}
```
