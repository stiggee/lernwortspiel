package com.stigg.lernwortspiel.configs;

import com.stigg.lernwortspiel.enteties.Role;
import com.stigg.lernwortspiel.enteties.User;
import com.stigg.lernwortspiel.enteties.dictionary.*;
import com.stigg.lernwortspiel.filters.RedirectFilter;
import com.stigg.lernwortspiel.repositories.EmailConfirmationTokenRepository;
import com.stigg.lernwortspiel.repositories.RoleRepository;
import com.stigg.lernwortspiel.repositories.UserRepository;
import com.stigg.lernwortspiel.repositories.dictionary.BookRepository;
import com.stigg.lernwortspiel.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.session.FindByIndexNameSessionRepository;
import org.springframework.session.Session;
import org.springframework.session.security.SpringSessionBackedSessionRegistry;
import org.springframework.session.security.web.authentication.SpringSessionRememberMeServices;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


@Configuration
@EnableWebSecurity
@AllArgsConstructor
public class WebSecurityConfig {

    private FindByIndexNameSessionRepository<? extends Session> sessionRepository;
    private final JavaMailSender mailSender;
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final EmailConfirmationTokenRepository emailConfirmationTokenRepository;
    private final BookRepository bookRepository;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests((requests) -> requests
                        .requestMatchers(PathRequest.toStaticResources().atCommonLocations()).permitAll()  // access to static resources
                        .requestMatchers("/", "/login", "/logout", "/register", "/confirm-account").permitAll()
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .requestMatchers("/api/**").permitAll()
                        .anyRequest().authenticated()
                )
                .formLogin((session) -> session
                        .loginPage("/login")
                        .defaultSuccessUrl("/home",true)
                        .failureUrl("/login?error=true")
                        .permitAll()
                )
                .rememberMe((rememberMe) -> rememberMe
                        .rememberMeServices(rememberMeServices())
                )
                .sessionManagement(session -> session
                        .maximumSessions(1)
                        .maxSessionsPreventsLogin(false)
                        .sessionRegistry(sessionRegistry())
                )
                .logout((logout) -> logout
                        .logoutUrl("/logout")
                        .invalidateHttpSession(true)
                        .permitAll());

        http.addFilterBefore(new RedirectFilter(), UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }

    //  My UserDetailsService
    @Bean
    public UserDetailsService userDetailsService() {
        return new UserService(mailSender,userRepository,roleRepository,emailConfirmationTokenRepository, passwordEncoder());
    }


    //  Auth provider for db user details storage
    @Bean
    public AuthenticationProvider daoAuthenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService());
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    //    Password encoder
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // Session registry for session management
    @Bean
    public SpringSessionBackedSessionRegistry<? extends Session> sessionRegistry() {
        return new SpringSessionBackedSessionRegistry<>(this.sessionRepository);
    }


    @Bean
    public SpringSessionRememberMeServices rememberMeServices() {
        SpringSessionRememberMeServices rememberMeServices =
                new SpringSessionRememberMeServices();
        // optionally customize
        rememberMeServices.setRememberMeParameterName("remember-me");
        rememberMeServices.setAlwaysRemember(false);
        return rememberMeServices;
    }

//        UserInit
    @Bean
    public ApplicationRunner initializer(UserRepository userRepository) {
        return args -> {

//            Role role_admin = new Role("ROLE_ADMIN");
//            Role role_user = new Role("ROLE_USER");
//
//            User user_admin = new User(passwordEncoder().encode("280211"), "katyshev.yevhen@gmail.com", "Yevhen", "Katyshev", "+380680595514",
//                                        true, true, true,true, LocalDate.of(1997,2,28), new HashSet<>(Set.of(role_admin,role_user)));
//
//            roleRepository.save(role_user);
//            roleRepository.save(role_admin);
//            userRepository.save(user_admin);
//
//            Book book = new Book("A1.1");
//
//            Topic topic1 = new Topic("Nach Deutschland kommen");
//            Topic topic2 = new Topic("Aller Anfang ist schwer");
//            Topic topic3 = new Topic("Den Käse");
//
//            Section section1 = new Section("A");
//            Section section2 = new Section("B");
//            Section section3 = new Section("C");
//            Section section4 = new Section("A");
//            Section section5 = new Section("B");
//            Section section6 = new Section("C");
//            Section section7 = new Section("A");
//            Section section8 = new Section("B");
//            Section section9 = new Section("C");
//
//            WordNoun wordNoun1 = new WordNoun("Apfel", "Яблуко", WordType.NOUN, "der", "Aepfel");
//            WordNoun wordNoun2 = new WordNoun("Birne", "Груша", WordType.NOUN, "die", "Birnen");
//            WordNoun wordNoun3 = new WordNoun("Tisch", "Стіл", WordType.NOUN, "der", "Tischen");
//
//            WordVerb wordVerb1 = new WordVerb("fahren", "їхати", WordType.VERB, "faehrt", "gefahren", "ist", "fuhr", VerbType.UNREGELMASIG);
//            WordVerb wordVerb2 = new WordVerb("machen", "робити", WordType.VERB, "macht", "gemacht", "hat", "machte", VerbType.REGELMASIG);
//            WordVerb wordVerb3 = new WordVerb("trinken", "пити", WordType.VERB, "trinkt", "getrunken", "hat", "trank", VerbType.REGELMASIG);
//
//            WordAdjective wordAdjective1 = new WordAdjective("hübsch", "красивий", WordType.ADJECTIVE);
//            WordAdjective wordAdjective2 = new WordAdjective("schmal", "тонкий", WordType.ADJECTIVE);
//            WordAdjective wordAdjective3 = new WordAdjective("breit", "широкий", WordType.ADJECTIVE);
//
//            WordTrennbaresVerb wordTrennbaresVerb1 = new WordTrennbaresVerb("machen", "домовлятись", WordType.TRENNBARES_VERB, "macht", "abgemacht", "hat", "machte ab", VerbType.REGELMASIG, "ab");
//            WordTrennbaresVerb wordTrennbaresVerb2 = new WordTrennbaresVerb("schneiden", "", WordType.TRENNBARES_VERB, "schneidet", "abgeschnitten", "hat", "schnitte ab", VerbType.REGELMASIG, "ab");
//
//            book.setTopics(List.of(topic1, topic2, topic3));
//
//            topic1.setBook(book);
//            topic2.setBook(book);
//            topic3.setBook(book);
//
//            topic1.setSections(List.of(section1, section2, section3));
//            topic2.setSections(List.of(section4, section5, section6));
//            topic3.setSections(List.of(section7, section8, section9));
//
//            section1.setTopic(topic1);
//            section2.setTopic(topic1);
//            section3.setTopic(topic1);
//
//            section4.setTopic(topic2);
//            section5.setTopic(topic2);
//            section6.setTopic(topic2);
//
//            section7.setTopic(topic3);
//            section8.setTopic(topic3);
//            section9.setTopic(topic3);
//
//            section1.setWords(List.of(wordAdjective1));
//            section2.setWords(List.of(wordNoun1));
//            section3.setWords(List.of(wordVerb1));
//            section4.setWords(List.of(wordTrennbaresVerb1));
//            section5.setWords(List.of(wordAdjective2));
//            section6.setWords(List.of(wordAdjective3));
//            section7.setWords(List.of(wordNoun2));
//            section8.setWords(List.of(wordVerb2));
//            section9.setWords(List.of(wordNoun3));
//
//// Add reverse relationships from words to sections
//            wordAdjective1.setSection(section1);
//            wordAdjective2.setSection(section5);
//            wordAdjective3.setSection(section6);
//
//            wordNoun1.setSection(section2);
//            wordNoun2.setSection(section7);
//            wordNoun3.setSection(section9);
//
//            wordVerb1.setSection(section3);
//            wordVerb2.setSection(section8);
//            wordVerb3.setSection(section9);
//
//            wordTrennbaresVerb1.setSection(section4);
//            wordTrennbaresVerb2.setSection(section6);
//
//            bookRepository.save(book);
        };
    }

}