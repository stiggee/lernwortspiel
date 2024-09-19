package com.stigg.lernwortspiel.repositories.dictionary;


import com.stigg.lernwortspiel.enteties.dictionary.Word;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;
import java.util.UUID;

@Repository
public interface WordRepository extends JpaRepository<Word, UUID> {
    List<Word> findByWordStartingWith(String prefix);

    @Query("SELECT w FROM Word w WHERE w.id IN (SELECT MIN(w2.id) FROM Word w2 WHERE w2.word LIKE CONCAT(:prefix, '%') GROUP BY w2.word)")
    List<Word> findDistinctWordsStartingWith(@Param("prefix") String prefix);





}
