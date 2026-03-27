const mongoose = require('mongoose');

const ItemSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: { type: String },
  category: { type: String, index: true },
  type: { type: String, enum: ['lost','found'], required: true, index: true },
  location: { type: String },
  imageUrl: { type: String },
  userId: { type: String, required: true, index: true },
}, { timestamps: true });

module.exports = mongoose.model('Item', ItemSchema);
