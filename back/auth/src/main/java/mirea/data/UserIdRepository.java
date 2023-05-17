package mirea.data;

import mirea.model.UserId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserIdRepository extends JpaRepository<UserId, Long> {
}
