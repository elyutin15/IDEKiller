package mirea.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.transaction.Transactional;
import mirea.data.AddUserRepository;
import mirea.data.UserIdRepository;
import mirea.data.UsersRepository;
import mirea.model.AddUser;
import mirea.model.User;
import mirea.model.UserId;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Tag(name="Контроллер работы cо студентами и учителями пользователя")
@RestController
public class SubscriberController {

    Logger log = LoggerFactory.getLogger(SubscriberController.class);

    @Autowired
    UsersRepository usersRepo;

    @Autowired
    AddUserRepository addUserRepo;

    @Autowired
    UserIdRepository userIdRepo;

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Успех"),
            @ApiResponse(responseCode = "500", description = "Ошибка на сервере"),
            @ApiResponse(responseCode = "400", description = "Ошибка клиентского запроса")
    })
    @Operation(
            summary = "Запрос пользователя с idFrom подписаться на idTo"
    )
    @CrossOrigin(origins = {"${frontend.url}"})
    @PostMapping("/subscriber/add")
    public ResponseEntity addSubscriber(@RequestBody AddUser dto) {
        Optional<User> optFrom, optTo;
        try {
            optFrom = usersRepo.findById(dto.getIdFrom());
            optTo = usersRepo.findById(dto.getIdTo());
            if (optFrom.isEmpty() || optTo.isEmpty()) {
                return new ResponseEntity(HttpStatus.BAD_REQUEST);
            }
            User from = optFrom.get(), to = optTo.get();
            for (UserId userid : to.getStudents()) {
                if (userid.getId().equals(from.getId())) {
                    return new ResponseEntity(HttpStatus.BAD_REQUEST);
                }
            }
            Optional<AddUser> exist = addUserRepo.findByIdFromAndIdTo(dto.getIdFrom(), dto.getIdTo());
            if (exist.isPresent()) {
                return new ResponseEntity(HttpStatus.BAD_REQUEST);
            }
            addUserRepo.save(dto);
            return new ResponseEntity(HttpStatus.OK);
        } catch (Exception e) {
            log.error(e.toString());
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Успех"),
            @ApiResponse(responseCode = "500", description = "Ошибка на сервере"),
    })
    @Operation(
            summary = "Получить все запросы на подписку для пользователя с id"
    )
    @CrossOrigin(origins = {"${frontend.url}"})
    @GetMapping("/subscriber/{id}")
    public ResponseEntity<List<UserId>> getAllSubscribers(@PathVariable Long id) {

        try {
            final List<AddUser> subscribers = addUserRepo.findAllByIdTo(id);
            final List<UserId> userIds = subscribers.stream()
                    .map(i -> userIdRepo.findById(i.getIdTo()).orElse(null))
                    .filter(Objects::nonNull)
                    .toList();
            return new ResponseEntity<>(userIds, HttpStatus.OK);
        } catch (Exception e) {
            log.error(e.toString());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Успех"),
            @ApiResponse(responseCode = "500", description = "Ошибка на сервере"),
            @ApiResponse(responseCode = "400", description = "Ошибка на клиенте")
    })
    @Operation(
            summary = "Принятие пользователем с idTo запроса на подписку от пользователя с idFrom"
    )
    @Transactional
    @CrossOrigin(origins = {"${frontend.url}"})
    @PostMapping("/subscriber/accept")
    public ResponseEntity acceptSubscriber(@RequestBody AddUser dto) {
        try {
            Optional<AddUser> optAddUser = addUserRepo.findByIdFromAndIdTo(dto.getIdFrom(), dto.getIdTo());
            if (optAddUser.isEmpty()) {
                return new ResponseEntity(HttpStatus.BAD_REQUEST);
            }
            AddUser addUser = optAddUser.get();
            addUserRepo.deleteById(addUser.getId());
            User from = usersRepo.findById(addUser.getIdFrom()).get();
            User to = usersRepo.findById(addUser.getIdTo()).get();
            from.getTeachers().add(new UserId(to.getId(), to.getName()));
            to.getStudents().add(new UserId(from.getId(), from.getName()));
            usersRepo.save(from);
            usersRepo.save(to);
            return new ResponseEntity(HttpStatus.OK);
        } catch (Exception e) {
            log.error(String.valueOf(e.toString()));
            return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }
}
