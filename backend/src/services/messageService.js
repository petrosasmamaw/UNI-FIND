const Message = require('../models/Message');

const createMessage = async ({ roomId, senderId, content }) => {
  const msg = new Message({ roomId, senderId, content });
  return msg.save();
};

const getMessagesByRoom = async (roomId) => {
  return Message.find({ roomId }).sort({ createdAt: 1 }).lean();
};

module.exports = { createMessage, getMessagesByRoom };
