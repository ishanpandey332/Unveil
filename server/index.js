const express = require('express')
const cors = require('cors')
require('dotenv').config()

const authRoutes = require('./routes/auth')
const detectRoutes = require('./routes/detect')

const app = express()

app.use(cors())
app.use(express.json({ limit: '10mb' }))
app.use(express.urlencoded({ extended: true, limit: '10mb' }))

app.use('/api/auth', authRoutes)
app.use('/api/detect', detectRoutes)

app.get('/', (req, res) => {
  res.json({ message: 'Unveil API is running 🚀' })
})

const PORT = process.env.PORT || 5000
app.listen(PORT, () => {
  console.log(`✅ Server running on port ${PORT}`)
})

const supabase = require('./config/supabase')

// Add this temporarily after app is created
supabase.from('profiles').select('count').then(({data, error}) => {
  if (error) console.log('❌ Supabase error:', error.message)
  else console.log('✅ Supabase connected!')
})