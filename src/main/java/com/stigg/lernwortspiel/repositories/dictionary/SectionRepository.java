package com.stigg.lernwortspiel.repositories.dictionary;

import com.stigg.lernwortspiel.enteties.dictionary.Section;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface SectionRepository extends JpaRepository<Section, UUID> {
}
