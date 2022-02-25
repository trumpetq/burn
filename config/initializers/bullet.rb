if Rails.env.development?
  Bullet.enable = true
  Bullet.add_footer = true
  Bullet.bullet_logger = false
end
