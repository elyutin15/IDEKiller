package mirea.data;

import mirea.model.CodeDto;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CodeRepository extends JpaRepository<CodeDto, Long> {
    public List<CodeDto> findAllByUserid(Long userid);
}
