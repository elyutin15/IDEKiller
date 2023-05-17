package mirea.data;

import jakarta.transaction.Transactional;
import mirea.model.AddUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AddUserRepository extends JpaRepository<AddUser, Long> {
    public Optional<AddUser> findByIdFromAndIdTo(Long idFrom, Long idTo);
    public List<AddUser> findAllByIdTo(Long idTo);

    @Transactional
    public void deleteAllByIdFromAndIdTo(Long idFrom, Long idTo);
}
