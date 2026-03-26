const express = require('express')
const router = express.Router()
const { signup, login, getMe } = require('../controllers/authController')
const authMiddleware = require('../middleware/auth')
const { authLimiter } = require('../middleware/rateLimit')

// Auth routes with brute force protection
router.post('/signup', authLimiter, signup)
router.post('/login', authLimiter, login)
router.get('/me', authMiddleware, getMe)

module.exports = router