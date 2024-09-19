package com.stigg.lernwortspiel.enteties.dictionary;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class WordVerb extends Word{

    public WordVerb(String word, String wordTranslate, WordType type, String thirdPersonForm, String perfectForm, String hilfVerbVergangenheit, String prataritumForm, VerbType verbType) {
        super(word, wordTranslate, type);
        this.thirdPersonForm = thirdPersonForm;
        this.perfectForm = perfectForm;
        this.hilfVerbVergangenheit = hilfVerbVergangenheit;
        this.prataritumForm = prataritumForm;
        this.verbType = verbType;
    }

    private String thirdPersonForm;
    private String perfectForm;
    private String hilfVerbVergangenheit;
    private String prataritumForm;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private VerbType verbType;


    @Override
    public String toString() {
        return super.toString() + " || thirdPersonForm : " + this.thirdPersonForm + " || hilfVerb : " + this.hilfVerbVergangenheit + " || perfectForm : " + this.perfectForm +
                                    " || prataritumForm : " + this.prataritumForm + " || verbType : " + this.verbType + " ||\n";

    }
}
