package com.stigg.lernwortspiel.enteties.dictionary;

import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class WordAdjective extends Word{

    public WordAdjective(String word, String wordTranslate, WordType type) {
        super(word, wordTranslate, type);
    }

    @Override
    public String toString() {
        return super.toString() + "\n";
    }
}
