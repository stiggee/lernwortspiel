package com.stigg.lernwortspiel.repositories.dictionary;

import com.stigg.lernwortspiel.enteties.dictionary.WordVerb;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface WordVerbRepository extends JpaRepository<WordVerb, UUID> {
}
