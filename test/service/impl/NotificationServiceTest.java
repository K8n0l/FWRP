package service.impl;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import java.util.List;
import org.junit.Before;
import org.junit.Test;
import dao.AlertDao;
import dao.impl.AlertDaoImpl;
import entity.User;
import service.NotificationService;
import util.ContactType;
import util.UserType;

public class NotificationServiceTest {

    private NotificationService notificationService;
    private AlertDao alertDao;

    @Before
    public void setUp() {
        alertDao = new AlertDaoImpl();
        notificationService = new NotificationServiceImpl();
    }

    @Test
    public void testSendNotificationEmail() {
        // Set up a user and send an email notification
        User user = new User(1, "sampleUser", "securePassword", UserType.CUSTOMER, "9876543210", "sample@example.com", true);
        String message = "Sample email message";
        ContactType contactType = ContactType.EMAIL;

        notificationService.sendNotification(user, message, contactType);

        // Verify that the notification was sent and stored
        List<String> notifications = notificationService.getNotifications(user.getId());
        assertTrue(notifications.contains(message));
    }

    @Test
    public void testSendNotificationText() {
        // Set up a user and send a text message notification
        User user = new User(1, "sampleUser", "securePassword", UserType.CUSTOMER, "9876543210", "sample@example.com", true);
        String message = "Sample text message";
        ContactType contactType = ContactType.TEXT;

        notificationService.sendNotification(user, message, contactType);

        // Verify that the notification was sent and stored
        List<String> notifications = notificationService.getNotifications(user.getId());
        assertTrue(notifications.contains(message));
    }

    @Test
    public void testGetNotifications() {
        // Set up a user and send multiple notifications
        User user = new User(1, "sampleUser", "securePassword", UserType.CUSTOMER, "9876543210", "sample@example.com", true);
        String message1 = "Sample email message 1";
        String message2 = "Sample email message 2";
        ContactType contactType = ContactType.EMAIL;

        notificationService.sendNotification(user, message1, contactType);
        notificationService.sendNotification(user, message2, contactType);

        // Retrieve notifications and verify the number and content
        List<String> notifications = notificationService.getNotifications(user.getId());
        assertEquals(2, notifications.size());
        assertTrue(notifications.contains(message1));
        assertTrue(notifications.contains(message2));
    }
}
