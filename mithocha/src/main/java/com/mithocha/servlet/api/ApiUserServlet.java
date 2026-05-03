package com.mithocha.servlet.api;

import com.google.gson.JsonObject;
import com.mithocha.dao.ProfileDAO;
import com.mithocha.dao.UserDAO;
import com.mithocha.dao.impl.ProfileDAOImpl;
import com.mithocha.dao.impl.UserDAOImpl;
import com.mithocha.exception.ApiException;
import com.mithocha.model.Profile;
import com.mithocha.model.User;
import com.mithocha.util.ApiMapperUtil;
import com.mithocha.util.ValidationUtil;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/api/users/*")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 6 * 1024 * 1024
)
public class ApiUserServlet extends BaseApiServlet {

    private final UserDAO userDAO = new UserDAOImpl();
    private final ProfileDAO profileDAO = new ProfileDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        ensureMePath(request.getPathInfo());
        User user = requireAuthenticatedUser(request);
        Profile profile = profileDAO.findByUserId(user.getUserId());
        writeSuccess(response, HttpServletResponse.SC_OK, ApiMapperUtil.toUserProfile(user, profile));
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        ensureMePath(request.getPathInfo());
        User user = requireAuthenticatedUser(request);

        String contentType = request.getContentType();
        if (contentType != null && contentType.toLowerCase().startsWith("multipart/form-data")) {
            handleMultipartUpdate(request, response, user);
            return;
        }
        handleJsonUpdate(request, response, user);
    }

    private void handleJsonUpdate(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        JsonObject body = readJsonBody(request);
        updateProfileAndUser(
                user,
                requireString(body, "name"),
                requireString(body, "email").toLowerCase(),
                optionalString(body, "phone"),
                optionalString(body, "address"),
                optionalString(body, "city"),
                optionalString(body, "postalCode"),
                optionalString(body, "bio"),
                optionalString(body, "dateOfBirth"),
                null,
                null
        );

        Profile updatedProfile = profileDAO.findByUserId(user.getUserId());
        writeSuccess(response, HttpServletResponse.SC_OK, ApiMapperUtil.toUserProfile(userDAO.findById(user.getUserId()), updatedProfile));
    }

    private void handleMultipartUpdate(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        Part imagePart;
        try {
            imagePart = request.getPart("profileImage");
        } catch (Exception ex) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, "Invalid multipart request.");
        }

        byte[] imageBytes = readPartBytes(imagePart);
        String imageType = imagePart != null ? imagePart.getContentType() : null;
        if (imageBytes != null) {
            ensure(ValidationUtil.isSupportedImageContentType(imageType),
                    HttpServletResponse.SC_BAD_REQUEST, "Unsupported profile image type.");
        }

        updateProfileAndUser(
                user,
                requiredFormField(request, "name"),
                requiredFormField(request, "email").toLowerCase(),
                request.getParameter("phone"),
                request.getParameter("address"),
                request.getParameter("city"),
                request.getParameter("postalCode"),
                request.getParameter("bio"),
                request.getParameter("dateOfBirth"),
                imageBytes,
                imageType
        );

        Profile updatedProfile = profileDAO.findByUserId(user.getUserId());
        writeSuccess(response, HttpServletResponse.SC_OK, ApiMapperUtil.toUserProfile(userDAO.findById(user.getUserId()), updatedProfile));
    }

    private void updateProfileAndUser(User currentUser, String name, String email,
                                      String phone, String address, String city,
                                      String postalCode, String bio, String dateOfBirth,
                                      byte[] imageBytes, String imageType) {
        ensure(!ValidationUtil.isNullOrEmpty(name), HttpServletResponse.SC_BAD_REQUEST, "Name is required.");
        ensure(ValidationUtil.isValidEmail(email), HttpServletResponse.SC_BAD_REQUEST, "A valid email is required.");
        ensure(ValidationUtil.isValidPhone(phone), HttpServletResponse.SC_BAD_REQUEST, "Invalid phone number.");
        ensure(!userDAO.emailExistsForOtherUser(currentUser.getUserId(), email),
                HttpServletResponse.SC_CONFLICT, "That email address is already in use.");

        currentUser.setName(name.trim());
        currentUser.setEmail(email.trim().toLowerCase());
        userDAO.updateUser(currentUser);

        Profile profile = profileDAO.findByUserId(currentUser.getUserId());
        if (profile == null) {
            profile = new Profile();
            profile.setUserId(currentUser.getUserId());
        }

        profile.setPhone(ValidationUtil.trimToNull(phone));
        profile.setAddress(ValidationUtil.trimToNull(address));
        profile.setCity(ValidationUtil.trimToNull(city));
        profile.setPostalCode(ValidationUtil.trimToNull(postalCode));
        profile.setBio(ValidationUtil.trimToNull(bio));
        profile.setDateOfBirth(parseDate(dateOfBirth));

        if (imageBytes != null) {
            profile.setProfileImageUrl(null);
            profile.setProfileImageData(imageBytes);
            profile.setProfileImageContentType(imageType);
        }

        if (profile.getProfileId() > 0 || profileDAO.findByUserId(currentUser.getUserId()) != null) {
            profileDAO.updateProfile(profile);
        } else {
            profileDAO.insertProfile(profile);
        }
    }

    private void ensureMePath(String pathInfo) {
        ensure("/me".equals(pathInfo) || "/me/".equals(pathInfo),
                HttpServletResponse.SC_NOT_FOUND, "User route not found.");
    }

    private String requiredFormField(HttpServletRequest request, String field) {
        String value = request.getParameter(field);
        ensure(!ValidationUtil.isNullOrEmpty(value), HttpServletResponse.SC_BAD_REQUEST, field + " is required.");
        return value.trim();
    }

    private Date parseDate(String rawValue) {
        if (ValidationUtil.isNullOrEmpty(rawValue)) {
            return null;
        }
        try {
            return Date.valueOf(rawValue.trim());
        } catch (IllegalArgumentException ex) {
            throw new ApiException(HttpServletResponse.SC_BAD_REQUEST, "dateOfBirth must use YYYY-MM-DD format.");
        }
    }
}
