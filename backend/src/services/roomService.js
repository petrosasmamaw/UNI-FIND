const Room = require('../models/Room');

const findRoomForItemAndUsers = async (itemId, userA, userB) => {
  // participants stored as strings (userIds). Find room matching itemId and both participants
  return Room.findOne({
    itemId,
    participants: { $all: [userA, userB] }
  }).populate('itemId').lean();
};

const createRoom = async (itemId, participants) => {
  const room = new Room({ itemId, participants });
  return room.save();
};

const getRoomById = async (id) => {
  return Room.findById(id).populate('itemId').lean();
};

const getRoomsForUser = async (userId) => {
  return Room.find({ participants: userId }).populate('itemId').sort({ updatedAt: -1 }).lean();
};

const getRoomsByItemId = async (itemId) => {
  return Room.find({ itemId }).populate('itemId').sort({ updatedAt: -1 }).lean();
};

module.exports = { findRoomForItemAndUsers, createRoom, getRoomById, getRoomsForUser, getRoomsByItemId };
