# UNIFIND - University Lost & Found Platform

A full-stack application for university students to report lost items, browse found items, and connect with each other through real-time messaging.

## 🎯 Features

✅ **User Authentication**
- Email/Password registration and login
- Social sign-in (Google, GitHub)
- Better Auth integration with PostgreSQL

✅ **Item Management**
- Post lost/found items with photos
- Categorize items (Electronics, Documents, Clothing, Accessories)
- Filter by type, category, and location
- Search functionality
- Pagination

✅ **Real-time Messaging**
- Create chat rooms when interested in items
- Send/receive messages
- View conversation history
- Multiple conversations support

✅ **Dashboard**
- View your posted items
- Manage your chat rooms
- Track conversations

## 🏗️ Tech Stack

### Backend
- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: MongoDB
- **ORM**: Mongoose
- **Image Upload**: Cloudinary
- **Authentication**: Better Auth (server-side)

### Frontend
- **Framework**: Next.js 16
- **UI Library**: React 19
- **State Management**: Redux Toolkit
- **Authentication**: Better Auth (client-side)
- **Database**: PostgreSQL (for auth sessions)
- **Styling**: Tailwind CSS
- **Package Manager**: npm

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ ([Download](https://nodejs.org/))
- MongoDB Account ([Create](https://www.mongodb.com/cloud/atlas))
- PostgreSQL ([Download](https://www.postgresql.org/))
- Cloudinary Account ([Create](https://cloudinary.com/))

### Installation

1. **Clone or download the project**
```bash
cd UNIFIND
```

2. **Windows Users**: Run setup script
```bash
# Or manually:
cd backend && npm install
cd ../FrontendFindItems && npm install
```

3. **Configure Environment Variables**

**Backend** (`backend/.env`):
```
PORT=5000
MONGO_URI=your_mongodb_connection_string
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
```

**Frontend** (`FrontendFindItems/.env.local`):
```
NEXT_PUBLIC_API_URL=http://localhost:5000
DATABASE_URL=postgresql://user:password@localhost:5432/unifind
BETTER_AUTH_SECRET=your-secret-key
```

4. **Setup Databases**

PostgreSQL:
```bash
createdb unifind
cd FrontendFindItems
npx prisma migrate dev
```

5. **Start Development Servers**

Terminal 1 - Backend:
```bash
cd backend
npm run dev
# Server runs on http://localhost:5000
```

Terminal 2 - Frontend:
```bash
cd FrontendFindItems
npm run dev
# App runs on http://localhost:3000
```

6. **Open in Browser**
```
http://localhost:3000
```

## 📖 Documentation

- [Production Setup Guide](./PRODUCTION_SETUP.md) - Deployment and configuration
- [API Testing Guide](./API_TESTING_GUIDE.md) - All API endpoints with examples
- [Troubleshooting Guide](./TROUBLESHOOTING.md) - Common issues and solutions

## 🔌 API Endpoints

### Items
- `POST /api/items` - Create item
- `GET /api/items` - List items (with filters)
- `GET /api/items/:id` - Get item details

### Chat Rooms
- `POST /api/rooms` - Create/get room
- `GET /api/rooms` - List user's rooms
- `GET /api/rooms/:id` - Get room details

### Messages
- `POST /api/messages` - Send message
- `GET /api/messages` - Get room's messages

See [API_TESTING_GUIDE.md](./API_TESTING_GUIDE.md) for detailed examples.

## 🐛 Troubleshooting

### Backend issues
```bash
# Clear modules and reinstall
cd backend
rm -rf node_modules package-lock.json
npm install
npm run dev
```

### Frontend issues
```bash
# Regenerate Prisma client
cd FrontendFindItems
npx prisma generate
npm install
npm run dev
```

### Database connection
- Verify MongoDB URL in `backend/.env`
- Verify PostgreSQL running and URL in `FrontendFindItems/.env.local`
- Check database credentials

See [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) for detailed solutions.

## 📁 Project Structure

```
UNIFIND/
├── backend/                    # Express.js + MongoDB backend
│   ├── src/
│   │   ├── app.js             # Express app configuration
│   │   ├── controllers/       # Request handlers
│   │   ├── models/            # MongoDB schemas
│   │   ├── routes/            # API routes
│   │   ├── services/          # Business logic
│   │   ├── middleware/        # Auth, error handling
│   │   └── config/            # DB, Cloudinary config
│   ├── server.js              # Entry point
│   └── package.json
│
├── FrontendFindItems/         # Next.js + React frontend
│   ├── src/
│   │   ├── app/               # Pages and routing
│   │   ├── components/        # React components
│   │   ├── lib/              # Utilities and auth
│   │   ├── store/            # Redux state
│   │   └── generated/        # Prisma generated
│   ├── prisma/
│   │   └── schema.prisma     # Database schema
│   └── package.json
│
├── PRODUCTION_SETUP.md        # Deployment guide
├── API_TESTING_GUIDE.md       # API documentation
├── TROUBLESHOOTING.md         # Common issues
└── README.md                  # This file
```

## 👤 User Workflow

1. **Register/Login** - Create account with email or social login
2. **Browse** - View lost/found items from other users
3. **Post** - Create new lost/found item with photo
4. **Message** - Click "Message" on item to start chat
5. **Connect** - Exchange information and arrange handoff
6. **Manage** - View your items and conversations in dashboard

## 🔐 Security Features

- ✅ JWT-based authentication via Better Auth
- ✅ CORS protection
- ✅ Input validation on all endpoints
- ✅ MongoDB injection protection
- ✅ Secure file upload handling
- ✅ Environment variables for sensitive data

## 📊 Database Schemas

### MongoDB - Item
```javascript
{
  title: String,
  description: String,
  category: String,
  type: String,  // 'lost' or 'found'
  location: String,
  imageUrl: String,
  userId: String,
  createdAt: Date,
  updatedAt: Date
}
```

### MongoDB - Room
```javascript
{
  itemId: ObjectId,
  participants: [String],  // userIds
  createdAt: Date,
  updatedAt: Date
}
```

### MongoDB - Message
```javascript
{
  roomId: ObjectId,
  senderId: String,
  content: String,
  createdAt: Date
}
```

### PostgreSQL - User (Better Auth)
```sql
CREATE TABLE "user" (
  id TEXT PRIMARY KEY,
  name TEXT,
  email TEXT UNIQUE NOT NULL,
  emailVerified BOOLEAN DEFAULT false,
  image TEXT,
  createdAt TIMESTAMP DEFAULT now(),
  updatedAt TIMESTAMP
);
```

## 🚢 Deployment

### Backend
- Heroku, Render, Railway, AWS, Digital Ocean
- Set environment variables
- Configure MongoDB Atlas

### Frontend
- Vercel (recommended), Netlify
- Auto-deploy from GitHub
- Set environment variables

See [PRODUCTION_SETUP.md](./PRODUCTION_SETUP.md) for detailed instructions.

## 📞 Support

For issues:
1. Check [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
2. Review [API_TESTING_GUIDE.md](./API_TESTING_GUIDE.md)
3. Check console/terminal for error messages
4. Verify environment variables are set correctly

## 📄 License

This project is open source and available under the MIT License.

## Made with ❤️

UNIFIND - Bringing the university community together!
