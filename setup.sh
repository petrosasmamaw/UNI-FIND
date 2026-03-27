#!/bin/bash
# UNIFIND Project Setup Helper Script
# Run this script to setup the entire project

set -e  # Exit on error

echo "🚀 UNIFIND Setup Helper"
echo "======================="
echo ""

# Check prerequisites
echo "✓ Checking prerequisites..."
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+ from https://nodejs.org/"
    exit 1
fi

if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed."
    exit 1
fi

echo "✓ Node.js $(node --version) and npm $(npm --version) found"
echo ""

# Setup Backend
echo "📦 Setting up Backend..."
cd backend

if [ ! -f ".env" ]; then
    echo "❌ .env file not found in backend/"
    echo "Please create backend/.env with the following variables:"
    echo "PORT=5000"
    echo "MONGO_URI=your_mongodb_connection_string"
    echo "CLOUDINARY_CLOUD_NAME=your_cloud_name"
    echo "CLOUDINARY_API_KEY=your_api_key"
    echo "CLOUDINARY_API_SECRET=your_api_secret"
    exit 1
fi

echo "✓ Installing backend dependencies..."
npm install > /dev/null 2>&1

echo "✓ Backend setup complete"
cd ..

# Setup Frontend
echo ""
echo "🎨 Setting up Frontend..."
cd FrontendFindItems

if [ ! -f ".env.local" ]; then
    echo "⚠️  .env.local not found. Creating with defaults..."
    cat > .env.local << EOF
NEXT_PUBLIC_API_URL=http://localhost:5000
NEXT_PUBLIC_AUTH_BASE_URL=http://localhost:3000
DATABASE_URL=postgresql://postgres:password@localhost:5432/unifind
BETTER_AUTH_SECRET=change-this-to-random-string-in-production
EOF
    echo "✓ Created .env.local (please update with your values)"
fi

echo "✓ Installing frontend dependencies..."
npm install > /dev/null 2>&1

echo "✓ Generating Prisma client..."
npx prisma generate > /dev/null 2>&1

echo "✓ Frontend setup complete"
cd ..

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Update backend/.env with your MongoDB and Cloudinary credentials"
echo "2. Update FrontendFindItems/.env.local with your database URL and BETTER_AUTH_SECRET"
echo "3. Setup PostgreSQL database: psql -U postgres -c 'CREATE DATABASE unifind;'"
echo "4. Run Prisma migrations: cd FrontendFindItems && npx prisma migrate dev"
echo ""
echo "🚀 To start development:"
echo "   Terminal 1 (Backend): cd backend && npm run dev"
echo "   Terminal 2 (Frontend): cd FrontendFindItems && npm run dev"
echo ""
echo "Open http://localhost:3000 in your browser"
