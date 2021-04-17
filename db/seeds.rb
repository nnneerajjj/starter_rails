# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts 'Seeding database...'

ActiveRecord::Base.transaction do
  # Admin user
  User.create!(first_name: 'Admin', last_name: 'User', email: 'admin@example.com', password: 'password', role: 'admin')
  # Standard user
  User.create!(first_name: 'Test', last_name: 'User', email: 'user@example.com', password: 'password')
rescue StandardError => e
  puts 'Seeding failed!', e.message, 'Rolling back changes...'
  raise ActiveRecord::Rollback
else
  puts 'Seeded successfully!'
end
