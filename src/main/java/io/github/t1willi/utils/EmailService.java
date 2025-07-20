package io.github.t1willi.utils;

import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;
import javax.activation.DataSource;

import io.github.t1willi.dtos.EmailVerificationDTO;
import io.github.t1willi.dtos.LoginVerificationDTO;
import io.github.t1willi.dtos.PasswordResetDTO;
import io.github.t1willi.dtos.SupportContactedDTO;
import io.github.t1willi.files.JoltFile;
import io.github.t1willi.injector.annotation.Bean;
import io.github.t1willi.injector.type.InitializationMode;
import io.github.t1willi.interfaces.IEmailService;
import io.github.t1willi.server.config.ConfigurationManager;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@Bean(initialization = InitializationMode.LAZY)
public class EmailService implements IEmailService {

    private static final String UTF_8 = "UTF-8";
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");

    private final EmailConfig config;
    private final Configuration freemarkerConfig;

    public EmailService() {
        this.config = new EmailConfig();
        this.freemarkerConfig = initializeFreeMarker();
    }

    private Configuration initializeFreeMarker() {
        Configuration config = new Configuration(Configuration.VERSION_2_3_32);
        config.setClassForTemplateLoading(this.getClass(), "/templates/email");
        config.setDefaultEncoding(UTF_8);
        config.setOutputEncoding(UTF_8);
        return config;
    }

    @Override
    public void sendEmail(String to, String subject, Map<String, Object> templateData, String templateStr)
            throws MessagingException, TemplateException {
        System.out.println("Sending email to: " + to + " with subject: " + subject);
        String body = processTemplate(templateData, templateStr);
        MimeMessage message = createMessage(to, subject, body);
        Transport.send(message);
    }

    @Override
    public void sendEmailVerification(String toEmail, String userName, String verificationLink, int expiryHours)
            throws MessagingException, TemplateException {

        EmailVerificationDTO dto = new EmailVerificationDTO(userName, verificationLink, String.valueOf(expiryHours));
        Map<String, Object> templateData = createTemplateData(dto);

        String subject = "Vérification de votre adresse email - Jolt Framework";
        sendEmail(toEmail, subject, templateData, "validate_email.ftl");
    }

    @Override
    public void sendPasswordReset(String toEmail, String userName, String resetLink,
            String ipAddress, String userAgent, int expiryMinutes)
            throws MessagingException, TemplateException {

        String requestTime = getCurrentTimestamp();
        PasswordResetDTO dto = new PasswordResetDTO(
                userName, requestTime, ipAddress, userAgent, resetLink, String.valueOf(expiryMinutes));
        Map<String, Object> templateData = createTemplateData(dto);

        String subject = "Réinitialisation de votre mot de passe - Jolt Framework";
        sendEmail(toEmail, subject, templateData, "reset_password.ftl");
        System.out.println("Email de réinitialisation envoyé à " + toEmail);
    }

    @Override
    public void sendLoginVerification(String toEmail, String userName, String verificationCode,
            String ipAddress, String userAgent, int expiryMinutes)
            throws MessagingException, TemplateException {

        String loginTime = getCurrentTimestamp();
        LoginVerificationDTO dto = new LoginVerificationDTO(
                userName, loginTime, ipAddress, userAgent, verificationCode, String.valueOf(expiryMinutes));
        Map<String, Object> templateData = createTemplateData(dto);

        String subject = "Code de vérification de connexion - Jolt Framework";
        sendEmail(toEmail, subject, templateData, "email_connexion_code.ftl");
    }

    @Override
    public void sendSupportContactedConfirmation(String toEmail, String userName, String subject, String messageContent)
            throws MessagingException, TemplateException {

        String submissionTime = getCurrentTimestamp();
        SupportContactedDTO dto = new SupportContactedDTO(userName, toEmail, subject, messageContent, submissionTime);
        Map<String, Object> templateData = createTemplateData(dto);

        String emailSubject = "Confirmation de réception - Support Jolt Framework";
        sendEmail(toEmail, emailSubject, templateData, "support_contacted.ftl");
    }

    @Override
    public void sendSupportRequest(
            String toEmail,
            String userName,
            String fromEmail,
            String subject,
            String messageContent,
            List<JoltFile> attachments) throws MessagingException, TemplateException, UnsupportedEncodingException {
        Map<String, Object> templateData = new HashMap<>();
        templateData.put("userName", userName);
        templateData.put("userEmail", fromEmail);
        templateData.put("subject", subject);
        templateData.put("messageContent", messageContent);
        templateData.put("submissionTime", getCurrentTimestamp());

        String htmlBody = processTemplate(templateData, "support_request.ftl");

        setUtf8SystemProperties();
        Session session = createEmailSession();
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(config.getFromEmail(), config.getFromName(), UTF_8));
        msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(toEmail));
        msg.setSubject("Nouveau ticket de support: " + subject);

        MimeBodyPart htmlPart = new MimeBodyPart();
        htmlPart.setContent(htmlBody, "text/html; charset=UTF-8");

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(htmlPart);

        for (JoltFile file : attachments) {
            MimeBodyPart attachmentPart = new MimeBodyPart();
            DataSource ds = new ByteArrayDataSource(file.getData(), file.getContentType());
            attachmentPart.setDataHandler(new DataHandler(ds));
            attachmentPart.setFileName(file.getOriginalFilename());
            multipart.addBodyPart(attachmentPart);
        }

        msg.setContent(multipart);
        Transport.send(msg);
    }

    private String processTemplate(Map<String, Object> templateData, String templateStr) throws TemplateException {
        try {
            Template template = freemarkerConfig.getTemplate(templateStr);
            StringWriter writer = new StringWriter();
            template.process(templateData, writer);
            return writer.toString();
        } catch (Exception e) {
            throw new TemplateException("Failed to process template: " + templateStr, e, null);
        }
    }

    private MimeMessage createMessage(String to, String subject, String body) throws MessagingException {
        try {
            setUtf8SystemProperties();
            Session session = createEmailSession();

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(config.getFromEmail(), config.getFromName(), UTF_8));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setHeader("Content-Type", "text/html; charset=UTF-8");
            message.setContent(body, "text/html; charset=UTF-8");

            return message;
        } catch (Exception e) {
            throw new MessagingException("Failed to create email message: " + e.getMessage(), e);
        }
    }

    private Session createEmailSession() {
        Properties props = createEmailProperties();
        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(config.getUsername(), config.getPassword());
            }
        });
    }

    private Properties createEmailProperties() {
        Properties props = new Properties();
        props.put("mail.smtp.host", config.getHost());
        props.put("mail.smtp.port", config.getPort());
        props.put("mail.smtp.auth", config.isUseAuth());
        props.put("mail.smtp.starttls.enable", config.isUseTLS());
        props.put("mail.mime.charset", UTF_8);
        props.put("mail.mime.allowutf8", "true");
        props.put("mail.mime.encodefilename", "true");
        props.put("mail.mime.decodeparameters", "true");
        return props;
    }

    private void setUtf8SystemProperties() {
        System.setProperty("mail.mime.charset", UTF_8);
        System.setProperty("file.encoding", UTF_8);
    }

    private String getCurrentTimestamp() {
        return LocalDateTime.now().format(DATE_TIME_FORMATTER);
    }

    private Map<String, Object> createTemplateData(EmailVerificationDTO dto) {
        Map<String, Object> templateData = new HashMap<>();
        templateData.put("userName", dto.getUserName());
        templateData.put("verificationLink", dto.getVerificationLink());
        templateData.put("expiryHours", dto.getExpiryHours());
        return templateData;
    }

    private Map<String, Object> createTemplateData(PasswordResetDTO dto) {
        Map<String, Object> templateData = new HashMap<>();
        templateData.put("userName", dto.getUserName());
        templateData.put("requestTime", dto.getRequestTime());
        templateData.put("ipAddress", dto.getIpAddress());
        templateData.put("userAgent", dto.getUserAgent());
        templateData.put("resetLink", dto.getResetLink());
        templateData.put("expiryMinutes", dto.getExpiryMinutes());
        return templateData;
    }

    private Map<String, Object> createTemplateData(LoginVerificationDTO dto) {
        Map<String, Object> templateData = new HashMap<>();
        templateData.put("userName", dto.getUserName());
        templateData.put("loginTime", dto.getLoginTime());
        templateData.put("ipAddress", dto.getIpAddress());
        templateData.put("userAgent", dto.getUserAgent());
        templateData.put("verificationCode", dto.getVerificationCode());
        templateData.put("expiryMinutes", dto.getExpiryMinutes());
        return templateData;
    }

    private Map<String, Object> createTemplateData(SupportContactedDTO dto) {
        Map<String, Object> templateData = new HashMap<>();
        templateData.put("userName", dto.getUserName());
        templateData.put("userEmail", dto.getUserEmail());
        templateData.put("subject", dto.getSubject());
        templateData.put("messageContent", dto.getMessageContent());
        templateData.put("submissionTime", dto.getSubmissionTime());
        return templateData;
    }

    private static class EmailConfig {
        private final String host;
        private final String port;
        private final String username;
        private final String password;
        private final String fromEmail;
        private final String fromName;
        private final boolean useTLS;
        private final boolean useAuth;

        public EmailConfig() {
            ConfigurationManager cgm = ConfigurationManager.getInstance();
            this.host = cgm.getProperty("server.smtp.host");
            this.port = cgm.getProperty("server.smtp.port");
            this.username = cgm.getProperty("server.smtp.username");
            this.password = cgm.getProperty("server.smtp.password");
            this.fromEmail = cgm.getProperty("server.smtp.from.email");
            this.fromName = cgm.getProperty("server.smtp.from.name");
            this.useTLS = cgm.getProperty("server.smtp.use.tls", "true").equals("true");
            this.useAuth = cgm.getProperty("server.smtp.use.auth", "true").equals("true");
        }

        public String getHost() {
            return host;
        }

        public String getPort() {
            return port;
        }

        public String getUsername() {
            return username;
        }

        public String getPassword() {
            return password;
        }

        public String getFromEmail() {
            return fromEmail;
        }

        public String getFromName() {
            return fromName;
        }

        public boolean isUseTLS() {
            return useTLS;
        }

        public boolean isUseAuth() {
            return useAuth;
        }
    }
}