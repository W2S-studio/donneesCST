package io.github.t1willi.utils;

import java.io.ByteArrayInputStream;
import java.io.StringWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import io.github.t1willi.configuration.EmailConfiguration;
import io.github.t1willi.dtos.EmailVerificationDTO;
import io.github.t1willi.dtos.LoginVerificationDTO;
import io.github.t1willi.dtos.PasswordResetDTO;
import io.github.t1willi.dtos.SupportContactedDTO;
import io.github.t1willi.files.JoltFile;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.injector.type.InitializationMode;
import io.github.t1willi.interfaces.IEmailService;

import javax.mail.MessagingException;
import java.io.UnsupportedEncodingException;

@Bean(initialization = InitializationMode.LAZY)
public class EmailService implements IEmailService {
    private static final String UTF_8 = "UTF-8";
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");

    private final EmailConfiguration mailgunConfig;
    private final Configuration freemarker;

    public EmailService() {
        this.mailgunConfig = new EmailConfiguration.Builder()
                .fromProperties();

        this.freemarker = new Configuration(Configuration.VERSION_2_3_32);
        this.freemarker.setClassForTemplateLoading(getClass(), "/templates/email");
        this.freemarker.setDefaultEncoding(UTF_8);
        this.freemarker.setOutputEncoding(UTF_8);
    }

    @Override
    public void sendEmail(String to, String subject,
            Map<String, Object> templateData,
            String templateStr)
            throws MessagingException, TemplateException {
        String html = processTemplate(templateData, templateStr);
        sendViaMailgun(to, subject, html, null);
    }

    @Override
    public void sendEmailVerification(String toEmail,
            String userName,
            String verificationLink,
            int expiryHours)
            throws MessagingException, TemplateException {

        EmailVerificationDTO dto = new EmailVerificationDTO(
                userName, verificationLink, String.valueOf(expiryHours));
        sendEmail(toEmail,
                "Vérification de votre adresse email - Jolt Framework",
                createTemplateData(dto),
                "validate_email.ftl");
    }

    @Override
    public void sendPasswordReset(String toEmail,
            String userName,
            String resetLink,
            String ipAddress,
            String userAgent,
            int expiryMinutes)
            throws MessagingException, TemplateException {
        PasswordResetDTO dto = new PasswordResetDTO(
                userName,
                LocalDateTime.now().format(DATE_TIME_FORMATTER),
                ipAddress,
                userAgent,
                resetLink,
                String.valueOf(expiryMinutes));
        sendEmail(toEmail,
                "Réinitialisation de votre mot de passe - Jolt Framework",
                createTemplateData(dto),
                "reset_password.ftl");
    }

    @Override
    public void sendLoginVerification(String toEmail,
            String userName,
            String verificationCode,
            String ipAddress,
            String userAgent,
            int expiryMinutes)
            throws MessagingException, TemplateException {
        LoginVerificationDTO dto = new LoginVerificationDTO(
                userName,
                LocalDateTime.now().format(DATE_TIME_FORMATTER),
                ipAddress,
                userAgent,
                verificationCode,
                String.valueOf(expiryMinutes));
        sendEmail(toEmail,
                "Code de vérification de connexion - Jolt Framework",
                createTemplateData(dto),
                "email_connexion_code.ftl");
    }

    @Override
    public void sendSupportContactedConfirmation(String toEmail,
            String userName,
            String subject,
            String messageContent)
            throws MessagingException, TemplateException {
        SupportContactedDTO dto = new SupportContactedDTO(
                userName, toEmail, subject, messageContent,
                LocalDateTime.now().format(DATE_TIME_FORMATTER));
        sendEmail(toEmail,
                "Confirmation de réception - Support Jolt Framework",
                createTemplateData(dto),
                "support_contacted.ftl");
    }

    @Override
    public void sendSupportRequest(String toEmail,
            String userName,
            String fromEmail,
            String subject,
            String messageContent,
            List<JoltFile> attachments)
            throws MessagingException, TemplateException, UnsupportedEncodingException {
        Map<String, Object> data = Map.of(
                "userName", userName,
                "userEmail", fromEmail,
                "subject", subject,
                "messageContent", messageContent,
                "submissionTime", LocalDateTime.now().format(DATE_TIME_FORMATTER));
        String html = processTemplate(data, "support_request.ftl");
        sendViaMailgun(toEmail,
                "Nouveau ticket de support: " + subject,
                html,
                attachments);
    }

    private String processTemplate(Map<String, Object> d, String tpl)
            throws TemplateException {
        try {
            Template t = freemarker.getTemplate(tpl);
            StringWriter w = new StringWriter();
            t.process(d, w);
            return w.toString();
        } catch (Exception e) {
            throw new TemplateException("Failed to render " + tpl, e, null);
        }
    }

    private void sendViaMailgun(String to,
            String subject,
            String html,
            List<JoltFile> attachments)
            throws MessagingException {
        try {

            System.out.println("→ Mailgun endpoint: https://api.mailgun.net/v3/"
                    + mailgunConfig.getHost() + "/messages");
            System.out.println("→ Mailgun API key: " + mailgunConfig.getApiKey());
            System.out.println("→ From: "
                    + mailgunConfig.getFromName() + " <"
                    + mailgunConfig.getFromEmail() + ">");

            var req = Unirest.post("https://api.mailgun.net/v3/"
                    + mailgunConfig.getHost()
                    + "/messages")
                    .basicAuth("api", mailgunConfig.getApiKey())
                    .field("from",
                            String.format("%s <%s>",
                                    mailgunConfig.getFromName(), mailgunConfig.getFromEmail()))
                    .field("to", to)
                    .field("subject", subject)
                    .field("html", html);

            if (attachments != null) {
                for (JoltFile f : attachments) {
                    req.field("attachment",
                            new ByteArrayInputStream(f.getData()),
                            f.getOriginalFilename());
                }
            }

            HttpResponse<String> rsp = req.asString();
            int status = rsp.getStatus();
            String body = rsp.getBody();

            System.out.println("Email sent via Mailgun: " + body);

            if (status < 200 || status >= 300) {
                throw new MessagingException(
                        "Mailgun API error [" + status + "]: " + body);
            }

        } catch (UnirestException e) {
            System.err.println("Failed to send email via Mailgun: " + e.getMessage());
            throw new MessagingException("Mailgun API error: " + e.getMessage(), e);
        }
    }

    private Map<String, Object> createTemplateData(EmailVerificationDTO dto) {
        return Map.of(
                "userName", dto.getUserName(),
                "verificationLink", dto.getVerificationLink(),
                "expiryHours", dto.getExpiryHours());
    }

    private Map<String, Object> createTemplateData(PasswordResetDTO dto) {
        return Map.of(
                "userName", dto.getUserName(),
                "requestTime", dto.getRequestTime(),
                "ipAddress", dto.getIpAddress(),
                "userAgent", dto.getUserAgent(),
                "resetLink", dto.getResetLink(),
                "expiryMinutes", dto.getExpiryMinutes());
    }

    private Map<String, Object> createTemplateData(LoginVerificationDTO dto) {
        return Map.of(
                "userName", dto.getUserName(),
                "loginTime", dto.getLoginTime(),
                "ipAddress", dto.getIpAddress(),
                "userAgent", dto.getUserAgent(),
                "verificationCode", dto.getVerificationCode(),
                "expiryMinutes", dto.getExpiryMinutes());
    }

    private Map<String, Object> createTemplateData(SupportContactedDTO dto) {
        return Map.of(
                "userName", dto.getUserName(),
                "userEmail", dto.getUserEmail(),
                "subject", dto.getSubject(),
                "messageContent", dto.getMessageContent(),
                "submissionTime", dto.getSubmissionTime());
    }
}
