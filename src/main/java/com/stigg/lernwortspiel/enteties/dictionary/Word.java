package com.stigg.lernwortspiel.enteties.dictionary;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Setter
@Getter
@NoArgsConstructor
public abstract class Word implements Serializable {

    public Word(String word, String wordTranslate, WordType type) {
        this.word = word;
        this.wordTranslate = wordTranslate;
        this.type = type;
    }


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @Column (nullable = false, length = 40)
    private String word;
    @Column (nullable = false, length = 80)
    private String wordTranslate;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private WordType type;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "section_id")
    @JsonIgnore
    private Section section;

    @Column(nullable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        if (id == null) id = UUID.randomUUID();
        createdAt = LocalDateTime.now();
    }


    @Override
    public String toString() {
        return "|| Word : " + this.word + " || translate : " + this.wordTranslate + " ||";
    }
}
