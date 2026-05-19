package com.mithocha.dao;

import com.mithocha.model.Profile;

/**
 * ProfileDAO – contract for all profile-related database operations.
 */
public interface ProfileDAO {

    /** Insert a new profile row. Returns generated profile_id, or -1 on failure. */
    int insertProfile(Profile profile);

    /** Find a profile by user_id (one-to-one with users). */
    Profile findByUserId(int userId);

    /** Update all profile fields for a given user_id. */
    boolean updateProfile(Profile profile);

    /** Delete a profile by user_id. */
    boolean deleteByUserId(int userId);
}
