package io.github.t1willi.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.mail.MessagingException;

import freemarker.template.TemplateException;
import io.github.t1willi.annotations.Controller;
import io.github.t1willi.annotations.Get;
import io.github.t1willi.annotations.Post;
import io.github.t1willi.annotations.ToForm;
import io.github.t1willi.brokers.UserSupportTicketBroker;
import io.github.t1willi.core.MvcController;
import io.github.t1willi.entities.UserSupportTicket;
import io.github.t1willi.files.JoltFile;
import io.github.t1willi.form.Form;
import io.github.t1willi.http.ModelView;
import io.github.t1willi.http.ResponseEntity;
import io.github.t1willi.injector.annotation.Autowire;
import io.github.t1willi.interfaces.IEmailService;
import io.github.t1willi.interfaces.ISupportValidator;
import io.github.t1willi.security.session.Session;
import io.github.t1willi.template.JoltModel;
import io.github.t1willi.utils.Flash;
import io.github.t1willi.utils.Helper;

@Controller
public class SupportController extends MvcController {

    @Autowire
    private IEmailService _emailService;

    @Autowire
    private ISupportValidator _supportValidator;

    @Autowire
    private UserSupportTicketBroker userSupportTicketBroker;

    @Get("/support")
    public ResponseEntity<ModelView> support() {
        return render("support", JoltModel.of("username", Session.get("username")));
    }

    @Post("/support")
    public ResponseEntity<?> handleSupport(@ToForm Form form) {
        if (!userSupportTicketBroker.isIpAllowedToSubmitTicket(context.clientIp())) {
            String formattedTimeLeft = Helper
                    .formatTimeToHMS(userSupportTicketBroker.findTimeLeftToSubmitTicket(context.clientIp()));
            Flash.error(
                    "Vous avez déjà soumis une demande de support récemment. Veuillez réessayer dans "
                            + formattedTimeLeft + ".");
            return redirect("/support");
        }

        if (!_supportValidator.validateSupport(form)) {
            return render("support", JoltModel.of(
                    "errors", form.allErrors(),
                    "formData", form.buildModel()));
        }

        List<JoltFile> attachments = context.files();

        String username = form.field("username").get();
        String email = form.field("email").get();
        String message = form.field("message").get();
        String subject = form.field("subject").get();

        try {
            _emailService.sendSupportRequest(
                    "support@jolt-framework.org",
                    username,
                    email,
                    subject,
                    message,
                    attachments);

            _emailService.sendSupportContactedConfirmation(
                    email,
                    username,
                    subject,
                    message);

            Flash.success("Merci! Votre demande a bien été envoyée. Un email de confirmation vous a été adressé.");
            userSupportTicketBroker.save(UserSupportTicket.of(context.clientIp(), context.userAgent()));
            return redirect("/support");
        } catch (MessagingException | TemplateException | UnsupportedEncodingException e) {
            Flash.error("Erreur lors de l'envoi. Veuillez réessayer plus tard.");
            return render("support", JoltModel.of(
                    "formData", form.buildModel()));
        }
    }
}
