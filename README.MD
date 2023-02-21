Для запроса на бекенд используется cUrl (семпл выводящий hello, world)
```
curl -X POST -H 'Content-Type: application/json' -d "{\"code\": \"public class Main{public static void main(String[] args) {System.out.println(\\\"Hello World\\\");}}\"}" http://localhost:8080
```
