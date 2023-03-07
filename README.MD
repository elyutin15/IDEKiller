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


Запрос на регистрацию и логин имеют одинаковую структуру
```
json
{
  "name": "...",
  "email": "...",
  "password": "..."
}
```

```
curl -X POST -H 'Content-Type: application/json' -d "{\"name\":\"abc\", \"email\":\"abc@mail.ru\", \"password\":\"12345\"}" http://localhost:8080/login
curl -X POST -H 'Content-Type: application/json' -d "{\"name\":\"abc\", \"email\":\"abc@mail.ru\", \"password\":\"12345\"}" http://localhost:8080/registration
```
