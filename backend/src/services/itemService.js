const Item = require('../models/Item');

const createItem = async (data) => {
  const item = new Item(data);
  return item.save();
};

const getItems = async ({ type, category, search, page = 1, limit = 20, userId } = {}) => {
  const query = {};
  if (type) query.type = type;
  if (category) query.category = category;
  if (userId) query.userId = userId;
  if (search) query.$or = [
    { title: { $regex: search, $options: 'i' } },
    { description: { $regex: search, $options: 'i' } }
  ];

  const skip = (page - 1) * limit;
  const [items, total] = await Promise.all([
    Item.find(query).sort({ createdAt: -1 }).skip(skip).limit(limit).lean(),
    Item.countDocuments(query)
  ]);

  return { items, total, page, limit };
};

const getItemById = async (id) => Item.findById(id).lean();

module.exports = { createItem, getItems, getItemById };
