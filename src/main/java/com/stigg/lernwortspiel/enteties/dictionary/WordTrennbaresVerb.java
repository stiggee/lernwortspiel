package com.stigg.lernwortspiel.enteties.dictionary;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class WordTrennbaresVerb extends WordVerb{

    public WordTrennbaresVerb(String word, String wordTranslate, WordType type, String thirdPersonForm, String perfectForm, String hilfVerbVergangenheit, String prataritumForm, VerbType verbType, String prefix) {
        super(word, wordTranslate, type, thirdPersonForm, perfectForm, hilfVerbVergangenheit, prataritumForm, verbType);
        this.prefix = prefix;
    }

    @Column(nullable = false, length = 10)
    private String prefix;


    @Override
    public String toString() {
        String superString = super.toString();

        if (superString.endsWith("\n")) superString = superString.substring(0, superString.length() - 1);

        return superString + " prefix: " + prefix + "||\n";
    }
}
