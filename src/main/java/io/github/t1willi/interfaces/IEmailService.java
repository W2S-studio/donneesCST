package io.github.t1willi.interfaces;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;
import javax.mail.MessagingException;
import freemarker.template.TemplateException;
import io.github.t1willi.files.JoltFile;

/**
 * Interface for email service operations
 */
public interface IEmailService {

        /**
         * Sends an email using a template
         * 
         * @param to           Email recipient
         * @param subject      Email subject
         * @param templateData Data to populate the template
         * @param templateStr  Template file name
         * @throws MessagingException if email sending fails
         * @throws TemplateException  if template processing fails
         */
        void sendEmail(String to, String subject, Map<String, Object> templateData, String templateStr)
                        throws MessagingException, TemplateException;

        /**
         * Sends email verification email
         * 
         * @param toEmail          Recipient email
         * @param userName         User's name
         * @param verificationLink Verification URL
         * @param expiryHours      Expiry time in hours
         * @throws MessagingException if email sending fails
         * @throws TemplateException  if template processing fails
         */
        void sendEmailVerification(String toEmail, String userName, String verificationLink, int expiryHours)
                        throws MessagingException, TemplateException;

        /**
         * Sends password reset email
         * 
         * @param toEmail       Recipient email
         * @param userName      User's name
         * @param resetLink     Password reset URL
         * @param ipAddress     User's IP address
         * @param userAgent     User's browser info
         * @param expiryMinutes Expiry time in minutes
         * @throws MessagingException if email sending fails
         * @throws TemplateException  if template processing fails
         */
        void sendPasswordReset(String toEmail, String userName, String resetLink,
                        String ipAddress, String userAgent, int expiryMinutes)
                        throws MessagingException, TemplateException;

        /**
         * Sends login verification code email
         * 
         * @param toEmail          Recipient email
         * @param userName         User's name
         * @param verificationCode Verification code
         * @param ipAddress        User's IP address
         * @param userAgent        User's browser info
         * @param expiryMinutes    Expiry time in minutes
         * @throws MessagingException if email sending fails
         * @throws TemplateException  if template processing fails
         */
        void sendLoginVerification(String toEmail, String userName, String verificationCode,
                        String ipAddress, String userAgent, int expiryMinutes)
                        throws MessagingException, TemplateException;

        /**
         * Sends a support request email with optional attachments to the support team.
         *
         * @param toEmail        Support team email address
         * @param userName       Name of the user
         * @param fromEmail      Email address of the user
         * @param subject        Subject of the support message
         * @param messageContent Body of the support message
         * @param attachments    List of uploaded files
         * @throws MessagingException if email sending fails
         * @throws TemplateException  if template processing fails
         */
        void sendSupportRequest(
                        String toEmail,
                        String userName,
                        String fromEmail,
                        String subject,
                        String messageContent,
                        List<JoltFile> attachments)
                        throws MessagingException, TemplateException, UnsupportedEncodingException;

        /**
         * Sends support contact confirmation email
         * 
         * @param toEmail        Recipient email
         * @param userName       User's name
         * @param subject        Original message subject
         * @param messageContent Original message content
         * @throws MessagingException if email sending fails
         * @throws TemplateException  if template processing fails
         */
        void sendSupportContactedConfirmation(String toEmail, String userName, String subject, String messageContent)
                        throws MessagingException, TemplateException;
}
