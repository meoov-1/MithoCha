package com.mithocha.model;

import com.mithocha.util.ValidationUtil;

import java.sql.Date;
import java.util.Base64;

/**
 * POJO for the `profile` table.
 *
 * CREATE TABLE profile (
 *   profile_id        INT AUTO_INCREMENT PRIMARY KEY,
 *   user_id           INT UNIQUE NOT NULL,
 *   phone             VARCHAR(20),
 *   address           TEXT,
 *   city              VARCHAR(100),
 *   postal_code       VARCHAR(20),
 *   profile_image_url VARCHAR(500),
 *   cover_image_url   VARCHAR(500),
 *   bio               TEXT,
 *   date_of_birth     DATE,
 *   FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
 * );
 */
public class Profile {

    private int    profileId;
    private int    userId;
    private String phone;
    private String address;
    private String city;
    private String postalCode;
    private String profileImageUrl;
    private byte[] profileImageData;
    private String profileImageContentType;
    private String coverImageUrl;
    private String bio;
    private Date   dateOfBirth;

    // ── Constructors ──────────────────────────────────────────────────────────

    public Profile() {}

    public Profile(int userId, String phone, String address, String city,
                   String postalCode, String profileImageUrl, String coverImageUrl,
                   String bio, Date dateOfBirth) {
        this.userId          = userId;
        this.phone           = phone;
        this.address         = address;
        this.city            = city;
        this.postalCode      = postalCode;
        this.profileImageUrl = profileImageUrl;
        this.coverImageUrl   = coverImageUrl;
        this.bio             = bio;
        this.dateOfBirth     = dateOfBirth;
    }

    public Profile(int profileId, int userId, String phone, String address,
                   String city, String postalCode, String profileImageUrl,
                   String coverImageUrl, String bio, Date dateOfBirth) {
        this(userId, phone, address, city, postalCode,
             profileImageUrl, coverImageUrl, bio, dateOfBirth);
        this.profileId = profileId;
    }

    // ── Getters & Setters ─────────────────────────────────────────────────────

    public int getProfileId()                        { return profileId; }
    public void setProfileId(int profileId)          { this.profileId = profileId; }

    public int getUserId()                           { return userId; }
    public void setUserId(int userId)                { this.userId = userId; }

    public String getPhone()                         { return phone; }
    public void setPhone(String phone)               { this.phone = phone; }

    public String getAddress()                       { return address; }
    public void setAddress(String address)           { this.address = address; }

    public String getCity()                          { return city; }
    public void setCity(String city)                 { this.city = city; }

    public String getPostalCode()                    { return postalCode; }
    public void setPostalCode(String postalCode)     { this.postalCode = postalCode; }

    public String getProfileImageUrl() {
        if (!ValidationUtil.isNullOrEmpty(profileImageUrl)) {
            return profileImageUrl;
        }
        if (profileImageData != null && profileImageData.length > 0
                && !ValidationUtil.isNullOrEmpty(profileImageContentType)) {
            return "data:" + profileImageContentType + ";base64,"
                    + Base64.getEncoder().encodeToString(profileImageData);
        }
        return null;
    }
    public void setProfileImageUrl(String profileImageUrl)       { this.profileImageUrl = profileImageUrl; }
    public String getStoredProfileImageUrl()                     { return profileImageUrl; }

    public byte[] getProfileImageData()                          { return profileImageData; }
    public void setProfileImageData(byte[] profileImageData)     { this.profileImageData = profileImageData; }

    public String getProfileImageContentType()                   { return profileImageContentType; }
    public void setProfileImageContentType(String profileImageContentType) {
        this.profileImageContentType = profileImageContentType;
    }

    public String getCoverImageUrl()                             { return coverImageUrl; }
    public void setCoverImageUrl(String coverImageUrl)           { this.coverImageUrl = coverImageUrl; }

    public String getBio()                           { return bio; }
    public void setBio(String bio)                   { this.bio = bio; }

    public Date getDateOfBirth()                     { return dateOfBirth; }
    public void setDateOfBirth(Date dateOfBirth)     { this.dateOfBirth = dateOfBirth; }

    @Override
    public String toString() {
        return "Profile{profileId=" + profileId + ", userId=" + userId
                + ", city='" + city + "'}";
    }
}
