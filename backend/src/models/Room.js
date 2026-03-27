const mongoose = require('mongoose');

const RoomSchema = new mongoose.Schema({
  itemId: { type: mongoose.Schema.Types.ObjectId, ref: 'Item', required: true, index: true },
  participants: [{ type: String, required: true }],
}, { timestamps: true });

module.exports = mongoose.model('Room', RoomSchema);
