package com.stigg.lernwortspiel.controllers;

import com.stigg.lernwortspiel.dto.UpdateItemRequestDTO;
import com.stigg.lernwortspiel.dto.WordDTO;
import com.stigg.lernwortspiel.enteties.dictionary.*;
import com.stigg.lernwortspiel.repositories.dictionary.BookRepository;
import com.stigg.lernwortspiel.repositories.dictionary.SectionRepository;
import com.stigg.lernwortspiel.repositories.dictionary.TopicRepository;
import com.stigg.lernwortspiel.repositories.dictionary.WordRepository;
import lombok.AllArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api")
@AllArgsConstructor
public class ApiController {

    private final BookRepository bookRepository;
    private final TopicRepository topicRepository;
    private final SectionRepository sectionRepository;
    private final WordRepository wordRepository;

    @GetMapping("/get-suggestions")
    public ResponseEntity<List<Word>> getSuggestions(@RequestParam String query) {

        return ResponseEntity.ok(wordRepository.findDistinctWordsStartingWith(query));
    }

    @GetMapping("/get-all-books")
    public ResponseEntity<List<Book>> getAllBooks() {

        return ResponseEntity.ok(bookRepository.findAll(Sort.by(Sort.Direction.ASC, "createdAt")));
    }

    @PostMapping("/add-book")
    public ResponseEntity<Book> saveBook(@RequestBody String bookTitle) {

        try {
            return ResponseEntity.ok(bookRepository.save(new Book(bookTitle)));
        } catch (DataIntegrityViolationException e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @PostMapping("/remove-book")
    public ResponseEntity<String> removeBook(@RequestBody String bookId) {

        bookRepository.deleteById(UUID.fromString(bookId));

        return ResponseEntity.ok("Book deleted successfully");
    }

    @PostMapping("/update-book/{id}")
    public ResponseEntity<String> updateBook(@PathVariable("id") String id, @RequestBody String newBookTitle) {
        Book book = bookRepository.findById(UUID.fromString(id)).orElse(null);
        book.setTitle(newBookTitle);
        try {
            bookRepository.save(book);
            return ResponseEntity.ok(newBookTitle);
        } catch (DataIntegrityViolationException e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @PostMapping("/remove-topic")
    public ResponseEntity<String> removeTopic(@RequestBody String topicId) {

        topicRepository.deleteById(UUID.fromString(topicId));
        return ResponseEntity.ok("ok");
    }

    @PostMapping("/update-topic/{id}")
    public ResponseEntity<String> updateTopic(@PathVariable("id") String id, @RequestBody String newTopicTitle) {
        Topic topic = topicRepository.findById(UUID.fromString(id)).orElse(null);
        topic.setName(newTopicTitle);
        topicRepository.save(topic);

        return ResponseEntity.ok(newTopicTitle);
    }

    @PostMapping("/update-section/{id}")
    public ResponseEntity<String> updateSection(@PathVariable("id") String id, @RequestBody String newSectionTitle) {
        Section section = sectionRepository.findById(UUID.fromString(id)).orElse(null);
        section.setName(newSectionTitle);
        sectionRepository.save(section);
        return ResponseEntity.ok(newSectionTitle);
    }

    @PostMapping("/remove-section")
    public ResponseEntity<String> removeSection(@RequestBody String topicId) {

        sectionRepository.deleteById(UUID.fromString(topicId));
        return ResponseEntity.ok("ok");
    }

    @PostMapping("/remove-word")
    public ResponseEntity<String> removeWord(@RequestBody String wordID) {
        wordRepository.deleteById(UUID.fromString(wordID));
        return ResponseEntity.ok("ok");
    }
    @PostMapping("/add-topic")
    public ResponseEntity<Topic> addTopic(@RequestBody UpdateItemRequestDTO item) {

        Book book = bookRepository.findById(UUID.fromString(item.getItemID())).orElse(null);
        Topic topic = new Topic(item.getItemTitle());
        topic.setBook(book);

        return ResponseEntity.ok(topicRepository.save(topic));
    }

    @PostMapping("/add-section")
    public ResponseEntity<Section> addSection(@RequestBody UpdateItemRequestDTO item) {

        Topic topic = topicRepository.findById(UUID.fromString(item.getItemID())).orElse(null);
        Section section = new Section(item.getItemTitle());
        section.setTopic(topic);

        return ResponseEntity.ok(sectionRepository.save(section));
    }

    @PostMapping("/add-word")
    public ResponseEntity<Word> addWord(@RequestBody WordDTO wordDTO) {
        Word word = null;

        if (wordDTO.getType() == WordType.NOUN){
            word = new WordNoun(wordDTO.getWord(), wordDTO.getTranslate(), WordType.NOUN, wordDTO.getArticle(), wordDTO.getPlural());
        }else if (wordDTO.getType() == WordType.VERB){
            word = new WordVerb(wordDTO.getWord(), wordDTO.getTranslate(), WordType.VERB, wordDTO.getThirdPerson(), wordDTO.getPerfect(), wordDTO.getHilfVerb(), wordDTO.getPrataritum(), wordDTO.getVerbType());
        } else if (wordDTO.getType() == WordType.TRENNBARES_VERB) {
            word = new WordTrennbaresVerb(wordDTO.getWord(), wordDTO.getTranslate(), WordType.TRENNBARES_VERB, wordDTO.getThirdPerson(), wordDTO.getPerfect(), wordDTO.getHilfVerb(), wordDTO.getPrataritum(), wordDTO.getVerbType(), wordDTO.getPrefix());
        } else if (wordDTO.getType() == WordType.ADJECTIVE){
            word = new WordAdjective(wordDTO.getWord(), wordDTO.getTranslate(),WordType.ADJECTIVE);
        }

        Section section = sectionRepository.findById(UUID.fromString(wordDTO.getSectionID())).orElse(null);
        word.setSection(section);


        return ResponseEntity.ok(wordRepository.save(word));
    }

}
