# Create or promote the initial Admin user without resetting an existing password.
admin = User.find_or_initialize_by(email: "admin@email.com")
admin.role = "admin"
if admin.new_record?
  admin.password = "123123"
  admin.password_confirmation = "123123"
end
admin.save!

puts "Seed completed! Admin user ready: admin@email.com"
