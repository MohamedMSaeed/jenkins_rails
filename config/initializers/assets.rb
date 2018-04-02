# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

Rails.application.config.assets.precompile += %w( start.css )
Rails.application.config.assets.precompile += %w( magnific-popup.css )
Rails.application.config.assets.precompile += %w( owl.carousel.css )
Rails.application.config.assets.precompile += %w( owl.theme.css )
Rails.application.config.assets.precompile += %w( login.css )

Rails.application.config.assets.precompile += %w( add_friend_to_list.js )
Rails.application.config.assets.precompile += %w( add_friend.css )
Rails.application.config.assets.precompile += %w( display_groupMember.js )
Rails.application.config.assets.precompile += %w( jquery.js )
Rails.application.config.assets.precompile += %w( invite_friend.js )
Rails.application.config.assets.precompile += %w( orders.js )

Rails.application.config.assets.precompile += %w( channels/orders.js )
Rails.application.config.assets.precompile += %w( channels/orders.coffee )
Rails.application.config.assets.precompile += %w( home.js )

Rails.application.config.assets.precompile += %w( addOrder.js )

Rails.application.config.assets.precompile += %w( profile.css )
Rails.application.config.assets.precompile += %w( orders.css )
