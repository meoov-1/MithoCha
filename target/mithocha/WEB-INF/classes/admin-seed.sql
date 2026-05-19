-- ============================================================
-- MithoCha — Admin User Seed Script
-- Run this once against your MithoCha database.
--
-- Credentials:
--   Email    : admin@gmail.com
--   Password : admin   (plain text — hashed by the app on first login)
--
-- The app auto-creates this row on first login via UserService.ensureAdminExists().
-- Run this script only if you want the row pre-seeded in the DB.
-- ============================================================

USE MithoCha;

INSERT INTO users (name, email, password, role)
VALUES ('Admin', 'admin@gmail.com', 'PLAIN:admin', 'admin')
ON DUPLICATE KEY UPDATE role = 'admin';

-- NOTE: The password stored above is a placeholder.
-- On the very first login with admin@gmail.com / admin, UserService will:
--   1. Detect the row exists
--   2. Verify via the hardcoded credential check (bypasses hash)
--   3. Leave the hash as-is (the app never re-hashes on admin shortcut login)
-- The admin can log in immediately without running this script at all —
-- UserService.ensureAdminExists() creates the row automatically.
