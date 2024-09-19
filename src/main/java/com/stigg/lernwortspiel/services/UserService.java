package com.stigg.lernwortspiel.services;

import com.stigg.lernwortspiel.dto.UserRegisterDTO;
import com.stigg.lernwortspiel.enteties.EmailConfirmationToken;
import com.stigg.lernwortspiel.enteties.User;
import com.stigg.lernwortspiel.exceptions.EmailAlreadyExistException;
import com.stigg.lernwortspiel.repositories.EmailConfirmationTokenRepository;
import com.stigg.lernwortspiel.repositories.RoleRepository;
import com.stigg.lernwortspiel.repositories.UserRepository;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@Service
@AllArgsConstructor
public class UserService implements UserDetailsService {

    private final JavaMailSender mailSender;
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final EmailConfirmationTokenRepository emailConfirmationTokenRepository;
    private final PasswordEncoder passwordEncoder;

    public void registerUser(UserRegisterDTO userDTO) throws EmailAlreadyExistException {
        User newUser = User.fromDTO(userDTO, passwordEncoder, new HashSet<>(Set.of(roleRepository.findByName("ROLE_USER").orElseThrow())));

        try {
            userRepository.save(newUser);
            sendConfirmationEmail(newUser);
        } catch (DataIntegrityViolationException e) {
            throw new EmailAlreadyExistException("Email already exist");
        } catch (MessagingException e) {
            System.out.println(e.getMessage());
        }


    }

    public void sendConfirmationEmail(User user) throws MessagingException {
        EmailConfirmationToken token = new EmailConfirmationToken(user);
        emailConfirmationTokenRepository.save(token);

        // Создание MIME сообщения
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true); // true указывает на поддержку вложений

        helper.setFrom("support@lernwortspiel.de");
        helper.setTo(user.getEmail());
        helper.setSubject("Complete Registration!");

        // HTML-содержимое
        String htmlContent = "<html>" +
                "<head>" +
                "<style>" +
                "@import url('https://fonts.googleapis.com/css2?family=Luckiest+Guy&display=swap');\n" +
                "body { font-family: Arial, sans-serif; color: #333; margin: 0; padding: 0; background-color: #303030; }" +
                ".container { width: 100%; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #fff; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }" +
                "h1 {text-align:center; color: #d21c2e; font-family: \"Luckiest Guy\", cursive;" +
                "  font-weight: 400;" +
                "  font-style: normal;}" +
                "p { font-size: 16px; line-height: 1.5; }" +
                "a { color: #1a73e8; text-decoration: none; }" +
                "a:hover { text-decoration: underline; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "<div class='container'>" +
                "<h1>Confirm Your Registration</h1>" +
                "<p>Hello,</p>" +
                "<p>Thank you for registering with us. To complete your registration, please click the link below:</p>" +
                "<p><a href='https://lernwortspiel.de/confirm-account?token=" + token.getToken() + "'>Confirm your account</a></p>" +
                "<p>If you did not request this, please ignore this email.</p>" +
                "<p>Best regards,<br>The Team</p>" +
                "</div>" +
                "</body>" +
                "</html>";

        helper.setText(htmlContent, true); // true указывает на HTML-содержимое

        // Отправка сообщения
        mailSender.send(mimeMessage);
    }

    public void confirmUser(String token) {
        EmailConfirmationToken confirmationToken = emailConfirmationTokenRepository.findByToken(token).orElse(null);

        if (confirmationToken != null) {
            User user = confirmationToken.getUser();
            user.setEnabled(true);
            userRepository.save(user);
            emailConfirmationTokenRepository.delete(confirmationToken);
        }
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByEmail(username).orElseThrow(() -> new UsernameNotFoundException(username));
    }
}
