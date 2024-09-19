package com.stigg.lernwortspiel.dto;

import com.stigg.lernwortspiel.enteties.dictionary.VerbType;
import com.stigg.lernwortspiel.enteties.dictionary.WordType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class WordDTO {
    private String word;
    private String translate;
    private WordType type;
    private String article;
    private String plural;
    private String thirdPerson;
    private String perfect;
    private String hilfVerb;
    private String prataritum;
    private VerbType verbType;
    private String prefix;
    private String sectionID;

    @Override
    public String toString() {
        return word + "\n" + translate + "\n" +type + "\n" +article + "\n" +plural + "\n" +thirdPerson + "\n" +perfect + "\n" +hilfVerb + "\n" +prataritum + "\n" +verbType + "\n" +prefix + "\n" + sectionID + "\n";
    }
}
