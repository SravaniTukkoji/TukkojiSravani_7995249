USE Module2DB;

-- 1. User Upcoming Events
SELECT u.full_name, e.title, e.city, e.start_date
FROM Users u
JOIN Registrations r ON u.user_id = r.user_id
JOIN Events e ON r.event_id = e.event_id
WHERE e.status = 'upcoming' AND u.city = e.city;

-- 2. Top Rated Events
SELECT e.title, AVG(f.rating) avg_rating
FROM Events e
JOIN Feedback f ON e.event_id = f.event_id
GROUP BY e.event_id;

-- 3. Inactive Users
SELECT * FROM Users
WHERE user_id NOT IN (
SELECT user_id FROM Registrations WHERE registration_date >= CURDATE() - INTERVAL 90 DAY
);

-- 4. Peak Session Hours
SELECT e.title, COUNT(*) sessions
FROM Events e JOIN Sessions s ON e.event_id=s.event_id
WHERE TIME(start_time) BETWEEN '10:00:00' AND '12:00:00'
GROUP BY e.event_id;

-- 5. Most Active Cities
SELECT city, COUNT(*) FROM Users GROUP BY city;

-- 6. Event Resource Summary
SELECT e.title,
SUM(resource_type='pdf') pdfs,
SUM(resource_type='image') images,
SUM(resource_type='link') links
FROM Events e LEFT JOIN Resources r ON e.event_id=r.event_id
GROUP BY e.event_id;

-- 7. Low Feedback
SELECT * FROM Feedback WHERE rating < 3;

-- 8. Sessions per Event
SELECT e.title, COUNT(s.session_id)
FROM Events e LEFT JOIN Sessions s ON e.event_id=s.event_id
GROUP BY e.event_id;

-- 9. Organizer Summary
SELECT u.full_name, e.status, COUNT(*)
FROM Users u JOIN Events e ON u.user_id=e.organizer_id
GROUP BY u.full_name,e.status;

-- 10. Feedback Gap
SELECT title FROM Events e
LEFT JOIN Feedback f ON e.event_id=f.event_id
WHERE f.feedback_id IS NULL;

-- 11. New Users (7 days)
SELECT registration_date, COUNT(*)
FROM Users GROUP BY registration_date;

-- 12. Max Sessions Event
SELECT event_id FROM Sessions GROUP BY event_id
ORDER BY COUNT(*) DESC LIMIT 1;

-- 13. Avg Rating per City
SELECT e.city, AVG(f.rating)
FROM Events e JOIN Feedback f ON e.event_id=f.event_id
GROUP BY e.city;

-- 14. Top Events
SELECT e.title, COUNT(*) reg
FROM Events e JOIN Registrations r ON e.event_id=r.event_id
GROUP BY e.event_id ORDER BY reg DESC LIMIT 3;

-- 15. Session Conflict
SELECT s1.event_id
FROM Sessions s1 JOIN Sessions s2
ON s1.event_id=s2.event_id AND s1.session_id<s2.session_id
WHERE s1.start_time<s2.end_time AND s2.start_time<s1.end_time;

-- 16. Unregistered Users
SELECT * FROM Users
WHERE user_id NOT IN (SELECT user_id FROM Registrations);

-- 17. Multi Speaker
SELECT speaker_name, COUNT(*) FROM Sessions GROUP BY speaker_name;

-- 18. No Resources
SELECT title FROM Events e
LEFT JOIN Resources r ON e.event_id=r.event_id
WHERE r.resource_id IS NULL;

-- 19. Completed Events
SELECT e.title, AVG(f.rating)
FROM Events e LEFT JOIN Feedback f ON e.event_id=f.event_id
WHERE status='completed'
GROUP BY e.event_id;

-- 20. Engagement
SELECT full_name,
COUNT(DISTINCT r.event_id),
COUNT(DISTINCT f.feedback_id)
FROM Users u
LEFT JOIN Registrations r ON u.user_id=r.user_id
LEFT JOIN Feedback f ON u.user_id=f.user_id
GROUP BY u.user_id;

-- 21. Top Feedback Users
SELECT u.full_name, COUNT(*)
FROM Users u JOIN Feedback f ON u.user_id=f.user_id
GROUP BY u.user_id ORDER BY COUNT(*) DESC LIMIT 5;

-- 22. Duplicate Registration
SELECT user_id,event_id,COUNT(*)
FROM Registrations GROUP BY user_id,event_id HAVING COUNT(*)>1;

-- 23. Trends
SELECT DATE_FORMAT(registration_date,'%Y-%m'), COUNT(*)
FROM Registrations GROUP BY 1;

-- 24. Session Duration
SELECT e.title, AVG(TIMESTAMPDIFF(MINUTE,start_time,end_time))
FROM Events e JOIN Sessions s ON e.event_id=s.event_id
GROUP BY e.event_id;

-- 25. Events Without Sessions
SELECT title FROM Events e
LEFT JOIN Sessions s ON e.event_id=s.event_id
WHERE s.session_id IS NULL;