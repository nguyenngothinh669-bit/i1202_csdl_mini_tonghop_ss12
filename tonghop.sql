-- Tổng hợp code mn 

-- REQ -01 
CREATE VIEW view_user_info AS
SELECT user_id, username, email, created_at
FROM users; 
