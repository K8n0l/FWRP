package service.impl;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;
import entity.User;
import util.LoginResult;
import util.UserType;

public class UserServiceImplTest {

    private UserServiceImpl userService;

    @Before
    public void setUp() {
        userService = new UserServiceImpl();
    }

    @Test
    public void testLoginSuccess() {
        // Set up a user with specific credentials
        User user = new User(123, "sampleUser", "securePassword123", UserType.CUSTOMER, "6132222222", "sample@example.com", true);
        userService.register(user);

        // Attempt to log in with correct credentials
        LoginResult result = userService.login("sampleUser", "securePassword123");

        // Verify that login was successful
        assertEquals(LoginResult.SUCCESS, result);
    }

    @Test
    public void testLoginUserNotFound() {
        // Try logging in with a username that doesn't exist
        LoginResult result = userService.login("unknownUser", "securePassword123");

        // Check that the result indicates the user was not found
        assertEquals(LoginResult.USER_NOT_FOUND, result);
    }

    @Test
    public void testLoginInvalidPassword() {
        // Register a user with known credentials
        User user = new User(123, "sampleUser", "securePassword123", UserType.CUSTOMER, "6132222222", "sample@example.com", true);
        userService.register(user);

        // Attempt to log in with an incorrect password
        LoginResult result = userService.login("sampleUser", "wrongPassword");

        // Confirm that the result indicates an invalid password
        assertEquals(LoginResult.INVALID_PASSWORD, result);
    }

    @Test
    public void testRegisterExistingUser() {
        // Register a user for the first time
        User user = new User(123, "sampleUser", "securePassword123", UserType.CUSTOMER, "6132222222", "sample@example.com", true);
        userService.register(user);

        // Try to register the same user again
        boolean registeredAgain = userService.register(user);

        // Check that the second registration attempt failed
        assertFalse(registeredAgain);
    }
}
