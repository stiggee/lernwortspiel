package com.stigg.lernwortspiel.controllers;

import com.stigg.lernwortspiel.dto.UserRegisterDTO;
import com.stigg.lernwortspiel.enteties.User;
import com.stigg.lernwortspiel.exceptions.EmailAlreadyExistException;
import com.stigg.lernwortspiel.repositories.UserRepository;
import com.stigg.lernwortspiel.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@Controller
@AllArgsConstructor
public class LoginRegisterController {

    private final UserService userService;
    private final UserRepository userRepository;


    @GetMapping("/home")
    public String home(Model model, Principal principal) {
        User user = userRepository.findByEmail(principal.getName()).get();
        model.addAttribute("user_credentials", user.getFirstName() + " " + user.getLastName());
        return "home";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("new_user", new UserRegisterDTO());
        return "register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute("new_user") UserRegisterDTO userRegisterDTO, Model model) {

//        Trying register user and catch email exist exception
        try {
            userService.registerUser(userRegisterDTO);
        } catch (EmailAlreadyExistException e){
            model.addAttribute("registerError", e.getMessage());
            return "register";
        }

        return "login";
    }

    @GetMapping("/confirm-account")
    public String confirmUserAccount(@RequestParam("token") String token) {

        userService.confirmUser(token);

        return "redirect:/login?confirmed=true";
    }
}
