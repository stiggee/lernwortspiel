package com.stigg.lernwortspiel.enteties.dictionary;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Setter
@Getter
@Entity
@NoArgsConstructor
public class WordNoun extends Word{

    public WordNoun(String word, String wordTranslate, WordType type, String article, String pluralForm) {
        super(word, wordTranslate, type);
        this.article = article;
        this.pluralForm = pluralForm;
    }

    private String article;
    private String pluralForm;


    @Override
    public String toString() {
        return super.toString() + " || article : " + article + "  || Pluralform : " + pluralForm + " ||\n";
    }
}
